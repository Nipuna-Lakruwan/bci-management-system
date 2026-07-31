import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/students/controller/student_controller.dart';
import '../../features/courses/controller/course_controller.dart';
import '../../features/enrolment/controller/enrolment_controller.dart';
import '../../features/employees/controller/employee_controller.dart';
import '../../features/employees/presentation/employee_list_screen.dart';
import '../../features/hr/presentation/leave_management_screen.dart';
import '../../features/hr/presentation/employee_attendance_screen.dart';
import '../../app/router.dart';
import '../../app/theme.dart';
import '../hr/payroll_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role = context.watch<AuthController>().currentUser?.role ?? 'Admin';
    final name = context.watch<AuthController>().currentUser?.name ?? 'User';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppTheme.primaryGradient,
          ),
        ),
      ),
      drawer: _buildPremiumDrawer(context, name, role),
      body: Container(
        decoration: const BoxDecoration(
          color: AppTheme.backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back, $name',
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Here is what is happening at BCI today.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.count(
                  crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : (MediaQuery.of(context).size.width > 500 ? 2 : 1),
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.4,
                  children: [
                    Consumer<StudentController>(
                      builder: (context, controller, _) => _buildGradientCard(
                        context,
                        'Total Students',
                        controller.students.length.toString(),
                        Icons.people_alt_rounded,
                        const [Color(0xFF3B82F6), Color(0xFF2563EB)],
                        AppRouter.studentListRoute,
                      ),
                    ),
                    Consumer<CourseController>(
                      builder: (context, controller, _) => _buildGradientCard(
                        context,
                        'Total Courses',
                        controller.courses.length.toString(),
                        Icons.menu_book_rounded,
                        const [Color(0xFFF59E0B), Color(0xFFD97706)],
                        AppRouter.courseListRoute,
                      ),
                    ),
                    Consumer<EnrolmentController>(
                      builder: (context, controller, _) => _buildGradientCard(
                        context,
                        'Enrolments',
                        controller.enrolments.length.toString(),
                        Icons.how_to_reg_rounded,
                        const [Color(0xFF10B981), Color(0xFF059669)],
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
      ),
    );
  }

  Widget _buildPremiumDrawer(BuildContext context, String name, String role) {
    return Drawer(
      elevation: 16,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: AppTheme.primaryGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.account_circle, size: 64, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(name, style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(role, style: GoogleFonts.inter(color: Colors.white.withOpacity(0.8), fontSize: 14)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildDrawerItem(context, Icons.dashboard_rounded, 'Dashboard', null),
            _buildDrawerItem(context, Icons.people_alt_rounded, 'Students', AppRouter.studentListRoute),
            _buildDrawerItem(context, Icons.menu_book_rounded, 'Courses', AppRouter.courseListRoute),
            if (role == 'Admin' || role == 'HR') ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Text('HUMAN RESOURCES', style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
              ),
              _buildDrawerItem(context, Icons.badge_rounded, 'Employees', null,
                  action: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeListScreen()))),
              _buildDrawerItem(context, Icons.co_present_rounded, 'Staff Attendance', null,
                  action: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeAttendanceScreen()))),
              _buildDrawerItem(context, Icons.event_busy_rounded, 'Leave Requests', null,
                  action: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaveManagementScreen()))),
              _buildDrawerItem(context, Icons.payments_rounded, 'Payroll', null,
                  action: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const PayrollScreen()))),
            ],
            const Divider(height: 32),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.logout_rounded, color: Colors.red),
              ),
              title: Text('Logout', style: GoogleFonts.inter(color: Colors.red, fontWeight: FontWeight.w600)),
              onTap: () {
                context.read<AuthController>().logout();
                Navigator.pushReplacementNamed(context, '/login'); 
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, String? route, {VoidCallback? action}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Icon(icon, color: AppTheme.textSecondary),
      title: Text(title, style: GoogleFonts.inter(color: AppTheme.textPrimary, fontWeight: FontWeight.w500)),
      hoverColor: AppTheme.primaryLight.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        Navigator.pop(context); // Close drawer
        if (route != null) {
          Navigator.pushNamed(context, route);
        } else if (action != null) {
          action();
        }
      },
    );
  }

  Widget _buildGradientCard(
    BuildContext context,
    String title,
    String count,
    IconData icon,
    List<Color> gradientColors,
    String? route,
  ) {
    return DashboardHoverCard(
      route: route,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            )
          ],
        ),
        child: Stack(
          children: [
            // Decorative background icon
            Positioned(
              right: -16,
              bottom: -16,
              child: Icon(
                icon,
                size: 100,
                color: Colors.white.withOpacity(0.15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, size: 32, color: Colors.white),
                      ),
                      if (route != null)
                        const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white70, size: 16),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        count,
                        style: GoogleFonts.outfit(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Stateful widget to handle the hover animation scale
class DashboardHoverCard extends StatefulWidget {
  final Widget child;
  final String? route;

  const DashboardHoverCard({super.key, required this.child, this.route});

  @override
  State<DashboardHoverCard> createState() => _DashboardHoverCardState();
}

class _DashboardHoverCardState extends State<DashboardHoverCard> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.route != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: widget.route != null ? () => Navigator.pushNamed(context, widget.route!) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()..scale(_isHovering ? 1.03 : 1.0),
          child: widget.child,
        ),
      ),
    );
  }
}
