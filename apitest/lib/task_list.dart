import 'package:apitest/insert_task.dart';
import 'package:apitest/task.dart';
import 'package:apitest/task_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'prefix_url.dart';
import 'dart:convert';
import 'dart:async';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    tasks = getTaskList();
  }

  Future<List<Task>> getTaskList() async {
    try {
      var url = Uri.parse("${PrefixURL.urlPrefix}/all_task.php");
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final items = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Task> tasks = items.map<Task>((json) {
          return Task.fromJson(json);
        }).toList();
        return tasks;
      } else {
        throw Exception('Failed to load tasks');
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task management"),
      ),
      body: Center(
        child: FutureBuilder<List<Task>>(
          future: tasks,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.task),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      data.title!,
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskDetail(task: data),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InsertTask()),
          );
        },
      ),
    );
  }
}
