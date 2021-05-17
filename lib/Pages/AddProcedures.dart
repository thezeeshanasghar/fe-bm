import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:flutter/material.dart';

class AddProcedures extends StatefulWidget {
  @override
  _AddProceduresState createState() => _AddProceduresState();
}

class _AddProceduresState extends State<AddProcedures> {
  @override
  final formKey = GlobalKey<FormState>();
  String ProcedureName;
  String PerformedBy;
  double Charges;
  double Share;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text("Add Procedures"),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        widgetProcedureName(),
                        widgetPerformedBy(),
                        widgetCharges(),
                        widgetShare(),
                        widgetSubmit()
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget widgetProcedureName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 30,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.fact_check),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 5,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(),
                labelText: 'Charges'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              if (double.tryParse(value) <= 0) {
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 3,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.monetization_on),
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
              Share = double.tryParse(value);
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
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimens.globalInputFieldleft,
                Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight,
                Dimens.globalInputFieldBottom),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                primary: Shade.submitButtonColor,
                minimumSize: Size(double.infinity, 45),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              child: Text('Submit'),
              onPressed: () {
                if (!formKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                      Text('Error: Some input fields are not filled.')));
                  return;
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Doctor added')));
                formKey.currentState.save();
              },
            ),
          ),
        ),
      ],
    );
  }
}
