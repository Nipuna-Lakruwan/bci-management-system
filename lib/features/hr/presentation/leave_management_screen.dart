import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/hr_controller.dart';

class LeaveManagementScreen extends StatelessWidget {
  const LeaveManagementScreen({super.key});

  void _updateStatus(BuildContext context, String id, String status) {
    context.read<HrController>().updateLeaveStatus(id, status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Requests'),
      ),
      body: Consumer<HrController>(
        builder: (context, controller, child) {
          if (controller.isLoading && controller.leaveRequests.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.leaveRequests.isEmpty) {
            return const Center(child: Text('No leave requests found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.leaveRequests.length,
            itemBuilder: (context, index) {
              final request = controller.leaveRequests[index];
              Color statusColor = Colors.orange;
              if (request.status == 'Approved') statusColor = Colors.green;
              if (request.status == 'Rejected') statusColor = Colors.red;

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
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
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
                              onPressed: () => _updateStatus(context, request.id, 'Rejected'),
                              style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                              child: const Text('Reject'),
                            ),
                            const SizedBox(width: 8),
                            FilledButton(
                              onPressed: () => _updateStatus(context, request.id, 'Approved'),
                              style: FilledButton.styleFrom(backgroundColor: Colors.green),
                              child: const Text('Approve'),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
