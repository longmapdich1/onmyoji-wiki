import 'package:flutter/material.dart';
import 'package:onmyoji_wiki/wiki_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const supabaseUrl = 'https://jjloxsykwrunauxxkdhl.supabase.co';

  const supabaseKey =  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpqbG94c3lrd3J1bmF1eHhrZGhsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2Njk5NDc3OTYsImV4cCI6MTk4NTUyMzc5Nn0.WWeewEV1kKtT7hbrfdBG0g3v3wWc9Dnshob2sEzNQ2g';

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const WikiApp());
}
