import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/auth/controller/auth_controller.dart';
import '../features/students/controller/student_controller.dart';
import '../features/students/repository/local_student_repository.dart';
import '../features/students/service/student_service.dart';
import '../features/courses/controller/course_controller.dart';
import '../features/courses/repository/local_course_repository.dart';
import '../features/courses/service/course_service.dart';
import '../features/enrolment/controller/enrolment_controller.dart';
import '../features/enrolment/repository/local_enrolment_repository.dart';
import '../features/employees/controller/employee_controller.dart';
import '../features/employees/data/employee_repository_impl.dart';
import '../features/hr/controller/hr_controller.dart';
import '../features/hr/data/hr_repository_impl.dart';
import '../core/storage/storage_service.dart';
import 'router.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => StudentController(StudentService(LocalStudentRepository()))),
        ChangeNotifierProvider(create: (_) => CourseController(CourseService(LocalCourseRepository()))),
        ChangeNotifierProvider(create: (_) => EnrolmentController(
          LocalEnrolmentRepository(),
          LocalStudentRepository(),
          LocalCourseRepository(),
        )),
        ChangeNotifierProvider(create: (_) => EmployeeController(EmployeeRepositoryImpl(StorageService()))),
        ChangeNotifierProvider(create: (_) => HrController(HrRepositoryImpl(StorageService()))),
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
