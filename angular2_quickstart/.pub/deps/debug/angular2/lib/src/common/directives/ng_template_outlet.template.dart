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
import 'ng_template_outlet.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:angular2/core.dart' show Directive, Input, ViewContainerRef, ViewRef, TemplateRef;
import 'package:angular2/src/facade/lang.dart' show isPresent;
import 'package:angular2/core.template.dart' as i0;
import 'package:angular2/src/facade/lang.template.dart' as i1;
export 'ng_template_outlet.dart';

var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
_ngRef.reflector
..registerType(NgTemplateOutlet, new _ngRef.ReflectionInfo(
const [],
const [const [ViewContainerRef]],
(ViewContainerRef _viewContainerRef) => new NgTemplateOutlet(_viewContainerRef))
)
;
i0.initReflector();
i1.initReflector();
}
