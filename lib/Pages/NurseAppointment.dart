import 'package:flutter/material.dart';

class NurseAppointment extends StatefulWidget {
  @override
  _NurseAppointmentState createState() => _NurseAppointmentState();
}

class _NurseAppointmentState extends State<NurseAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Nurse Appointments"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: AppointmentsList(),
    );
  }
}

class AppointmentsList extends StatefulWidget {
  @override
  _AppointmentsListState createState() => _AppointmentsListState();
}

class _AppointmentsListState extends State<AppointmentsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            DataTable(
              columns: [
                DataColumn(
                    label: Text('Name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('Date Time',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
                DataColumn(
                    label: Text('',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold))),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('Stephen')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {},
                    child: Text("Delete"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('John')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {},
                    child: Text("Delete"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('Harry')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {  },
                    child: Text("Delete"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('Peter')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {  },
                    child: Text("Delete"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('Peter')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {  },
                    child: Text("Delete"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('Peter')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {  },
                    child: Text("Delete"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('Peter')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {  },
                    child: Text("Delete"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('Peter')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {  },
                    child: Text("Delete"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('Peter')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {  },
                    child: Text("Delete"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('Peter')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {  },
                    child: Text("Delete"),
                  ))
                ]),
                DataRow(cells: [
                  DataCell(Text('Peter')),
                  DataCell(Text('Feb 23, 2021, 08:12 pm')),
                  DataCell(ElevatedButton(
                    onPressed: () {  },
                    child: Text("Delete"),
                  ))
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
