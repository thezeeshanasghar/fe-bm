
import 'package:baby_doctor/Pages/AddDoctor.dart';
import 'package:baby_doctor/Pages/AddNurse.dart';
import 'package:baby_doctor/Pages/AddProcedures.dart';
import 'package:baby_doctor/Pages/Home.dart';
import 'package:baby_doctor/Pages/AddReceptionist.dart';
import 'package:baby_doctor/Pages/PatientList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/AddDoctor': (context) => AddDoctor(),
      '/AddNurse': (context) => AddNurse(),
      '/AddProcedures': (context) => AddProcedures(),
      '/AddReceptionist': (context) => AddReceptionist(),
      '/PatientList': (context) => PatientList(),
      '/': (context) => Home(),
    },
  ));
}
