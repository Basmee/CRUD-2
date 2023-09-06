import 'package:flutter_application_19/screen/users.dart';
import 'package:flutter_application_19/screen/patient.dart';

class Configure {
  static const server = "172.20.10.10:3000";
  static Users login = Users();
  static Patients patients = Patients();
  static List<String> gender = [
    "None",
    "Male",
    "Female",
  ];
}
