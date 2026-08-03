import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../employees/controller/employee_controller.dart';
import '../controller/hr_controller.dart';

class EmployeeAttendanceScreen extends StatefulWidget {
  const EmployeeAttendanceScreen({super.key});

  @override
  State<EmployeeAttendanceScreen> createState() => _EmployeeAttendanceScreenState();
}

class _EmployeeAttendanceScreenState extends State<EmployeeAttendanceScreen> {

  Future<void> _selectDate(BuildContext context) async {
    final hrController = context.read<HrController>();
    final parts = hrController.currentDate.split('-');
    DateTime initialDate = DateTime.now();
    if (parts.length == 3) {
      initialDate = DateTime(int.parse(parts[0]), int.parse(parts[1]), int.parse(parts[2]));
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final dateString = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      if (mounted) {
        hrController.loadAttendance(dateString);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final employees = context.watch<EmployeeController>().employees;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Daily Attendance'),
      ),
      body: Consumer<HrController>(
        builder: (context, hrController, child) {
          return Column(
            children: [
              Container(
                color: const Color(0xFF1E3A8A).withValues(alpha: 0.05),
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Attendance Date:', style: TextStyle(color: Colors.grey)),
                        Text(
                          hrController.currentDate,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_month),
                      label: const Text('Change Date'),
                    ),
                  ],
                ),
              ),
              if (hrController.isLoading)
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: employees.length,
                    itemBuilder: (context, index) {
                      final employee = employees[index];
                      final isPresent = hrController.isEmployeePresent(employee.id);

                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.orange.shade100,
                          child: const Icon(Icons.badge, color: Colors.orange),
                        ),
                        title: Text(employee.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${employee.id} • ${employee.department}'),
                        trailing: Switch(
                          value: isPresent,
                          activeTrackColor: Colors.green.shade200,
                          onChanged: (bool value) {
                            hrController.toggleAttendance(employee.id, value);
                          },
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
