import 'package:baby_doctor/Pages/AddDoctor.dart';
import 'package:baby_doctor/Pages/AddNurse.dart';
import 'package:baby_doctor/Pages/AddProcedures.dart';
import 'package:baby_doctor/Pages/AdminPatients.dart';
import 'package:baby_doctor/Pages/BedTime.dart';
import 'package:baby_doctor/Pages/Home.dart';
import 'package:baby_doctor/Pages/AddReceptionist.dart';
import 'package:baby_doctor/Pages/Nurse%20Share.dart';
import 'package:baby_doctor/Pages/NurseMedication.dart';
import 'package:baby_doctor/Pages/PatientList.dart';
import 'package:baby_doctor/Pages/NurseAppointment.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Pages/AddService.dart';
import 'package:baby_doctor/Pages/AddRoom.dart';

import 'Pages/MonthlyShare.dart';

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
      '/NurseAppointment': (context) => NurseAppointment(),
      '/NurseMedication': (context) => NurseMedication(),
      '/BedTime': (context) => BedTime(),
      '/NurseShare': (context) => NurseShare(),
      '/MonthlyShare': (context) => MonthlyShare(),
      '/AdminPatient': (context) => AdminPatient(),
      '/AddRoom': (context) => AddRoom(),
      '/': (context) => Home(),
    },
  ));
}
