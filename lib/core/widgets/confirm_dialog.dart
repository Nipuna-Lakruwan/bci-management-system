import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Confirm', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }

  static Future<bool?> show(BuildContext context, {required String title, required String content}) {
    return showDialog<bool>(
      context: context,
      builder: (context) => ConfirmDialog(title: title, content: content),
    );
  }
}
