import 'package:apitest/update_task.dart';
import 'package:flutter/material.dart';
import 'package:apitest/task.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart';
import 'dart:convert';
import 'dart:async';

class TaskDetail extends StatefulWidget {
  final Task task;
  TaskDetail({required this.task});

  @override
  State<TaskDetail> createState() => _DetailState();
}

class _DetailState extends State<TaskDetail> {
  void deleteTask(context) async {
    var url = Uri.parse("${PrefixURL.urlPrefix}/delete_task.php");
    await http.post(url, body: {
      'id': widget.task.id.toString(),
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("ต้องการลบรายการนี้ ใช่หรือไม่?"),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () => deleteTask(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Detail'),
        actions: <Widget>[
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Title: ${widget.task.title}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Description: ${widget.task.description}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdateTask(
                        task: widget.task,
                      )));
        },
      ),
    );
  }
}
