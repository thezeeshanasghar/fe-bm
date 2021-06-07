import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Shade.globalBackgroundColor,
        appBar: AppBar(
          title: Text(Strings.titlePatientList),
          centerTitle: false,
          backgroundColor: Shade.globalAppBarColor,
          elevation: 0.0,
        ),
        body: PatientsTabController());
  }
}

class PatientsTabController extends StatefulWidget {
  const PatientsTabController({Key key}) : super(key: key);

  @override
  _PatientsTabControllerState createState() => _PatientsTabControllerState();
}

class _PatientsTabControllerState extends State<PatientsTabController> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define a controller for TabBar and TabBarViews
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          // Use ShiftingTabBar instead of appBar
          appBar: ShiftingTabBar(
            color: Colors.blueGrey,
            labelStyle: TextStyle(color: Colors.white70),
            tabs: <ShiftingTab>[
              // Also you should use ShiftingTab widget instead of Tab widget to get shifting animation
              ShiftingTab(
                icon: const Icon(
                  Icons.airline_seat_flat,
                  color: Colors.white70,
                ),
                text: 'Admitted',
              ),
              ShiftingTab(
                icon: const Icon(
                  Icons.call,
                  color: Colors.white70,
                ),
                text: 'On Call',
              ),
              ShiftingTab(
                icon: const Icon(
                  Icons.online_prediction,
                  color: Colors.white70,
                ),
                text: 'Online',
              ),
            ],
          ),

          body: const TabBarView(
            children: <Widget>[
              Icon(Icons.home),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_car),
            ],
          ),
        ),
      ),
    );
  }
}
