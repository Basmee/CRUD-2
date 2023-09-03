import 'package:flutter/material.dart';
import 'package:flutter_application_19/screen/patient.dart';

class DeletePatientPage extends StatelessWidget {
  final Patients patient;

  DeletePatientPage({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Are you sure you want to delete this patient?',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // เพิ่มโค้ดสำหรับการลบข้อมูลผู้ป่วย
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
