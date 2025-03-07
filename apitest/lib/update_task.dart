import 'package:flutter/material.dart';
import 'package:apitest/task.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart';
import 'dart:convert';
import 'dart:async';

class UpdateTask extends StatefulWidget {
  final Task task;
  UpdateTask({required this.task});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void updateTask(context) async {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Title and description cannot be empty'),
      ));
      return;
    }

    var url = Uri.parse("${PrefixURL.urlPrefix}/update_task.php");
    await http.post(
      url,
      body: {
        'id': widget.task.id.toString(),
        'title': titleController.text,
        'description': descriptionController.text,
      },
    );
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task.title);
    descriptionController =
        TextEditingController(text: widget.task.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
      ),
      body: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          SizedBox(height: 10),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 10,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text("Update"),
            onPressed: () => updateTask(context),
          ),
        ],
      ),
    );
  }
}
