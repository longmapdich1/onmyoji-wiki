import 'package:shared_preferences/shared_preferences.dart';

abstract class WikiPreferences {
  Future initPreferences();

  final String shikiKey = 'shiki';

  Future<bool> clear();

  Future<bool> clearPreferences();

  String get shiki;

  void setShiki(String shiki);

}

class WikiPreferencesImpl extends WikiPreferences {
  late SharedPreferences _prefs;

  @override
  Future initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<bool> clear() async {
    await clearPreferences();
    return Future.value(true);
  }

  @override
  Future<bool> clearPreferences() {
    return _prefs.clear();
  }
  
  @override
  void setShiki(String shiki) {
    _prefs.setString(shikiKey, shiki);
  }
  
  @override
  String get shiki => _prefs.getString(shikiKey)??"";
}
