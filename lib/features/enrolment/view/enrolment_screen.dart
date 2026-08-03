import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/enrolment_controller.dart';
import '../../students/model/student.dart';
import '../../../core/widgets/app_button.dart';

class EnrolmentScreen extends StatefulWidget {
  const EnrolmentScreen({super.key});

  @override
  State<EnrolmentScreen> createState() => _EnrolmentScreenState();
}

class _EnrolmentScreenState extends State<EnrolmentScreen> {
  final List<String> _selectedCourseIds = [];
  Student? _selectedStudent;

  void _onStudentChanged(Student? student) {
    if (student == null) return;
    setState(() {
      _selectedStudent = student;
      _selectedCourseIds.clear();
      final enrolmentController = context.read<EnrolmentController>();
      _selectedCourseIds.addAll(enrolmentController.getEnrolledCourseIds(student.id));
    });
  }

  void _toggleCourse(String courseId, bool? isSelected) {
    setState(() {
      if (isSelected == true) {
        _selectedCourseIds.add(courseId);
      } else {
        _selectedCourseIds.remove(courseId);
      }
    });
  }

  void _saveEnrolment() async {
    if (_selectedStudent == null) return;
    final controller = context.read<EnrolmentController>();
    await controller.updateEnrolment(_selectedStudent!.id, _selectedCourseIds);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enrolment saved successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Enrolment'),
      ),
      body: Consumer<EnrolmentController>(
        builder: (context, enrolmentController, child) {
          if (enrolmentController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final courses = enrolmentController.courses;
          final students = enrolmentController.students;

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: DropdownButtonFormField<Student>(
                  initialValue: _selectedStudent,
                  decoration: const InputDecoration(
                    labelText: 'Select Student',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  items: students.map((s) => DropdownMenuItem(
                    value: s,
                    child: Text('${s.name} (${s.id})'),
                  )).toList(),
                  onChanged: _onStudentChanged,
                ),
              ),
              const Divider(height: 1),
              if (_selectedStudent != null) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Select Courses for ${_selectedStudent!.name}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      final isSelected = _selectedCourseIds.contains(course.id);
                      return CheckboxListTile(
                        value: isSelected,
                        onChanged: (val) => _toggleCourse(course.id, val),
                        title: Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('${course.id} • ${course.credits} Credits'),
                        secondary: const Icon(Icons.book, color: Color(0xFF1E3A8A)),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppButton(
                    label: 'Save Changes',
                    onPressed: _saveEnrolment,
                    isLoading: enrolmentController.isLoading,
                  ),
                ),
              ] else ...[
                const Expanded(
                  child: Center(
                    child: Text('Please select a student to manage enrolments.', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ),
                ),
              ]
            ],
          );
        },
      ),
    );
  }
}
