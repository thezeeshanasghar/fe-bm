import 'package:flutter/material.dart';

class AddProcedures extends StatefulWidget {
  @override
  _AddProcedureState createState() => _AddProcedureState();
}

class _AddProcedureState extends State<AddProcedures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Add Procedure"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: ProcedureForm(),
    );
  }
}

class ProcedureForm extends StatefulWidget {
  @override
  _ProcedureFormState createState() => _ProcedureFormState();
}

class _ProcedureFormState extends State<ProcedureForm> {
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    color: const Color(0xffeeee00), // Yellow
                    alignment: Alignment.center,
                    child: const Text('Fixed Height Content'),
                  ),
                  Container(
                    color: const Color(0xff008000), // Green
                    alignment: Alignment.center,
                    child: const Text('Fixed Height Content'),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Last Name'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
