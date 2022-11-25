import 'package:flutter/material.dart';
import 'package:onmyoji_wiki/repository/preferences.dart';
import 'package:onmyoji_wiki/wiki_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WikiPreferences preferences = WikiPreferencesImpl();
  await preferences.initPreferences();
  runApp(const WikiApp());
}

