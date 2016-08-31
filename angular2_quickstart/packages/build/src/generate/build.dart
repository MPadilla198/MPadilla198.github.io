// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';
import 'dart:io';

import 'package:code_transformers/resolver.dart';
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart';

import '../asset/reader.dart';
import '../asset/writer.dart';
import '../package_graph/package_graph.dart';
import '../server/server.dart';
import 'build_impl.dart';
import 'build_result.dart';
import 'directory_watcher_factory.dart';
import 'options.dart';
import 'phase.dart';
import 'watch_impl.dart';

/// Runs all of the [Phases] in [phaseGroups].
///
/// By default, the user will be prompted to delete any files which already
/// exist but were not generated by this specific build script. The
/// [deleteFilesByDefault] option can be set to [true] to skip this prompt.
///
/// A [packageGraph] may be supplied, otherwise one will be constructed using
/// [PackageGraph.forThisPackage]. The default functionality assumes you are
/// running in the root directory of a package, with both a `pubspec.yaml` and
/// `.packages` file present.
///
/// A [reader] and [writer] may also be supplied, which can read/write assets
/// to arbitrary locations or file systems. By default they will write directly
/// to the root package directory, and will use the [packageGraph] to know where
/// to read files from.
///
/// Logging may be customized by passing a custom [logLevel] below which logs
/// will be ignored, as well as an [onLog] handler which defaults to [print].
///
/// The [teminateEventStream] is a stream which can send termination events.
/// By default the [ProcessSignal.SIGINT] stream is used. In this mode, it
/// will simply consume the first event and allow the build to continue.
/// Multiple termination events will cause a normal shutdown.
Future<BuildResult> build(PhaseGroup phaseGroup,
    {bool deleteFilesByDefault,
    PackageGraph packageGraph,
    AssetReader reader,
    AssetWriter writer,
    Level logLevel,
    onLog(LogRecord record),
    Resolvers resolvers,
    Stream terminateEventStream}) async {
  var options = new BuildOptions(
      deleteFilesByDefault: deleteFilesByDefault,
      packageGraph: packageGraph,
      reader: reader,
      writer: writer,
      logLevel: logLevel,
      onLog: onLog,
      resolvers: resolvers);
  var buildImpl = new BuildImpl(options, phaseGroup);

  /// Run the build!
  var futureResult = buildImpl.runBuild();

  // Stop doing new builds when told to terminate.
  _setupTerminateLogic(terminateEventStream, () {
    new Logger('Build').info('Waiting for build to finish...');
    return futureResult;
  }, cancelWhen: futureResult);

  var result = await futureResult;
  options.logListener.cancel();
  return result;
}

/// Same as [build], except it watches the file system and re-runs builds
/// automatically.
///
/// The [debounceDelay] controls how often builds will run. As long as files
/// keep changing with less than that amount of time apart, builds will be put
/// off.
///
/// The [directoryWatcherFactory] allows you to inject a way of creating custom
/// [DirectoryWatcher]s. By default a normal [DirectoryWatcher] will be used.
///
/// The [terminateEventStream] is a stream which can send termination events.
/// By default the [ProcessSignal.SIGINT] stream is used. In this mode, the
/// first event will allow any ongoing builds to finish, and then the program
///  will complete normally. Subsequent events are not handled (and will
///  typically cause a shutdown).
Stream<BuildResult> watch(PhaseGroup phaseGroup,
    {bool deleteFilesByDefault,
    PackageGraph packageGraph,
    AssetReader reader,
    AssetWriter writer,
    Level logLevel,
    onLog(LogRecord record),
    Resolvers resolvers,
    Duration debounceDelay,
    DirectoryWatcherFactory directoryWatcherFactory,
    Stream terminateEventStream}) {
  var options = new BuildOptions(
      deleteFilesByDefault: deleteFilesByDefault,
      packageGraph: packageGraph,
      reader: reader,
      writer: writer,
      logLevel: logLevel,
      onLog: onLog,
      resolvers: resolvers,
      debounceDelay: debounceDelay,
      directoryWatcherFactory: directoryWatcherFactory);
  var watchImpl = new WatchImpl(options, phaseGroup);

  var resultStream = watchImpl.runWatch();

  // Stop doing new builds when told to terminate.
  _setupTerminateLogic(terminateEventStream, () async {
    await watchImpl.terminate();
  }, cancelWhen: watchImpl.onTerminated);

  watchImpl.onTerminated.then((_) {
    options.logListener.cancel();
  });

  return resultStream;
}

/// Same as [watch], except it also provides a server.
///
/// This server will block all requests if a build is current in process.
///
/// By default a static server will be set up to serve [directory] at
/// [address]:[port], but instead a [requestHandler] may be provided for custom
/// behavior.
Stream<BuildResult> serve(PhaseGroup phaseGroup,
    {bool deleteFilesByDefault,
    PackageGraph packageGraph,
    AssetReader reader,
    AssetWriter writer,
    Level logLevel,
    onLog(LogRecord record),
    Resolvers resolvers,
    Duration debounceDelay,
    DirectoryWatcherFactory directoryWatcherFactory,
    Stream terminateEventStream,
    String directory,
    String address,
    int port,
    Handler requestHandler}) {
  var options = new BuildOptions(
      deleteFilesByDefault: deleteFilesByDefault,
      packageGraph: packageGraph,
      reader: reader,
      writer: writer,
      logLevel: logLevel,
      onLog: onLog,
      resolvers: resolvers,
      debounceDelay: debounceDelay,
      directoryWatcherFactory: directoryWatcherFactory,
      directory: directory,
      address: address,
      port: port);
  var watchImpl = new WatchImpl(options, phaseGroup);

  var resultStream = watchImpl.runWatch();
  var serverStarted = startServer(watchImpl, options);

  // Stop doing new builds when told to terminate.
  _setupTerminateLogic(terminateEventStream, () async {
    await watchImpl.terminate();
  }, cancelWhen: watchImpl.onTerminated);

  watchImpl.onTerminated.then((_) async {
    await serverStarted;
    await stopServer();
    options.logListener.cancel();
  });

  return resultStream;
}

/// Given [terminateEventStream], call [onTerminate] the first time an event is
/// seen. If a second event is received, simply exit.
StreamSubscription _setupTerminateLogic(
    Stream terminateEventStream, Future onTerminate(),
    {Future cancelWhen}) {
  terminateEventStream ??= ProcessSignal.SIGINT.watch();
  int numEventsSeen = 0;
  var terminateListener;
  terminateListener = terminateEventStream.listen((_) {
    numEventsSeen++;
    if (numEventsSeen == 1) {
      onTerminate().then((_) {
        terminateListener.cancel();
      });
    } else {
      exit(2);
    }
  });

  cancelWhen?.then((_) {
    terminateListener.cancel();
  });
  return terminateListener;
}
