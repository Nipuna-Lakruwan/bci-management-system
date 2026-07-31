import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/enrolment.dart';
import 'enrolment_repository.dart';

class LocalEnrolmentRepository implements EnrolmentRepository {
  static const String _storageKey = 'bci_enrolments_data';

  Future<SharedPreferences> _getPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<List<Enrolment>> getAllEnrolments() async {
    final prefs = await _getPrefs();
    final String? data = prefs.getString(_storageKey);
    
    if (data == null || data.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((json) => Enrolment.fromJson(json)).toList();
  }

  Future<void> _saveAll(List<Enrolment> enrolments) async {
    final prefs = await _getPrefs();
    final String data = jsonEncode(enrolments.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, data);
  }

  @override
  Future<Enrolment?> getEnrolmentByStudentId(String studentId) async {
    final enrolments = await getAllEnrolments();
    try {
      return enrolments.firstWhere((e) => e.studentId == studentId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> saveEnrolment(Enrolment enrolment) async {
    final enrolments = await getAllEnrolments();
    final index = enrolments.indexWhere((e) => e.studentId == enrolment.studentId);
    
    if (index != -1) {
      enrolments[index] = enrolment;
    } else {
      enrolments.add(enrolment);
    }
    
    await _saveAll(enrolments);
  }

  @override
  Future<void> deleteEnrolment(String studentId) async {
    final enrolments = await getAllEnrolments();
    enrolments.removeWhere((e) => e.studentId == studentId);
    await _saveAll(enrolments);
  }
}
