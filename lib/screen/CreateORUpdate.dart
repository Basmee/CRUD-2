// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_19/screen/config.dart';
// import 'package:flutter_application_19/screen/patient.dart';
// import 'package:http/http.dart' as http;

// class CreatePatientPage extends StatefulWidget {
//   const CreatePatientPage({super.key});

//   @override
//   State<CreatePatientPage> createState() => _CreatePatientPageState();
// }

// class _CreatePatientPageState extends State<CreatePatientPage> {
//   final _formKey = GlobalKey<FormState>();
//   //Patients patient = Patients();
//   late Patients patient;

//   Future<void> addOrUpdatePatient() async {
//     final url = Uri.http(Configure.server, "patients");
//     final resp = patient.id != null
//         ? await http.put(
//             url,
//             headers: <String, String>{
//               'Content-Type': 'application/json; charset=UTF-8',
//             },
//             body: jsonEncode(patient.toJson()),
//           )
//         : await http.post(
//             url,
//             headers: <String, String>{
//               'Content-Type': 'application/json; charset=UTF-8',
//             },
//             body: jsonEncode(patient.toJson()),
//           );

//     if (resp.statusCode == 200) {
//       Navigator.pop(context, "refresh");
//     } else {
//       print("Error: ${resp.statusCode}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Patient Form"),
//         elevation: 5,
//       ),
//       body: Container(
//         margin: const EdgeInsets.all(10),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 initialValue: patient.name,
//                 decoration: const InputDecoration(
//                   labelText: "Fullname",
//                   icon: Icon(Icons.person),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "This field is required";
//                   }
//                   return null;
//                 },
//                 onSaved: (newValue) => patient.name = newValue!,
//               ),
//               genderFormInput(),
//               TextFormField(
//                 initialValue: patient.age != null ? patient.age.toString() : "",
//                 decoration: const InputDecoration(
//                   labelText: "Age:",
//                   icon: Icon(Icons.person),
//                 ),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "This field is required";
//                   }
//                   final age = int.tryParse(value);
//                   if (age == null || age < 0) {
//                     return "Invalid age";
//                   }
//                   return null;
//                 },
//                 onSaved: (newValue) {
//                   final age = int.tryParse(newValue!);
//                   patient.age = age;
//                 },
//               ),
//               TextFormField(
//                 initialValue: patient.symptoms,
//                 decoration: const InputDecoration(
//                   labelText: "Symptoms:",
//                   icon: Icon(Icons.healing),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "This field is required";
//                   }
//                   return null;
//                 },
//                 onSaved: (newValue) => patient.symptoms = newValue!,
//               ),
//               TextFormField(
//                 initialValue: patient.disease,
//                 decoration: const InputDecoration(
//                   labelText: "Disease:",
//                   icon: Icon(Icons.local_hospital),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "This field is required";
//                   }
//                   return null;
//                 },
//                 onSaved: (newValue) => patient.disease = newValue!,
//               ),
//               TextFormField(
//                 initialValue: patient.treatment,
//                 decoration: const InputDecoration(
//                   labelText: "Treatment:",
//                   icon: Icon(Icons.medical_services),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return "This field is required";
//                   }
//                   return null;
//                 },
//                 onSaved: (newValue) => patient.treatment = newValue!,
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     await addOrUpdatePatient();
//                     Navigator.of(context).pop();
//                   }
//                 },
//                 child: const Text("Save"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget genderFormInput() {
//     final initGen = patient.gender != null ? patient.gender! : "None";
//     return DropdownButtonFormField(
//       value: initGen,
//       decoration:
//           const InputDecoration(labelText: "Gender:", icon: Icon(Icons.man)),
//       items: Configure.gender.map((String val) {
//         return DropdownMenuItem(
//           value: val,
//           child: Text(val),
//         );
//       }).toList(),
//       onChanged: (value) {
//         patient.gender = value;
//       },
//       onSaved: (newValue) => patient.gender = newValue!,
//     );
//   }
// }

i