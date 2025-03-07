import 'dart:io';

import 'package:flutter/material.dart';
import 'package:apitest/task.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart';
import 'dart:convert';
import 'dart:async';

class InsertTask extends StatefulWidget {
  const InsertTask({super.key});

  @override
  State<InsertTask> createState() => _InsertTaskState();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class _InsertTaskState extends State<InsertTask> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void insertTask(BuildContext context) async {
    HttpOverrides.global = MyHttpOverrides();
    var url = Uri.parse("${PrefixURL.urlPrefix}/insert_task.php");
    await http.post(
      url,
      body: {
        'title': titleController.text,
        'description': descriptionController.text,
      },
    );
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insert new Task'),
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
            child: Text("Create new"),
            onPressed: () => insertTask(context),
          ),
        ],
      ),
    );
  }
}
