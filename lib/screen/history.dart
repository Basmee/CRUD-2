import 'package:flutter/material.dart';
import 'package:flutter_application_19/screen/patient.dart';

class History extends StatelessWidget {
  const History({Key? key});

  @override
  Widget build(BuildContext context) {
    // Extract the patient data from route arguments
    final Patients patient =
        ModalRoute.of(context)!.settings.arguments as Patients;

    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Details'),
        centerTitle: true,
        leading: Image.network(
          'https://cdn-icons-png.flaticon.com/256/9821/9821795.png',
          width: 50,
        ),
        elevation: 5,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context, "refresh");
            },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://cdn-icons-png.flaticon.com/128/463/463612.png'),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            ListTile(
              title: Text(
                "ID:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${patient.id}"),
            ),
            ListTile(
              title: Text(
                "Name:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${patient.name}"),
            ),
            ListTile(
              title: Text(
                "Age:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${patient.age}"),
            ),
            ListTile(
              title: Text(
                "Gender:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${patient.gender}"),
            ),
            ListTile(
              title: Text(
                "Symptoms:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${patient.symptoms}"),
            ),
            ListTile(
              title: Text(
                "Disease:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${patient.disease}"),
            ),
            ListTile(
              title: Text(
                "Treatment:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${patient.treatment}"),
            ),
          ],
        ),
      ),
    );
  }
}
