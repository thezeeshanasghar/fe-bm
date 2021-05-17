import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Pages/AddDoctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return HomeDrawer();
  }
}

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
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
    return Scaffold(
        backgroundColor: Shade.globalBackgroundColor,
        appBar: AppBar(
          title: Text('Admin'),
          backgroundColor: Shade.globalAppBarColor,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Shade.drawerHeaderColor,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                      AssetImage('assets/joker.jpg'),
                      radius: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: Text(
                        'Syed Basit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.add_circle_outlined),
                title: Text('Add Doctor'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/AddDoctor');
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle_outlined),
                title: Text('Add Nurse'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/AddNurse');
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle_outlined),
                title: Text('Receptionist'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/AddReceptionist');
                },
              ),
              ListTile(
                leading: Icon(Icons.list_alt),
                title: Text('Add Procedures'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/AddProcedures');
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle_outlined),
                title: Text('Add Room'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/AddRoom');
                },
              ),
              ListTile(
                  leading: Icon(Icons.cleaning_services),
                  title: Text('Add Service'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/AddService');
                  }),
              ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text('Nurse Appointments'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/NurseAppointment');
                  }),
              ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text('Patient List'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/PatientList');
                  })
            ],
          ),
        ),
        body: Scaffold(
          backgroundColor: Colors.grey[100],
          body: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2,
            child: LayoutBuilder(
              builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.minHeight,
                        minWidth: viewportConstraints.minWidth),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            Dimens.globalPaddingLeft,
                            Dimens.globalPaddingTop,
                            Dimens.globalPaddingRight,
                            Dimens.globalPaddingBottom),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              widgetRowOne(),
                              widgetRowTwo(),
                              widgetRowThree(),
                            ],
                          ),
                        )),
                  ),
                );
              },
            ),
          ),
        ));
  }

  Widget widgetRowOne() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetAddDoctorCard(),
        widgetAddNurseCard(),
        widgetAddReceptionistCard(),
      ],
    );
  }

  Widget widgetRowTwo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetAddProcedureCard(),
        widgetAddRoomCard(),
        widgetAddServiceCard(),
      ],
    );
  }

  Widget widgetRowThree() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetNurseAppointmentsCard(),
        widgetPatientListCard(),
        widgetDummySpaceCard(),
      ],
    );
  }


  Widget widgetDummySpaceCard() {
    return Expanded(
      child: Text(
        'Click to create the account of a doctor',
        style: TextStyle(color: Shade.globalBackgroundColor),
      ),
    );
  }

  Widget widgetAddDoctorCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/AddDoctor');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.add_circle_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Doctor',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to create the account of a doctor',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetAddNurseCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/AddNurse');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.add_circle_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Nurse',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to create the account of a nurse',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetAddProcedureCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/AddProcedures');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.list_alt_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Procedure',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to add procedure',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetAddReceptionistCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/AddReceptionist');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.add_circle_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Receptionist',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to create the account of a receptionist',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetAddRoomCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/AddRoom');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.add_circle_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Room',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to create the room of a hospital',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetAddServiceCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/AddService');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.cleaning_services),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Service',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to create a new service',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetAdminPatientsCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/AdminPatient');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.list_alt_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin Patients',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to view Admin Patients',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetBedTimeCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/BedTime');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.king_bed), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bed Time',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to view Bed Time',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetNurseAppointmentsCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/NurseAppointment');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.ac_unit), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nurse Appointments',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to create the account of a receptionist',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetPatientListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/PatientList');
        },
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    child: FittedBox(
                        child: Icon(Icons.list_alt_outlined),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Patient List',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click to view the list of patients',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
