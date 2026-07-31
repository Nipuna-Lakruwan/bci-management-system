import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/students/controller/student_controller.dart';
import '../../features/courses/controller/course_controller.dart';
import '../../features/enrolment/controller/enrolment_controller.dart';
import '../../features/employees/controller/employee_controller.dart';
import '../../features/employees/presentation/employee_list_screen.dart';
import '../../app/router.dart';
import '../../app/theme.dart';
import '../hr/payroll_screen.dart';
import '../hr/leave_management_screen.dart';
import '../hr/employee_attendance_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.watch<AuthController>().currentUser?.role ?? 'Admin';
    final name = context.watch<AuthController>().currentUser?.name ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('BCI Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthController>().logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF1E3A8A)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.account_circle, size: 60, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(name, style: const TextStyle(color: Colors.white, fontSize: 18)),
                  Text(role, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Students'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.studentListRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Courses'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRouter.courseListRoute);
              },
            ),
            if (role == 'Admin' || role == 'HR') ...[
              ListTile(
                leading: const Icon(Icons.badge),
                title: const Text('Employees'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeListScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.co_present),
                title: const Text('Staff Attendance'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeAttendanceScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.event_busy),
                title: const Text('Leave Requests'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaveManagementScreen()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.payments_outlined),
                title: const Text('Payroll'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PayrollScreen()));
                },
              ),
            ],
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                context.read<AuthController>().logout();
                Navigator.pushReplacementNamed(context, '/login'); 
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  Consumer<StudentController>(
                    builder: (context, controller, _) => _buildSummaryCard(
                      context,
                      'Total Students',
                      controller.students.length.toString(),
                      Icons.people,
                      Colors.blue,
                      AppRouter.studentListRoute,
                    ),
                  ),
                  Consumer<CourseController>(
                    builder: (context, controller, _) => _buildSummaryCard(
                      context,
                      'Total Courses',
                      controller.courses.length.toString(),
                      Icons.book,
                      Colors.orange,
                      AppRouter.courseListRoute,
                    ),
                  ),
                  Consumer<EnrolmentController>(
                    builder: (context, controller, _) => _buildSummaryCard(
                      context,
                      'Total Enrolments',
                      controller.enrolments.length.toString(),
                      Icons.how_to_reg,
                      Colors.green,
                      null,
                    ),
                  ),
                  if (role == 'Admin' || role == 'HR') ...[
                      Consumer<EmployeeController>(
                        builder: (context, controller, _) => _buildGradientCard(
                          context,
                          'Active Staff',
                          controller.employees.length.toString(),
                          Icons.work_rounded,
                          const [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
                          null,
                        ),
                      ),
                    ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String count,
    IconData icon,
    Color color,
    String? route,
  ) {
    return InkWell(
      onTap: route != null ? () => Navigator.pushNamed(context, route) : null,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 8),
              Text(
                count,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
