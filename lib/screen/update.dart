import 'package:flutter/material.dart';
import 'package:flutter_application_19/screen/patient.dart';

class UpdatePatientPage extends StatefulWidget {
  final Patients patient;

  UpdatePatientPage({required this.patient});

  @override
  _UpdatePatientPageState createState() => _UpdatePatientPageState();
}

class _UpdatePatientPageState extends State<UpdatePatientPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Patient Information:',
                style: TextStyle(fontSize: 18.0),
              ),
              TextFormField(
                initialValue: widget.patient.name,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                initialValue: widget.patient.age != null
                    ? widget.patient.age.toString()
                    : "",
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
                  }
                  int? age = int.tryParse(value);
                  if (age == null || age < 0) {
                    return 'Invalid age';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  int? age = int.tryParse(newValue!);
                  widget.patient.age = age;
                },
              ),
              TextFormField(
                initialValue: widget.patient.gender,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextFormField(
                initialValue: widget.patient.symptoms,
                decoration: InputDecoration(labelText: 'Symptoms'),
              ),
              TextFormField(
                initialValue: widget.patient.disease,
                decoration: InputDecoration(labelText: 'Disease'),
              ),
              TextFormField(
                initialValue: widget.patient.treatment,
                decoration: InputDecoration(labelText: 'Treatment'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Validate the form
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
