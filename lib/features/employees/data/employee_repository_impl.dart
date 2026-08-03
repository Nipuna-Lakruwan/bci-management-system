import 'dart:convert';
import '../../../core/storage/storage_service.dart';
import '../domain/employee.dart';
import '../domain/employee_repository.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  final StorageService _storageService;
  static const String _storageKey = 'employees_data';

  EmployeeRepositoryImpl(this._storageService);

  @override
  Future<List<Employee>> getEmployees() async {
    final String? data = await _storageService.getString(_storageKey);
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      return jsonList.map((json) => Employee.fromJson(json)).toList();
    }
    // Return mock data initially if storage is empty
    return _getMockEmployees();
  }

  @override
  Future<Employee?> getEmployeeById(String id) async {
    final employees = await getEmployees();
    try {
      return employees.firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addEmployee(Employee employee) async {
    final employees = await getEmployees();
    employees.add(employee);
    await _saveEmployees(employees);
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    final employees = await getEmployees();
    final index = employees.indexWhere((e) => e.id == employee.id);
    if (index != -1) {
      employees[index] = employee;
      await _saveEmployees(employees);
    }
  }

  @override
  Future<void> deleteEmployee(String id) async {
    final employees = await getEmployees();
    employees.removeWhere((e) => e.id == id);
    await _saveEmployees(employees);
  }

  Future<void> _saveEmployees(List<Employee> employees) async {
    final String data = json.encode(employees.map((e) => e.toJson()).toList());
    await _storageService.setString(_storageKey, data);
  }

  List<Employee> _getMockEmployees() {
    return [
      const Employee(
        id: 'EMP-001',
        name: 'Dr. Amal Jayasinghe',
        email: 'amal.j@bci.lk',
        department: 'School of Computing',
        designation: 'Senior Lecturer',
        basicSalary: 185000,
        allowances: 35000,
        overtime: 12000,
        deductions: 8500,
        tax: 17500,
      ),
      const Employee(
        id: 'EMP-002',
        name: 'Rashmi Perera',
        email: 'rashmi.p@bci.lk',
        department: 'Finance',
        designation: 'Finance Officer',
        basicSalary: 125000,
        allowances: 22000,
        overtime: 6500,
        deductions: 5000,
        tax: 9500,
      ),
      const Employee(
        id: 'EMP-003',
        name: 'Kamal Fernando',
        email: 'kamal.f@bci.lk',
        department: 'Administration',
        designation: 'Management Assistant',
        basicSalary: 95000,
        allowances: 18000,
        overtime: 8000,
        deductions: 3500,
        tax: 4200,
      ),
    ];
  }
}
