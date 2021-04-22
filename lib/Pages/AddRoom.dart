import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class AddRoom extends StatefulWidget {
  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Add Room"),
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
  final addRoomFormKey = GlobalKey<FormState>();
  String RoomNo;
  String RoomType;
  String RoomCapacity;
  String Charges;

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
                key: addRoomFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    Column(
                      children: [
                        widgetroomNo(),
                        widgetRoomType(),
                        widgetCapacity(),
                        widgetCharges(),
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
  Widget widgetroomNo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 6,
            decoration: InputDecoration(
                icon: Icon(Icons.fact_check),
                border: OutlineInputBorder(),
                labelText: 'Room No'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              RoomNo = value;
            },
          ),
        ),
      ],
    );
  }
  Widget widgetRoomType() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,

      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropDownFormField(
            value: RoomType,
            titleText: 'Speciality',
            hintText: 'Please choose one',

            onSaved: (value) {
              setState(() {
                RoomType = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                RoomType = value;
              });
            },
            dataSource: [
              {
                "display": "Typ-1",
                "value": "1",
              },
              {
                "display": "Typ-2",
                "value": "2",
              },
              {
                "display": "Typ-3",
                "value": "3",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ],
    );
  }
  Widget widgetCapacity() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 2,
            decoration: InputDecoration(
                icon: Icon(Icons.fact_check),
                border: OutlineInputBorder(),
                labelText: 'Room Capacity'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              RoomNo = value;
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
            maxLength: 4,
            decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(),
                labelText: 'Room Charges(Per Hour)'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              Charges = value;
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
                if (!addRoomFormKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                      Text('Error: Some input fields are not filled.')));
                  return;
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Successfull')));
                addRoomFormKey.currentState.save();
              },
            ),
          ),
        ),
      ],
    );
  }

}
