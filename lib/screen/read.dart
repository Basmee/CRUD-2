import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_19/screen/history.dart';
import 'package:flutter_application_19/screen/update.dart';
import 'package:flutter_application_19/screen/create.dart';
import 'package:flutter_application_19/screen/config.dart';
import 'package:flutter_application_19/screen/patient.dart';

import 'package:flutter_application_19/main.dart';

class ReadPatientPage extends StatefulWidget {
  static const routeName = "/";

  const ReadPatientPage({Key? key}) : super(key: key);

  @override
  State<ReadPatientPage> createState() => _ReadPatientPageState();
}

class _ReadPatientPageState extends State<ReadPatientPage> {
  List<Patients> _patientList = [];
  bool _isLoading = true;

  Future<void> getPatients() async {
    try {
      var url = Uri.http(Configure.server, "Patients");
      var resp = await http.get(url);
      if (resp.statusCode == 200) {
        setState(() {
          _patientList = patientsFromJson(resp.body);
          _isLoading = false;
        });
      } else {
        print("Failed to fetch patients: ${resp.statusCode}");
      }
    } catch (e) {
      print("Error fetching patients: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getPatients();
  }

  Future<void> removePatients(Patients patient) async {
    var url = Uri.http(Configure.server, "Patients/${patient.id}");
    var resp = await http.delete(url);
    print(resp.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Patients'),
        centerTitle: true,
        leading: Image.network(
          'https://cdn-icons-png.flaticon.com/128/2841/2841431.png',
          width: 50,
        ),
        elevation: 5,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, HomePage.routeName);
            },
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.logout,
                color: Color.fromARGB(255, 0, 53, 96),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                itemCount: _patientList.length,
                itemBuilder: (context, index) {
                  Patients patient = _patientList[index];
                  return Card(
                    margin: EdgeInsets.all(8), // กำหนดระยะห่างขอบของ Card
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            "${patient.id}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${patient.name}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => History(),
                            settings: RouteSettings(arguments: patient),
                          ),
                        );
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdatePatientPage(),
                                      settings:
                                          RouteSettings(arguments: patient)));
                              if (result == "refresh") {
                                getPatients();
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              bool confirmDelete = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Delete Patient'),
                                  content: Text(
                                      'Are you sure you want to delete this patient?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await removePatients(patient);
                                        Navigator.of(context).pop(true);
                                      },
                                      child: Text('Delete'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirmDelete == true) {
                                getPatients();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePatient(),
            ),
          );
          if (result == "refresh") {
            getPatients();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
