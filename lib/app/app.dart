import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/controller/auth_controller.dart';
import '../features/students/controller/student_controller.dart';
import '../features/students/repository/local_student_repository.dart';
import '../features/courses/controller/course_controller.dart';
import '../features/courses/repository/local_course_repository.dart';
import '../features/enrolment/controller/enrolment_controller.dart';
import '../features/enrolment/repository/local_enrolment_repository.dart';
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
        ChangeNotifierProvider(create: (_) => CourseController(LocalCourseRepository())),
        ChangeNotifierProvider(create: (_) => EnrolmentController(LocalEnrolmentRepository())),
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
