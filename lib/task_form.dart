import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  final Function(String) onAdd;

  const TaskForm(this.onAdd, {super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title is required';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                child: const Text('Add'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    widget.onAdd(titleController.value.text);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
