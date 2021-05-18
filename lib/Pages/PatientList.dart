import 'package:flutter/material.dart';
import 'dart:developer';

import '../Service/ProcedureService.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Patient List';

    // print(resp);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: PatientListForm(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class PatientListForm extends StatefulWidget {
  @override
  _PatientListFormState createState() => _PatientListFormState();
}

class _PatientListFormState extends State<PatientListForm> {
  final PatientListFormKey = GlobalKey<FormState>();
  final doctorController = TextEditingController();
  String ValueChoose;
  List listitem = ["Admitted", "Non Admitted"];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.minHeight,
              ),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Form(
                    key: PatientListFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        widgetPatientType(),
                        widgetCard(),
                        // widgetCard(),
                        // widgetCard(),
                        // widgetCard()
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    doctorController.dispose();
    super.dispose();
  }

  Widget widgetSizedBox() {
    return SizedBox(
      height: 30,
    );
  }

  Widget widgetCard() {
    return Center(
        child: Container(
      padding: new EdgeInsets.all(1.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.grey[100],
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40.0,
                        child: ClipRRect(
                          child: Image.asset('doctordp.jpg'),
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Anees Ahmad',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 24.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                SizedBox(width: 10),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 0,
                  ),
                  child: Text(
                    'Zahoor Ahmad',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  '03125700122',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ButtonBar(
                    children: <Widget>[
                      ElevatedButton(
                        child: Text(
                          "Monitor",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      ElevatedButton(
                        child: Text(
                          "Medication",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      ElevatedButton(
                        child: Text(
                          "Admit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          /* ... */
                        },
                      ),
                      // ElevatedButton(
                      //   child: Text(
                      //     "Other",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      //   onPressed: () {
                      //     /* ... */
                      //   },
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Widget widgetPatientType() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropdownButton(
            hint: Text("Select Patient"),
            isExpanded: true,
            dropdownColor: Colors.grey[100],
            value: ValueChoose,
            onChanged: (newValue) {
              setState(() {
                ValueChoose = newValue;
              });
            },
            items: listitem.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
