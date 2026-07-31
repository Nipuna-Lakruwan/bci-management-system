import 'package:flutter/material.dart';

// Import screens (will update these imports as features are built)
import '../screens/auth/login_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
// import '../features/students/view/student_list_screen.dart';
// import '../features/courses/view/course_list_screen.dart';

class AppRouter {
  static const String loginRoute = '/login';
  static const String dashboardRoute = '/dashboard';
  static const String studentListRoute = '/students';
  static const String courseListRoute = '/courses';
  static const String enrolmentRoute = '/enrolment';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      // case studentListRoute:
      //   return MaterialPageRoute(builder: (_) => const StudentListScreen());
      // case courseListRoute:
      //   return MaterialPageRoute(builder: (_) => const CourseListScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
