import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/enrolment_controller.dart';
import '../../courses/controller/course_controller.dart';
import '../../students/model/student.dart';
import '../../../core/widgets/app_button.dart';

class EnrolmentScreen extends StatefulWidget {
  final Student student;

  const EnrolmentScreen({super.key, required this.student});

  @override
  State<EnrolmentScreen> createState() => _EnrolmentScreenState();
}

class _EnrolmentScreenState extends State<EnrolmentScreen> {
  final List<String> _selectedCourseIds = [];
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      final enrolmentController = context.read<EnrolmentController>();
      _selectedCourseIds.addAll(enrolmentController.getEnrolledCourseIds(widget.student.id));
      _isInit = false;
    }
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
    final controller = context.read<EnrolmentController>();
    await controller.updateEnrolment(widget.student.id, _selectedCourseIds);
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
      body: Consumer<CourseController>(
        builder: (context, courseController, child) {
          if (courseController.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final courses = courseController.courses;

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white,
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Color(0xFF1E3A8A),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.student.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(widget.student.id, style: TextStyle(color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Select Courses', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
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
                child: Consumer<EnrolmentController>(
                  builder: (context, enrolmentController, child) {
                    return AppButton(
                      label: 'Save Changes',
                      onPressed: _saveEnrolment,
                      isLoading: enrolmentController.isLoading,
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
