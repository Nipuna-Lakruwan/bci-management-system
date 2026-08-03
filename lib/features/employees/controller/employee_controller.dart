import 'package:flutter/foundation.dart';
import '../domain/employee.dart';
import '../domain/employee_repository.dart';

class EmployeeController extends ChangeNotifier {
  final EmployeeRepository _repository;

  List<Employee> _employees = [];
  bool _isLoading = false;
  String? _errorMessage;

  EmployeeController(this._repository) {
    loadEmployees();
  }

  List<Employee> get employees => _employees;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadEmployees() async {
    _setLoading(true);
    try {
      _employees = await _repository.getEmployees();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to load employees: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> addEmployee(Employee employee) async {
    _setLoading(true);
    try {
      await _repository.addEmployee(employee);
      _employees.add(employee);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to add employee: $e';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> updateEmployee(Employee employee) async {
    _setLoading(true);
    try {
      await _repository.updateEmployee(employee);
      final index = _employees.indexWhere((e) => e.id == employee.id);
      if (index != -1) {
        _employees[index] = employee;
      }
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to update employee: $e';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> deleteEmployee(String id) async {
    _setLoading(true);
    try {
      await _repository.deleteEmployee(id);
      _employees.removeWhere((e) => e.id == id);
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete employee: $e';
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
