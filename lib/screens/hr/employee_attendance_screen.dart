import 'package:flutter/material.dart';
import '../../models/employee.dart';
import '../../models/employee_attendance.dart';

class EmployeeAttendanceScreen extends StatefulWidget {
  const EmployeeAttendanceScreen({super.key});

  @override
  State<EmployeeAttendanceScreen> createState() => _EmployeeAttendanceScreenState();
}

class _EmployeeAttendanceScreenState extends State<EmployeeAttendanceScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final String dateString = "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Daily Attendance'),
      ),
      body: Column(
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
                      dateString,
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
          Expanded(
            child: ListView.builder(
              itemCount: mockEmployees.length,
              itemBuilder: (context, index) {
                final employee = mockEmployees[index];
                final record = getOrCreateStaffAttendance(employee.id, dateString);

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.orange.shade100,
                    child: const Icon(Icons.badge, color: Colors.orange),
                  ),
                  title: Text(employee.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${employee.id} • ${employee.department}'),
                  trailing: Switch(
                    value: record.isPresent,
                    activeTrackColor: Colors.green.shade200,
                    activeColor: Colors.green,
                    onChanged: (bool value) {
                      setState(() {
                        record.isPresent = value;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
