import 'package:flutter/material.dart';
import '../../features/courses/model/course.dart';
import '../../features/students/model/student.dart';
import '../../models/attendance_record.dart';

class AttendanceMarkingScreen extends StatefulWidget {
  final Course module;

  const AttendanceMarkingScreen({super.key, required this.module});

  @override
  State<AttendanceMarkingScreen> createState() => _AttendanceMarkingScreenState();
}

class _AttendanceMarkingScreenState extends State<AttendanceMarkingScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
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
    // For simplicity in MVP, we show all active students in every module.
    final List<Student> activeStudents = []; // No mock students for now

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.module.id} Attendance'),
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
              itemCount: activeStudents.length,
              itemBuilder: (context, index) {
                final student = activeStudents[index];
                final record = getOrCreateAttendance(widget.module.id, student.id, dateString);

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(student.name[0]),
                  ),
                  title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(student.id),
                  trailing: Switch(
                    value: record.isPresent,
                    activeTrackColor: Colors.green.shade200,
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
