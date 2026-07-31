import 'package:flutter/material.dart';
import '../../models/employee.dart';
import '../../core/storage/storage_service.dart';

class EmployeeFormScreen extends StatefulWidget {
  final Employee? employee;

  const EmployeeFormScreen({super.key, this.employee});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _designationController;
  late TextEditingController _basicSalaryController;
  late TextEditingController _allowancesController;
  
  String _department = 'School of Computing';
  final List<String> _departments = [
    'School of Computing',
    'School of Business',
    'Finance',
    'Administration',
    'HR'
  ];

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(text: widget.employee?.id ?? '');
    _nameController = TextEditingController(text: widget.employee?.name ?? '');
    _designationController = TextEditingController(text: widget.employee?.designation ?? '');
    _basicSalaryController = TextEditingController(text: widget.employee?.basicSalary.toString() ?? '0');
    _allowancesController = TextEditingController(text: widget.employee?.allowances.toString() ?? '0');
    
    if (widget.employee != null && _departments.contains(widget.employee!.department)) {
      _department = widget.employee!.department;
    }
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _designationController.dispose();
    _basicSalaryController.dispose();
    _allowancesController.dispose();
    super.dispose();
  }

  void _saveEmployee() {
    if (_formKey.currentState!.validate()) {
      final newEmployee = Employee(
        id: _idController.text,
        name: _nameController.text,
        email: 'staff@bci.lk',
        department: _department,
        designation: _designationController.text,
        basicSalary: double.parse(_basicSalaryController.text),
        allowances: double.parse(_allowancesController.text),
        overtime: 0,
        deductions: 0,
        tax: 0,
      );

      if (widget.employee == null) {
        mockEmployees.add(newEmployee);
      } else {
        final index = mockEmployees.indexWhere((e) => e.id == widget.employee!.id);
        if (index != -1) {
          mockEmployees[index] = newEmployee;
        }
      }
      StorageService.saveEmployees();
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.employee != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Employee' : 'Add Employee')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Personal Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _idController,
                decoration: const InputDecoration(labelText: 'Employee ID', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                enabled: !isEditing,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 32),
              
              const Text('Job Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _department,
                decoration: const InputDecoration(labelText: 'Department', border: OutlineInputBorder()),
                items: _departments.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
                onChanged: (value) => setState(() => _department = value!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _designationController,
                decoration: const InputDecoration(labelText: 'Designation', border: OutlineInputBorder()),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 32),

              const Text('Financial Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _basicSalaryController,
                      decoration: const InputDecoration(labelText: 'Basic Salary (Rs)', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null || double.tryParse(value) == null ? 'Invalid number' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: _allowancesController,
                      decoration: const InputDecoration(labelText: 'Allowances (Rs)', border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      validator: (value) => value == null || double.tryParse(value) == null ? 'Invalid number' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveEmployee,
                  child: const Text('Save Employee'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
