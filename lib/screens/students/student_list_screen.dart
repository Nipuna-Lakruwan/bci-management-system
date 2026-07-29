import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../core/storage_service.dart';
import '../academics/academic_transcript_screen.dart';
import 'student_form_screen.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  String _searchQuery = '';
  
  List<Student> get filteredStudents {
    if (_searchQuery.isEmpty) return mockStudents;
    return mockStudents.where((student) => 
      student.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      student.id.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  void _navigateToAddStudent() async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => const StudentFormScreen()));
    if (result == true) setState(() {});
  }

  void _navigateToEditStudent(Student student) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Student'),
        content: const Text('Are you sure you want to delete this student?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() {
        mockStudents.removeWhere((s) => s.id == student.id);
      });
      StorageService.saveStudents();
    }
    final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => StudentFormScreen(student: student)));
    if (result == true) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by name or ID...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStudents.length,
              itemBuilder: (context, index) {
                final student = filteredStudents[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: ListTile(
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AcademicTranscriptScreen(student: student)),
                      );
                    },
                    leading: CircleAvatar(
                      backgroundColor: student.status == 'Active' ? Colors.blue.shade100 : Colors.red.shade100,
                      child: Text(student.name[0], style: TextStyle(color: student.status == 'Active' ? Colors.blue.shade900 : Colors.red.shade900)),
                    ),
                    title: Text(student.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${student.id} • ${student.program}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.grey),
                      onPressed: () => _navigateToEditStudent(student),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddStudent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
