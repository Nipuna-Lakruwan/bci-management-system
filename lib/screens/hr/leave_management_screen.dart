import 'package:flutter/material.dart';
import '../../models/leave_request.dart';

class LeaveManagementScreen extends StatefulWidget {
  const LeaveManagementScreen({super.key});

  @override
  State<LeaveManagementScreen> createState() => _LeaveManagementScreenState();
}

class _LeaveManagementScreenState extends State<LeaveManagementScreen> {
  void _updateStatus(LeaveRequest request, String newStatus) {
    setState(() {
      request.status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Management'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockLeaveRequests.length,
        itemBuilder: (context, index) {
          final request = mockLeaveRequests[index];
          
          Color statusColor;
          switch (request.status) {
            case 'Approved':
              statusColor = Colors.green;
              break;
            case 'Rejected':
              statusColor = Colors.red;
              break;
            default:
              statusColor = Colors.orange;
          }

          return Card(
            margin: const EdgeInsets.only(bottom: 12.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        request.employeeName,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: statusColor),
                        ),
                        child: Text(
                          request.status,
                          style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Leave Type: ${request.type}'),
                  Text('Date: ${request.date}'),
                  const SizedBox(height: 16),
                  if (request.status == 'Pending')
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                          onPressed: () => _updateStatus(request, 'Rejected'),
                          child: const Text('Reject'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          style: FilledButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () => _updateStatus(request, 'Approved'),
                          child: const Text('Approve'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
