import 'package:flutter/material.dart';
import '../students/student_list_screen.dart';
import '../academics/academics_screen.dart';
import '../hr/employee_list_screen.dart';
import '../hr/payroll_screen.dart';
import '../hr/leave_management_screen.dart';
import '../hr/employee_attendance_screen.dart';
import '../../models/student.dart';
import '../../models/employee.dart';
import '../../models/course_module.dart';

class DashboardScreen extends StatelessWidget {
  final String role; // 'Admin', 'HR', or 'Lecturer'
  
  const DashboardScreen({super.key, this.role = 'Admin'});

  double get _monthlyPayrollTotal {
    double total = 0;
    for (final emp in mockEmployees) {
      total += emp.netSalary;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BCI Dashboard'),
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
                  Text(role, style: const TextStyle(color: Colors.white, fontSize: 18)),
                  const Text('BCI Management System', style: TextStyle(color: Colors.white70, fontSize: 14)),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const StudentListScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Academics'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AcademicsScreen()),
                );
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
                Navigator.pushReplacementNamed(context, '/'); 
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildDashboardCard(context, 'Total Students', mockStudents.length.toString(), Icons.people, Colors.blue),
            _buildDashboardCard(context, 'Active Staff', mockEmployees.length.toString(), Icons.badge, Colors.green),
            _buildDashboardCard(context, 'Programmes', mockModules.length.toString(), Icons.menu_book, Colors.orange),
            _buildDashboardCard(context, 'Monthly Payroll', 'Rs ${_monthlyPayrollTotal / 1000}k', Icons.attach_money, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(height: 16),
              Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 8),
              Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
