import 'package:flutter/material.dart';

class TaskCreatePage extends StatelessWidget {
  const TaskCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Task"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save task logic here
            },
          ),
        ],
      ),
    );
  }
}
