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
import 'shared_styles_host.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:angular2/src/core/di.dart' show Inject, Injectable;
import 'package:angular2/src/facade/collection.dart' show SetWrapper;
import 'package:angular2/src/platform/dom/dom_adapter.dart' show DOM;
import 'dom_tokens.dart' show DOCUMENT;
import 'package:angular2/src/core/di.template.dart' as i0;
import 'package:angular2/src/facade/collection.template.dart' as i1;
import 'package:angular2/src/platform/dom/dom_adapter.template.dart' as i2;
import 'dom_tokens.template.dart' as i3;
export 'shared_styles_host.dart';

var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
_ngRef.reflector
..registerType(SharedStylesHost, new _ngRef.ReflectionInfo(
const [const Injectable()],
const [],
() => new SharedStylesHost())
)
..registerType(DomSharedStylesHost, new _ngRef.ReflectionInfo(
const [const Injectable()],
const [const [dynamic, const Inject(DOCUMENT)]],
(dynamic doc) => new DomSharedStylesHost(doc))
)
;
i0.initReflector();
i1.initReflector();
i2.initReflector();
i3.initReflector();
}
