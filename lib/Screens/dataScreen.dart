import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  final String age;
  final String gender;
  final String name;
  const DataScreen(
      {super.key, required this.gender, required this.name, required this.age});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Name:$name",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
            Text("Age: $age"),
            Text("Gender: $gender")
          ],
        ),
      ),
    );
  }
}
