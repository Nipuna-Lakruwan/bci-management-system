import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/controller/auth_controller.dart';
import '../features/students/controller/student_controller.dart';
import '../features/students/repository/local_student_repository.dart';
import 'router.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => StudentController(LocalStudentRepository())),
      ],
      child: MaterialApp(
        title: 'BCI Management System',
        theme: AppTheme.lightTheme,
        initialRoute: AppRouter.loginRoute,
        onGenerateRoute: AppRouter.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
