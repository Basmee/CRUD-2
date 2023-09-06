import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_19/screen/config.dart';
import 'package:flutter_application_19/screen/patient.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_19/screen/read.dart';

class UpdatePatientPage extends StatefulWidget {
  const UpdatePatientPage({super.key});

  @override
  State<UpdatePatientPage> createState() => _UpdatePatientPageState();
}

class _UpdatePatientPageState extends State<UpdatePatientPage> {
  final _formkey = GlobalKey<FormState>();
  late Patients patient;

  Future<void> updatePatient(patient) async {
    var url = Uri.http(Configure.server, "Patients/${patient.id}");
    var resp = await http.put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(patient.toJson()),
    );
    var rs = patientsFromJson("[${resp.body}]");
    if (rs.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Patient data updated successfully')),
      );
      Navigator.pop(context, "refresh");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update patient data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      patient = ModalRoute.of(context)!.settings.arguments as Patients;
      print(patient.name);
    } catch (e) {
      patient = Patients();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Patient Form"),
        centerTitle: true,
        leading: Image.network(
          'https://cdn-icons-png.flaticon.com/128/2841/2841431.png',
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
              child: Icon(
                Icons.home,
                color: Color.fromARGB(255, 0, 53, 96),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              fnameInputField(),
              ageFormInput(),
              genderFormInput(),
              SizedBox(
                height: 10,
              ),
              symptomsFormInput(),
              diseaseFormInput(),
              treatmentFormInput(),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget fnameInputField() {
    return TextFormField(
      initialValue: patient.name,
      decoration:
          InputDecoration(labelText: "Fullname", icon: Icon(Icons.person)),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => patient.name = newValue,
    );
  }

  Widget genderFormInput() {
    return DropdownButtonFormField(
      value: patient.gender,
      decoration:
          InputDecoration(labelText: "Gender:", icon: Icon(Icons.person)),
      items: Configure.gender.map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          patient.gender = value.toString();
        });
      },
      onSaved: (newValue) => patient.gender = newValue,
    );
  }

  Widget ageFormInput() {
    return TextFormField(
      initialValue: patient.age != null ? patient.age.toString() : "",
      decoration: const InputDecoration(
        labelText: "Age:",
        icon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        final age = int.tryParse(value);
        if (age == null || age < 0) {
          return "Invalid age";
        }
        return null;
      },
      onSaved: (newValue) {
        final age = int.tryParse(newValue!);
        patient.age = age;
      },
    );
  }

  Widget symptomsFormInput() {
    return TextFormField(
      initialValue: patient.symptoms,
      decoration: InputDecoration(
        labelText: "Symptoms:",
        icon: Icon(Icons.healing),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => patient.symptoms = newValue!,
    );
  }

  Widget diseaseFormInput() {
    return TextFormField(
      initialValue: patient.disease,
      decoration: const InputDecoration(
        labelText: "Disease:",
        icon: Icon(Icons.healing),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => patient.disease = newValue!,
    );
  }

  Widget treatmentFormInput() {
    return TextFormField(
      initialValue: patient.treatment,
      decoration: const InputDecoration(
        labelText: "Treatment:",
        icon: Icon(Icons.healing),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      onSaved: (newValue) => patient.treatment = newValue!,
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(patient.toJson().toString());

          if (patient.id != null) {
            await updatePatient(patient);
          }
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ReadPatientPage(),
          ));
        }
      },
      child: Text("Save Changes"),
    );
  }
}
