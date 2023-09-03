import 'package:flutter/material.dart';
import 'package:flutter_application_19/screen/create.dart';
import 'package:flutter_application_19/screen/update.dart';
import 'package:flutter_application_19/screen/patient.dart';
import 'package:flutter_application_19/screen/config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_19/screen/history.dart';

class ReadPatientPage extends StatefulWidget {
  static const routeName = "/";
  const ReadPatientPage({Key? key}) : super(key: key);

  @override
  State<ReadPatientPage> createState() => _ReadPatientPageState();
}

class _ReadPatientPageState extends State<ReadPatientPage> {
  List<Patients> _patientList = [];

  // Define a function to refresh the patient list
  Future<void> refreshPatients() async {
    await getPatients();
  }

  Future<void> getPatients() async {
    try {
      var url = Uri.http(Configure.server, "Patients");
      var resp = await http.get(url);
      if (resp.statusCode == 200) {
        setState(() {
          _patientList = patientsFromJson(resp.body);
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
      ),
      body: RefreshIndicator(
        onRefresh: refreshPatients,
        child: ListView.builder(
          itemCount: _patientList.length,
          itemBuilder: (context, index) {
            Patients patient = _patientList[index];
            return ListTile(
              title: Row(
                children: [
                  Text(
                    "${patient.id}",
                    style: TextStyle(
                      fontSize: 16,
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdatePatientPage(patient: patient),
                        ),
                      );
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
                        refreshPatients();
                      }
                    },
                  ),
                ],
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
            refreshPatients();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
