import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:angular2/angular2.dart';
import 'package:polymer/polymer.dart';
export 'package:polymer/init.dart';
import 'package:paper_elements/paper_button.dart';
import 'package:core_elements/core_selector.dart';
import 'package:core_elements/core_item.dart';

// These imports will go away soon:
import 'package:angular2/src/reflection/reflection.dart' show reflector;
import 'package:angular2/src/reflection/reflection_capabilities.dart' show ReflectionCapabilities;

@Component(
    selector: 'my-app'
)
@View(
    template: '''
<h1>Hello {{ name }}</h1>
<paper-button (click)="toggleRaised()" [raised]="raised">Click to toggle raised state!</paper-button>
<core-selector (core-select)="itemSelected()">
  <core-item *for="#message of messages">
    <div>{{message}}</div>
  </core-item>
</core-selector>
''',
    directives: const [For]
)
class AppComponent {
  String name = 'Alice';
  bool raised = false;
  List<String> messages = ['foo', 'bar', 'baz'];

  toggleRaised() => raised = !raised;

  itemSelected() => print('item selected - from AppComponent');
}

@whenPolymerReady
init() async {
  // Temporarily needed.
  reflector.reflectionCapabilities = new ReflectionCapabilities();

  await bootstrap(AppComponent);

  document.on['core-select'].listen((_) {
    print('item selected - from document');
  });
}