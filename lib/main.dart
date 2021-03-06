import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Pages/Accounts.dart';
import 'package:baby_doctor/Pages/AddDoctor.dart';
import 'package:baby_doctor/Pages/AddNurse.dart';
import 'package:baby_doctor/Pages/AddProcedures.dart';
import 'package:baby_doctor/Pages/AdminPatients.dart';
import 'package:baby_doctor/Pages/AdmittedList.dart';
import 'package:baby_doctor/Pages/BedTime.dart';
import 'package:baby_doctor/Pages/DoctorList.dart';
import 'package:baby_doctor/Pages/EditDoctor.dart';
import 'package:baby_doctor/Pages/EditNurse.dart';
import 'package:baby_doctor/Pages/EditReceptionist.dart';
import 'package:baby_doctor/Pages/EditService.dart';
import 'package:baby_doctor/Pages/ExpenseList.dart';
import 'package:baby_doctor/Pages/Home.dart';
import 'package:baby_doctor/Pages/AddReceptionist.dart';
import 'package:baby_doctor/Pages/AppointmentList.dart';
import 'package:baby_doctor/Pages/InvoiceList.dart';
import 'package:baby_doctor/Pages/Login.dart';
import 'package:baby_doctor/Pages/Nurse%20Share.dart';
import 'package:baby_doctor/Pages/NurseList.dart';
import 'package:baby_doctor/Pages/NurseMedication.dart';
import 'package:baby_doctor/Pages/OnlineList.dart';
import 'package:baby_doctor/Pages/PatientList.dart';
import 'package:baby_doctor/Pages/NurseAppointment.dart';
import 'package:baby_doctor/Pages/ProcedureList.dart';
import 'package:baby_doctor/Pages/ReceptionistList.dart';
import 'package:baby_doctor/Pages/ServiceList.dart';
import 'package:baby_doctor/Pages/WalkInList.dart';
import 'package:baby_doctor/Providers/LoginCredentialsProvider.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Pages/AddService.dart';
import 'package:baby_doctor/Pages/EditProcedures.dart';
import 'package:provider/provider.dart';

import 'Pages/MonthlyShare.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TokenProvider()),
        ChangeNotifierProvider(create: (_) => LoginCredentialsProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Strings.routeLogin,
      routes: {
        Strings.routeAddService: (context) => AddService(),
        Strings.routeAddDoctor: (context) => AddDoctor(),
        Strings.routeAddNurse: (context) => AddNurse(),
        Strings.routeAddProcedures: (context) => AddProcedures(),
        Strings.routeAddReceptionist: (context) => AddReceptionist(),
        Strings.routePatientList: (context) => PatientList(),
        Strings.routeAppointmentList: (context) => AppointmentList(),
        Strings.routeOnlinePatientList: (context) => OnlineList(),
        Strings.routeWalkInPatientList: (context) => WalkInList(),
        Strings.routeAdmittedPatientList: (context) => AdmittedList(),
        Strings.routeNurseAppointment: (context) => NurseAppointment(),
        Strings.routeDoctorList: (context) => DoctorList(),
        Strings.routeNurseList: (context) => NurseList(),
        Strings.routeReceptionistList: (context) => ReceptionistList(),
        Strings.routeProcedureList: (context) => ProcedureList(),
        Strings.routeServiceList: (context) => ServiceList(),
        Strings.routeExpenseList: (context) => ExpenseList(),
        Strings.routeInvoiceList: (context) => InvoiceList(),
        Strings.routeHomePage: (context) => Home(),
        '/NurseMedication': (context) => NurseMedication(),
        '/BedTime': (context) => BedTime(),
        '/NurseShare': (context) => NurseShare(),
        '/MonthlyShare': (context) => MonthlyShare(),
        '/AdminPatient': (context) => AdminPatient(),
        Strings.routeEditProcedure: (context) => EditProcedures(),
        Strings.routeEditService: (context) => EditService(),
        Strings.routeEditReceptionist: (context) => EditReceptionist(),
        Strings.routeEditDoctor: (context) => EditDoctor(),
        Strings.routeEditNurse: (context) => EditNurse(),
        Strings.routeAccounts: (context) => Accounts(),
        Strings.routeLogin: (context) => Login(),
      },
    );
  }
}
