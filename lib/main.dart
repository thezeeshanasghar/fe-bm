import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Pages/AddDoctor.dart';
import 'package:baby_doctor/Pages/AddNurse.dart';
import 'package:baby_doctor/Pages/AddProcedures.dart';
import 'package:baby_doctor/Pages/AdminPatients.dart';
import 'package:baby_doctor/Pages/BedTime.dart';
import 'package:baby_doctor/Pages/DoctorList.dart';
import 'package:baby_doctor/Pages/EditRoom.dart';
import 'package:baby_doctor/Pages/EditService.dart';
import 'package:baby_doctor/Pages/Home.dart';
import 'package:baby_doctor/Pages/AddReceptionist.dart';
import 'package:baby_doctor/Pages/Nurse%20Share.dart';
import 'package:baby_doctor/Pages/NurseList.dart';
import 'package:baby_doctor/Pages/NurseMedication.dart';
import 'package:baby_doctor/Pages/PatientList.dart';
import 'package:baby_doctor/Pages/NurseAppointment.dart';
import 'package:baby_doctor/Pages/ProcedureList.dart';
import 'package:baby_doctor/Pages/ReceptionistList.dart';
import 'package:baby_doctor/Pages/RoomList.dart';
import 'package:baby_doctor/Pages/ServiceList.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Pages/AddService.dart';
import 'package:baby_doctor/Pages/AddRoom.dart';
import 'package:baby_doctor/Pages/EditProcedures.dart';

import 'Pages/MonthlyShare.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: Strings.routeHomePage,
    routes: {
      Strings.routeAddRoom: (context) => AddRoom(),
      Strings.routeAddService: (context) => AddService(),
      Strings.routeAddDoctor: (context) => AddDoctor(),
      Strings.routeAddNurse: (context) => AddNurse(),
      Strings.routeAddProcedures: (context) => AddProcedures(),
      Strings.routeAddReceptionist: (context) => AddReceptionist(),
      Strings.routePatientList: (context) => PatientList(),
      Strings.routeNurseAppointment: (context) => NurseAppointment(),
      Strings.routeAddRoom: (context) => AddRoom(),
      Strings.routeDoctorList: (context) => DoctorList(),
      Strings.routeNurseList: (context) => NurseList(),
      Strings.routeReceptionistList: (context) => ReceptionistList(),
      Strings.routeProcedureList: (context) => ProcedureList(),
      Strings.routeRoomList: (context) => RoomList(),
      Strings.routeServiceList: (context) => ServiceList(),
      Strings.routeHomePage: (context) => Home(),
      '/NurseMedication': (context) => NurseMedication(),
      '/BedTime': (context) => BedTime(),
      '/NurseShare': (context) => NurseShare(),
      '/MonthlyShare': (context) => MonthlyShare(),
      '/AdminPatient': (context) => AdminPatient(),
      Strings.routeEditProcedure:(context)=>EditProcedures(),
      Strings.routeEditService:(context)=>EditService(),
      Strings.routeEditRoom:(context)=>EditRoom()
    },
  ));
}
