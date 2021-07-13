import 'dart:developer';

import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Models/Services.dart';
import 'package:baby_doctor/Service/Service.dart' as DAL;
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  @override
  final formKey = GlobalKey<FormState>();
  String name;
  String description;
  SimpleFontelicoProgressDialog sfpd;
  bool loadingButtonProgressIndicator = false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleAddService),
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
              name = value;
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

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
              description = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetSubmit() {
    return Column(
      children: [
        loadingButtonProgressIndicator == false
            ? Align(
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                    child: Text('Submit'),
                    onPressed: () {
                      onClickDataPost();
                    },
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              )
      ],
    );
  }

  onClickDataPost() async {
    if (!formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Text('Error: Some input fields are not filled')));
      return;
    }
    formKey.currentState.save();
    sfpd = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    await sfpd.show(
        message: 'Loading...',
        type: SimpleFontelicoProgressDialogType.multilines,
        width: MediaQuery.of(context).size.width - 20,
        horizontal: true);
    DAL.Service service = new DAL.Service();
    ServiceData obj = new ServiceData(
      name: name,
      description: description,
    );
    var response = await service.InsertServices(obj);
    print(response);
    if (response == true) {
      await sfpd.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalSuccess,
          content: Row(
            children: [
              Text('Success: Created Service '),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
      formKey.currentState.reset();
      Navigator.pushNamed(context, Strings.routeServiceList);
    } else {
      await sfpd.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Row(
            children: [
              Text('Error: Try Again: Failed to add '),
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
      setState(() {
        loadingButtonProgressIndicator = false;
      });
    }
  }
}
