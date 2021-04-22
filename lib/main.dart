
import 'package:baby_doctor/Pages/AddDoctor.dart';
import 'package:baby_doctor/Pages/AddNurse.dart';
import 'package:baby_doctor/Pages/AddProcedures.dart';
import 'package:baby_doctor/Pages/Home.dart';
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
      '/': (context) => Home(),
    },
  ));
}
