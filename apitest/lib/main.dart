import 'package:apitest/insert_task.dart';
import 'package:flutter/material.dart';
import 'package:apitest/task_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TaskList(),
        '/create': (context) => InsertTask(),
      },
    );
  }
}
