import 'package:flutter/material.dart';
import 'page2.dart';

class PageOne extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageOne'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'ชื่อ :'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'นามสกุล : '),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'อีเมล์ : '),
            ),
            TextField(
              controller: phoneNameController,
              decoration: InputDecoration(labelText: 'เบอร์โทร'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  //สร้างข้อมูลที่ต้องการส่ง
                  Map<String, String> data = {
                    'firstname': firstNameController.text,
                    'Lastname': lastNameController.text,
                    'Email': emailController.text,
                    'Phone': phoneNameController.text
                  };

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PageTwo(data: data)),
                  );
                },
                child: Text(
                  'ส่งข้อมูล',
                  style: TextStyle(fontSize: 20, color: Colors.amberAccent),
                )),
          ],
        ),
      ),
    );
  }
}
