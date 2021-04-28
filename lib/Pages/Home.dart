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

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Hi Admin,'),
        backgroundColor: Colors.grey,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              child: Text(
                'Hi Doctor!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Add Doctor'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/AddDoctor');
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Add Nurse'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/AddNurse');
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Procedures'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/AddProcedures');
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Receptionist'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/AddReceptionist');
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('PatientList'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/PatientList');
              },
            ),
            ListTile(
                leading: Icon(Icons.timer),
                title: Text('Nurse Appointment'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/NurseAppointment');
                }),
            ListTile(
                leading: Icon(Icons.list_alt),
                title: Text('Services'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/AddService');
                }),
            ListTile(
                leading: Icon(Icons.list_alt),
                title: Text('Room'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/AddRoom');
                })
          ],
        ),
      ),
      body: Center(
        child: Text(
          'This is the home page',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
