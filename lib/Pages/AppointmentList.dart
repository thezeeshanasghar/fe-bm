import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Pages/OnlineList.dart';
import 'package:baby_doctor/Pages/WalkInList.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Service/PatientService.dart';

class AppointmentList extends StatefulWidget {
  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  bool walkIn = true;
  bool online = false;
  final formKey = GlobalKey<FormState>();
  PatientService patientService;

  @override
  void initState() {
    super.initState();
    patientService = PatientService();
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
        title: Text(Strings.titleAppointmentList),
        centerTitle: false,
        backgroundColor: Shade.globalAppBarColor,
        elevation: 0.0,
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.minHeight,
                ),
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
                          widgetTableType(),
                          SizedBox(height: 20),
                          if (walkIn) WalkInList(),
                          if (online) OnlineList(),
                          // if (admitted) AdmittedList(),
                        ],
                      ),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }

  String TableType = 'Walk-in Patients';

  Widget widgetTableType() {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'Choose Appointment Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Walk-in Patients'),
                        value: "Walk-in Patients",
                        groupValue: TableType,
                        onChanged: (String value) {
                          setState(() {
                            TableType = value;
                            walkIn = true;
                            online = false;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Online'),
                        value: "online",
                        groupValue: TableType,
                        onChanged: (String value) {
                          setState(() {
                            TableType = value;
                            walkIn = false;
                            online = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
