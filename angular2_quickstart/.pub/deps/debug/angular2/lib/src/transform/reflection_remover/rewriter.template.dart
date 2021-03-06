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
import 'rewriter.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:angular2/src/transform/common/logging.dart';
import 'package:angular2/src/transform/common/mirror_matcher.dart';
import 'package:angular2/src/transform/common/mirror_mode.dart';
import 'package:angular2/src/transform/common/names.dart';
import 'package:path/path.dart' as path;
import 'codegen.dart';
import 'entrypoint_matcher.dart';
import 'package:angular2/src/transform/common/logging.template.dart' as i0;
import 'package:angular2/src/transform/common/mirror_matcher.template.dart' as i1;
import 'package:angular2/src/transform/common/mirror_mode.template.dart' as i2;
import 'package:angular2/src/transform/common/names.template.dart' as i3;
import 'codegen.template.dart' as i4;
import 'entrypoint_matcher.template.dart' as i5;
export 'rewriter.dart';

var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
i2.initReflector();
i3.initReflector();
i4.initReflector();
i5.initReflector();
}
