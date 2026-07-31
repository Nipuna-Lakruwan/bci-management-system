import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/student.dart';
import '../controller/student_controller.dart';
import '../../../core/widgets/app_button.dart';

class StudentFormScreen extends StatefulWidget {
  final Student? student;

  const StudentFormScreen({super.key, this.student});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _programmeController;
  late TextEditingController _intakeController;
  String _status = 'Active';

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.student?.id ?? '');
    _nameController = TextEditingController(text: widget.student?.name ?? '');
    _emailController = TextEditingController(text: widget.student?.email ?? '');
    _programmeController = TextEditingController(text: widget.student?.program ?? '');
    _intakeController = TextEditingController(text: widget.student?.intake ?? '2024');
    _status = widget.student?.status ?? 'Active';
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _programmeController.dispose();
    _intakeController.dispose();
    super.dispose();
  }

  void _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      final newStudent = Student(
        id: _idController.text.trim(),
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        program: _programmeController.text.trim(),
        intake: _intakeController.text.trim(),
        status: _status,
      );

      final controller = context.read<StudentController>();

      if (widget.student == null) {
        await controller.addStudent(newStudent);
      } else {
        await controller.updateStudent(newStudent);
      }

      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.student != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Student' : 'Add New Student')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'Student ID'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                enabled: !isEditing,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email Address'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _programmeController,
                decoration: const InputDecoration(labelText: 'Programme'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Active', 'Inactive'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (value) => setState(() => _status = value!),
              ),
              const SizedBox(height: 32),
              Consumer<StudentController>(
                builder: (context, controller, child) {
                  return AppButton(
                    label: 'Save Student',
                    onPressed: _saveStudent,
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
