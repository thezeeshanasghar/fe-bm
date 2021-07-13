import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
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
          title: Text(Strings.titleHomePage),
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
                      backgroundImage: AssetImage('assets/joker.jpg'),
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
                title: Text(Strings.titleAddDoctor),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Strings.routeAddDoctor);
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle_outlined),
                title: Text(Strings.titleAddNurse),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Strings.routeAddNurse);
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle_outlined),
                title: Text(Strings.titleAddReceptionist),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Strings.routeAddReceptionist);
                },
              ),
              ListTile(
                leading: Icon(Icons.list_alt),
                title: Text(Strings.titleAddProcedures),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Strings.routeAddProcedures);
                },
              ),
              ListTile(
                leading: Icon(Icons.add_circle_outlined),
                title: Text(Strings.titleAddRoom),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, Strings.routeAddRoom);
                },
              ),
              ListTile(
                  leading: Icon(Icons.cleaning_services),
                  title: Text(Strings.titleAddService),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Strings.routeAddService);
                  }),
              ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text(Strings.titleNurseAppointment),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Strings.routeNurseAppointment);
                  }),
              ListTile(
                  leading: Icon(Icons.list_alt),
                  title: Text(Strings.titlePatientList),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Strings.routePatientList);
                  }),
              ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(Strings.titleLogout),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Strings.routePatientList);
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
                              widgetRowHeaderOne(),
                              widgetRowOne(),
                              widgetRowTwo(),
                              widgetRowHeaderTwo(),
                              widgetRowThree(),
                              widgetRowFour(),
                              widgetRowFive()
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

  Widget widgetRowHeaderOne() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'For adding data in database',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetRowHeaderTwo() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.ltr,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'To view data that is present in database',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
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
        widgetDoctorListCard(),
      ],
    );
  }

  Widget widgetRowFour() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetNurseListCard(),
        widgetReceptionistListCard(),
        widgetProcedureListCard(),
      ],
    );
  }

  Widget widgetRowFive() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetRoomListCard(),
        widgetServiceListCard(),
        widgetAccountsCard(),
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

  Widget widgetServiceListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Strings.routeServiceList);
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
                      Strings.titleServiceList,
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
                      'Click to view the list of doctors',
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

  Widget widgetAccountsCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Strings.routeAccounts);
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
                      Strings.titleAccounts,
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
                      'Click to view the Accounts',
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

  Widget widgetRoomListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Strings.routeRoomList);
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
                      Strings.titleRoomList,
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
                      'Click to view the list of doctors',
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

  Widget widgetProcedureListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Strings.routeProcedureList);
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
                      Strings.titleProcedureList,
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
                      'Click to view the list of doctors',
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

  Widget widgetReceptionistListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Strings.routeReceptionistList);
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
                      Strings.titleReceptionistList,
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
                      'Click to view the list of doctors',
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

  Widget widgetNurseListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Strings.routeNurseList);
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
                      Strings.titleNurseList,
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
                      'Click to view the list of doctors',
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

  Widget widgetDoctorListCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Strings.routeDoctorList);
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
                      Strings.titleDoctorList,
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
                      'Click to view the list of doctors',
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

  Widget widgetAddDoctorCard() {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Strings.routeAddDoctor);
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
                      Strings.titleAddDoctor,
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
          Navigator.pushNamed(context, Strings.routeAddNurse);
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
                      Strings.titleAddNurse,
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
          Navigator.pushNamed(context, Strings.routeAddProcedures);
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
                      Strings.titleAddProcedures,
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
          Navigator.pushNamed(context, Strings.routeAddReceptionist);
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
                      Strings.titleAddReceptionist,
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
          Navigator.pushNamed(context, Strings.routeAddRoom);
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
                      Strings.titleAddRoom,
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
          Navigator.pushNamed(context, Strings.routeAddService);
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
                      Strings.titleAddService,
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
          Navigator.pushNamed(context, Strings.routeNurseAppointment);
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
                      Strings.titleNurseAppointment,
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
          Navigator.pushNamed(context, Strings.routePatientList);
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
                      Strings.titlePatientList,
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
