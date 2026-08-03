import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/employee.dart';
import '../controller/employee_controller.dart';
import 'employee_form_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmployeeController>().loadEmployees();
    });
  }

  void _navigateToAddEmployee() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EmployeeFormScreen()),
    );
  }

  void _navigateToEditEmployee(Employee employee) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmployeeFormScreen(employee: employee)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Directory'),
      ),
      body: Consumer<EmployeeController>(
        builder: (context, controller, child) {
          if (controller.isLoading && controller.employees.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(child: Text(controller.errorMessage!, style: const TextStyle(color: Colors.red)));
          }

          final filteredEmployees = _searchQuery.isEmpty
              ? controller.employees
              : controller.employees.where((emp) =>
                  emp.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                  emp.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                  emp.department.toLowerCase().contains(_searchQuery.toLowerCase())).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search by name, ID, or department...',
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
              ),
              if (filteredEmployees.isEmpty)
                const Expanded(child: Center(child: Text('No employees found.')))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredEmployees.length,
                    itemBuilder: (context, index) {
                      final emp = filteredEmployees[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.orange.shade100,
                            child: const Icon(Icons.badge, color: Colors.orange),
                          ),
                          title: Text(emp.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('${emp.id} • ${emp.designation}\n${emp.department}'),
                          isThreeLine: true,
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.grey),
                            onPressed: () => _navigateToEditEmployee(emp),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddEmployee,
        icon: const Icon(Icons.add),
        label: const Text('Add Employee'),
      ),
    );
  }
}
