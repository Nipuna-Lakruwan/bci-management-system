import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'core/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.loadData();
  runApp(const BCIManagementSystem());
}

class BCIManagementSystem extends StatelessWidget {
  const BCIManagementSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BCI Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A), // A professional dark blue for BCI
          secondary: const Color(0xFFF59E0B), // Amber accent
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
