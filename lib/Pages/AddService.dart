import 'package:flutter/material.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Add Service"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: ServiceForm(),
    );
  }
}

class ServiceForm extends StatefulWidget {
  @override
  _ServiceFormState createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  @override
  final addProcedureFormKey = GlobalKey<FormState>();
  String ServiceName;
  String ServiceDescription;

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
                        widgetServiceName(),
                        widgetDescription(),
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
  Widget widgetServiceName() {
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
                labelText: 'Service Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              ServiceName = value;
            },
          ),
        ),
      ],
    );
  }
  Widget widgetDescription() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 300,
            maxLines: 5,
            decoration: InputDecoration(
                icon: Icon(Icons.description),
                border: OutlineInputBorder(),
                labelText: 'Service Description'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              ServiceDescription = value;
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
