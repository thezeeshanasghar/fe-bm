import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Service/Service.dart';
import 'package:flutter/material.dart';

import 'package:baby_doctor/Models/Services.dart';

class EditService extends StatefulWidget {

  @override
  _EditServiceState createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  @override
  final formKey = GlobalKey<FormState>();
  String Id;
  String  ServiceName;
  String  ServiceDescription;

  bool loadingButtonProgressIndicator = false;
  Service service;
  TextEditingController _servicenamecontroller;
  TextEditingController _serviceDescriptioncontroller;

  dynamic arguments;
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleEditService),
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
                        widgetServiceDescription(),

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

  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() async {
    arguments = ModalRoute
        .of(context)
        .settings
        .arguments as Map;
    service = Service();
    if (arguments != null) {
      service.getServicesById(arguments["Id"]).then((value) {
        setState(() {
          _servicenamecontroller = new TextEditingController(text: value["name"]);
          _serviceDescriptioncontroller = new TextEditingController(text: value["description"]);
        });
      });
    }
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
            controller: _servicenamecontroller,
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

  Widget widgetServiceDescription(){
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
            controller: _serviceDescriptioncontroller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
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
              child: Text(Strings.submitGlobal),
              onPressed: () {
                onPressedSubmitButton();
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

  onPressedSubmitButton() async {
    if (!formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Text('Error: Some input fields are not filled')));
      return;
    }
    setState(() {
      loadingButtonProgressIndicator = true;
    });
    formKey.currentState.save();

    Services obj = new Services(
        id:arguments["Id"],
        name:  ServiceName,
        description:  ServiceDescription,
        );
    var response = await service.InsertServices(obj);
    print(response);
    if (response == true) {
      setState(() {
        loadingButtonProgressIndicator = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalSuccess,
          content: Row(
            children: [
              Text('Success:Service Updated'),
              Text(
               ServiceName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
      formKey.currentState.reset();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Row(
            children: [
              Text('Error: Try Again: Failed to edit '),
              Text(
               ServiceName,
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
