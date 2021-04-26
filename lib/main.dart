
import 'package:baby_doctor/Pages/AddDoctor.dart';
import 'package:baby_doctor/Pages/AddNurse.dart';
import 'package:baby_doctor/Pages/AddProcedures.dart';
import 'package:baby_doctor/Pages/Home.dart';

import 'package:baby_doctor/Pages/AddReceptionist.dart';
import 'package:baby_doctor/Pages/PatientList.dart';

import 'package:baby_doctor/Pages/NurseAppointment.dart';

import 'package:flutter/material.dart';
import 'package:baby_doctor/Pages/AddService.dart';
import 'package:baby_doctor/Pages/AddRoom.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/AddRoom': (context) => AddRoom(),
      '/AddService': (context) => AddService(),
      '/AddDoctor': (context) => AddDoctor(),
      '/AddNurse': (context) => AddNurse(),
      '/AddProcedures': (context) => AddProcedures(),

      '/AddReceptionist': (context) => AddReceptionist(),
      '/PatientList': (context) => PatientList(),

      '/NurseAppointment': (context)=> NurseAppointment(),

      '/': (context) => Home(),
    },
  ));
}
