// @ignoreProblemForFile always_declare_return_types
// @ignoreProblemForFile annotate_overrides
// @ignoreProblemForFile avoid_init_to_null
// @ignoreProblemForFile camel_case_types
// @ignoreProblemForFile cancel_subscriptions
// @ignoreProblemForFile constant_identifier_names
// @ignoreProblemForFile non_constant_identifier_names
// @ignoreProblemForFile empty_constructor_bodies
// @ignoreProblemForFile implementation_imports
// @ignoreProblemForFile library_prefixes
// @ignoreProblemForFile prefer_is_not_empty
// @ignoreProblemForFile type_annotate_public_apis
// @ignoreProblemForFile DEPRECATED_MEMBER_USE
// @ignoreProblemForFile STRONG_MODE_DOWN_CAST_COMPOSITE
// @ignoreProblemForFile UNUSED_IMPORT
// @ignoreProblemForFile UNUSED_SHOWN_NAME
// @ignoreProblemForFile UNUSED_LOCAL_VARIABLE
import 'fake_async.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'dart:async' show runZoned, ZoneSpecification;
import 'package:angular2/src/facade/exceptions.dart' show BaseException;
import 'package:quiver/testing/async.dart' as quiver;
import 'test_injector.dart' show getTestInjector, FunctionWithParamTokens;
import 'package:angular2/src/facade/exceptions.template.dart' as i0;
import 'test_injector.template.dart' as i1;
export 'fake_async.dart';

var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
}
