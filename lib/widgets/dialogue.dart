import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final String studentId;
  final VoidCallback onConfirm;

  ConfirmationDialog({required this.studentId, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirm Deletion'),
      content: Text('Are you sure you want to delete this student?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            onConfirm(); // Call the onConfirm callback
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Delete'),
        ),
      ],
    );
  }
}
