import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:onmyoji_wiki/repository/preferences.dart';

class Injection {
  static late Injector injector;

  static late WikiPreferences preferences;

  static initInjection(WikiPreferences _prefs) {
    preferences = _prefs;
    injector = Injector("onmyoji-wiki");
  }

  static dispose() {
    injector.dispose();
  }
}
