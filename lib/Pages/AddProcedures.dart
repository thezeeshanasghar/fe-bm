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
  final addProcedureFormKey = GlobalKey<FormState>();
  String ProcedureName;
  String PerformedBy;
  double Charges;
  double Share;
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
          child: Form(
          key: addProcedureFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  Column(
                    children: [
                      widgetProcedureName(),
                      widgetPerformedBy(),
                      widgetCharges(),
                      widgetShare(),
                      widgetSubmit()
                    ],

                  )
                ],
              ),
          ),
            ),
          );
        },
      ),
    );
  }
  Widget widgetProcedureName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 30,
            decoration: InputDecoration(
                icon: Icon(Icons.fact_check),
                border: OutlineInputBorder(),
                labelText: 'Procedure Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              ProcedureName = value;
            },
          ),
        ),
      ],
    );
  }
  Widget widgetPerformedBy() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'Performed By'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              PerformedBy = value;
            },
          ),
        ),
      ],
    );
  }
  Widget widgetCharges() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 5,
            decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(),
                labelText: 'Charges'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              if(double.tryParse(value)<=0){
                return 'Input Error: cannot enter negative digits';
              }
              return null;
            },
            onSaved: (String value) {
              Charges = double.parse(value);
            },
          ),
        ),
      ],
    );
  }
  Widget widgetShare() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 3,
            decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(),
                labelText: 'Performer Share'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              //if(value>=0 || value<=100){
               // return 'This field cannot be empty';
              //}
              return null;
            },
            onSaved: (String value) {
              Share =double.tryParse(value);
            },
          ),
        ),
      ],
    );
  }

  Widget widgetSubmit() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Submit'),
              onPressed: () {
                if (!addProcedureFormKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                      Text('Error: Some input fields are not filled.')));
                  return;
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Successfull')));
                addProcedureFormKey.currentState.save();
              },
            ),
          ),
        ),
      ],
    );
  }

}

