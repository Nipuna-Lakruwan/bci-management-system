import 'package:flutter/material.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // (Storage service initialization is now handled by repositories)
  runApp(const App());
}

