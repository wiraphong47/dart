import 'dart:io';

import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  final Map<String, String> data;

  const PageTwo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page Two'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ชื่อ : ${data['firstname']}',
              style: TextStyle(fontSize: 18, color: Colors.deepOrange),
            ),
            Text(
              'นามสกุล : ${data['Lastname']}',
              style: TextStyle(fontSize: 18, color: Colors.deepOrange),
            ),
            Text(
              'อีเมล์ : ${data['Email']}',
              style: TextStyle(fontSize: 18, color: Colors.deepOrange),
            ),
            Text(
              'เบอร์โทร : ${data['Phone']}',
              style: TextStyle(fontSize: 18, color: Colors.deepOrange),
            )
          ],
        ),
      ),
    );
  }
}
