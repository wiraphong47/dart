import 'package:flutter/material.dart';

class BmrCalculator extends StatefulWidget {
  const BmrCalculator({super.key});

  @override
  State<BmrCalculator> createState() => _BmrCalculatorState();
}

class _BmrCalculatorState extends State<BmrCalculator> {
  // ตัวแปรควบคุม TextField
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  String gender = "male"; // ค่าพื้นฐานเป็นเพศชาย
  double bmr = 0;
  double tdee = 0;
  double activityMultiplier = 1.2; // ค่าเริ่มต้นเป็น No Exercise

  void calculateBmrTdee() {
    setState(() {
      double weight = double.tryParse(_weightController.text) ?? 0;
      double height = double.tryParse(_heightController.text) ?? 0;
      int age = int.tryParse(_ageController.text) ?? 0;

      if (weight > 0 && height > 0 && age > 0) {
        if (gender == "male") {
          bmr = 66 + (13.7 * weight) + (5 * height) - (6.8 * age);
        } else {
          bmr = 665 + (9.6 * weight) + (1.8 * height) - (4.7 * age);
        }
        tdee = bmr * activityMultiplier;
      } else {
        bmr = 0;
        tdee = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMR & TDEE Calculator'),
        backgroundColor: Colors.pink, // เปลี่ยนสี AppBar เป็นสีชมพู
        centerTitle: true,
        leading: Image.asset('assets/images/pp.png', width: 40, height: 40), // ใส่โลโก้ใน AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("เลือกเพศ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink)),
            Row(
              children: [
                Radio(
                  value: "male",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                const Text("ชาย", style: TextStyle(color: Colors.pink)),
                Radio(
                  value: "female",
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value.toString();
                    });
                  },
                ),
                const Text("หญิง", style: TextStyle(color: Colors.pink)),
              ],
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "อายุ (ปี)",
                labelStyle: TextStyle(color: Colors.pink), // เปลี่ยนสี label เป็นสีชมพู
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "น้ำหนัก (กก.)",
                labelStyle: TextStyle(color: Colors.pink), // เปลี่ยนสี label เป็นสีชมพู
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "ส่วนสูง (ซม.)",
                labelStyle: TextStyle(color: Colors.pink), // เปลี่ยนสี label เป็นสีชมพู
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text("เลือกระดับกิจกรรม", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink)),
            DropdownButton<double>(
              value: activityMultiplier,
              onChanged: (value) {
                setState(() {
                  activityMultiplier = value!;
                });
              },
              items: const [
                DropdownMenuItem(value: 1.2, child: Text("ไม่ได้ออกกำลังกาย (1.2)")),
                DropdownMenuItem(value: 1.375, child: Text("ออกกำลังกายเบา ๆ 1-3 วัน/สัปดาห์ (1.375)")),
                DropdownMenuItem(value: 1.55, child: Text("ออกกำลังกายปานกลาง 3-5 วัน/สัปดาห์ (1.55)")),
                DropdownMenuItem(value: 1.7, child: Text("ออกกำลังกายหนัก 6-7 วัน/สัปดาห์ (1.7)")),
                DropdownMenuItem(value: 1.9, child: Text("นักกีฬา ออกกำลังกายวันละ 2 ครั้ง (1.9)")),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: calculateBmrTdee,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink, // เปลี่ยนสีปุ่มเป็นสีชมพู
                  foregroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text("คำนวณ", style: TextStyle(fontSize: 20)),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                "BMR: ${bmr.toStringAsFixed(2)} kcal\nTDEE: ${tdee.toStringAsFixed(2)} kcal",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink), // เปลี่ยนสีข้อความผลลัพธ์เป็นสีชมพู
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: BmrCalculator(),
    debugShowCheckedModeBanner: false,
  ));
}
