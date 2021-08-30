import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/AuthenticateRequest.dart';
import 'package:baby_doctor/Models/Responses/AuthenticateResponse.dart';
import 'package:baby_doctor/Models/Responses/ServiceResponse.dart';
import 'package:baby_doctor/Models/Sample/TokenSample.dart';
import 'package:baby_doctor/Pages/AddDoctor.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/AuthenticationService.dart';
import 'package:baby_doctor/Service/Service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool hasChangeDependencies = false;
  TokenSample args;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      args = ModalRoute.of(context).settings.arguments;
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
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
                  Navigator.pushNamed(context, Strings.routeAddDoctor, arguments: args);
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
                    Navigator.pushNamed(context, Strings.routeLogin);
                  })
            ],
          ),
        ),
        body: Scaffold(
          backgroundColor: Colors.grey[100],
          body: DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyText2,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.minHeight, minWidth: viewportConstraints.minWidth),
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(Dimens.globalPaddingLeft, Dimens.globalPaddingTop,
                            Dimens.globalPaddingRight, Dimens.globalPaddingBottom),
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
                            style: TextStyle(fontWeight: Shade.fwHomeHeaders),
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
                            style: TextStyle(fontWeight: Shade.fwHomeHeaders),
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
        widgetAddServiceCard(),
        widgetDummySpaceCard(),
      ],
    );
  }

  Widget widgetRowThree() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetPatientListCard(),
        widgetDoctorListCard(),
        widgetNurseListCard(),
      ],
    );
  }

  Widget widgetRowFour() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetReceptionistListCard(),
        widgetProcedureListCard(),
        widgetServiceListCard(),
      ],
    );
  }

  Widget widgetRowFive() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.ltr,
      children: [
        widgetDummySpaceCard(),
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
                child: Container(child: FittedBox(child: Icon(Icons.list_alt_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleServiceList,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.list_alt_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleAccounts,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.list_alt_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleRoomList,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.list_alt_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleProcedureList,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.list_alt_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleReceptionistList,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.list_alt_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleNurseList,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.list_alt_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleDoctorList,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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

  Future<void> getServices() async {
    Service service = Service();
    ServiceResponseList serviceResponseList =
        await service.getServices(context.read<TokenProvider>().tokenSample.jwtToken);
    if (serviceResponseList != null) {
      if (serviceResponseList.isSuccess) {
        // successful so move to next screen
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, serviceResponseList.message, context);
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, serviceResponseList.message, context);
      }
    } else {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
    }
  }

  Widget widgetAddDoctorCard() {
    return Expanded(
      child: InkWell(
        onTap: () async {
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
                child: Container(child: FittedBox(child: Icon(Icons.add_circle_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleAddDoctor,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.add_circle_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleAddNurse,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.add_circle_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleAddProcedures,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.add_circle_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleAddReceptionist,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
        onTap: () {},
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(child: FittedBox(child: Icon(Icons.add_circle_outlined), fit: BoxFit.fill)),
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
                child: Container(child: FittedBox(child: Icon(Icons.add_circle_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleAddService,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.list_alt_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin Patients',
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.king_bed), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bed Time',
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
                child: Container(child: FittedBox(child: Icon(Icons.list_alt_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titleNurseAppointment,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
          // Navigator.pushNamed(context, Strings.routePatientList);
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, 'Working On It', context);
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
                child: Container(child: FittedBox(child: Icon(Icons.list_alt_outlined), fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Strings.titlePatientList,
                      style: TextStyle(fontWeight: Shade.fwHomeRowItems),
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
