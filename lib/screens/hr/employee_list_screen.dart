import 'package:flutter/material.dart';
import '../../models/employee.dart';
import 'employee_form_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  String _searchQuery = '';
  
  List<Employee> get filteredEmployees {
    if (_searchQuery.isEmpty) return mockEmployees;
    return mockEmployees.where((emp) => 
      emp.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      emp.id.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      emp.department.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  void _navigateToAddEmployee() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const EmployeeFormScreen()));
    if (result == true) setState(() {});
  }

  void _navigateToEditEmployee(Employee employee) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeFormScreen(employee: employee)));
    if (result == true) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Directory'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name, ID, or department...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredEmployees.length,
              itemBuilder: (context, index) {
                final emp = filteredEmployees[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToAddEmployee,
        icon: const Icon(Icons.add),
        label: const Text('Add Employee'),
      ),
    );
  }
}
