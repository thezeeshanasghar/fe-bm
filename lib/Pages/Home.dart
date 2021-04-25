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
      appBar: AppBar(
        title: Text('Hi Doctor,'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
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