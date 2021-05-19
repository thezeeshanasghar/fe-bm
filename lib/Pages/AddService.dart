import 'dart:developer';

import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/model/Services.dart';
import 'package:baby_doctor/Service/Service.dart' as DAL;

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  @override
  final formKey = GlobalKey<FormState>();
  String ServiceName;
  String ServiceDescription;
  bool Isloading=false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text("Add Service"),
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
                        widgetServiceName(),
                        widgetDescription(),
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

  Widget widgetServiceName() {
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 100,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.description),
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
                onClickDataPost();
              },
            ),
          ),
        ),
      ],
    );
  }


  onClickDataPost()  async {
    if (!formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Some input fields are not filled.')));
      return;
    }
    setState((){Isloading = true;});
    formKey.currentState.save();

    //perform your task after save
    DAL.Service service =  new DAL.Service();
    Services obj = new Services(
      ServiceName: ServiceName,
      ServiceDescription: ServiceDescription,
    );
    var response= await service.InsertServices(obj);
    print(response);
    if(response==true)
    {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Success: Record Added Successfully.')));
      formKey.currentState.reset();
      setState((){Isloading = false;});
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Operation Unsuccessfull.')));
      setState((){Isloading = false;});
    }
  }
}
