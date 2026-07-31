import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/course.dart';
import '../controller/course_controller.dart';
import '../../../core/widgets/app_button.dart';

class CourseFormScreen extends StatefulWidget {
  final Course? course;

  const CourseFormScreen({super.key, this.course});

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _creditsController;
  late TextEditingController _lecturerController;

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.course?.id ?? '');
    _nameController = TextEditingController(text: widget.course?.name ?? '');
    _creditsController = TextEditingController(text: widget.course?.credits.toString() ?? '');
    _lecturerController = TextEditingController(text: widget.course?.lecturer ?? '');
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _creditsController.dispose();
    _lecturerController.dispose();
    super.dispose();
  }

  void _saveCourse() async {
    if (_formKey.currentState!.validate()) {
      final newCourse = Course(
        id: _idController.text.trim(),
        name: _nameController.text.trim(),
        credits: int.tryParse(_creditsController.text.trim()) ?? 0,
        lecturer: _lecturerController.text.trim(),
      );

      final controller = context.read<CourseController>();

      if (widget.course == null) {
        await controller.addCourse(newCourse);
      } else {
        await controller.updateCourse(newCourse);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.course != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Course' : 'Add New Course')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'Course ID'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                enabled: !isEditing,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Course Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _creditsController,
                decoration: const InputDecoration(labelText: 'Credits'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Required';
                  if (int.tryParse(value) == null) return 'Must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lecturerController,
                decoration: const InputDecoration(labelText: 'Lecturer Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 32),
              Consumer<CourseController>(
                builder: (context, controller, child) {
                  return AppButton(
                    label: 'Save Course',
                    onPressed: _saveCourse,
                    isLoading: controller.isLoading,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
