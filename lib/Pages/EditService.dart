import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Service/Service.dart';
import 'package:baby_doctor/ShareArguments/ServiceArguments.dart';
import 'package:flutter/material.dart';

import 'package:baby_doctor/Models/Services.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class EditService extends StatefulWidget {
  @override
  _EditServiceState createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  @override
  final formKey = GlobalKey<FormState>();
  String Id;
  String ServiceName;
  String ServiceDescription;
  bool isLoading = false;
  Service service;
  SimpleFontelicoProgressDialog sfpd;
  TextEditingController TecServiceName;
  TextEditingController TecServiceDescription;

  ServiceArguments arguments;

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
                        if (!isLoading) widgetServiceName(),
                        if (!isLoading) widgetServiceDescription(),
                        if (!isLoading) widgetSubmit(),
                        if (isLoading) widgetCircularProgress(),
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
    initVariablesAndClasses();
  }

  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    arguments = ModalRoute.of(context).settings.arguments;
    setValuesOfProcedures();
  }

  void initVariablesAndClasses() {
    TecServiceName = new TextEditingController();
    TecServiceDescription = new TextEditingController();
    service = Service();
  }

  void setValuesOfProcedures() {
    setState(() {
      TecServiceName.text = arguments.name;
      TecServiceDescription.text = arguments.description;
      isLoading = false;
    });
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
            controller: TecServiceName,
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

  Widget widgetServiceDescription() {
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
            controller: TecServiceDescription,
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

  Widget widgetCircularProgress() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text('Please wait...'),
            ],
          ),
        ],
      ),
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
              child: Text(Strings.submitGlobal),
              onPressed: () {
                onPressedSubmitButton();
              },
            ),
          ),
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
    formKey.currentState.save();
    sfpd = SimpleFontelicoProgressDialog(
        context: context, barrierDimisable: false);
    await sfpd.show(
        message: 'Updating ...',
        type: SimpleFontelicoProgressDialogType.threelines,
        width: MediaQuery.of(context).size.width - 20,
        horizontal: true);
    ServiceData obj = new ServiceData(
      id: arguments.id,
      name: ServiceName,
      description: ServiceDescription,
    );
    var response = await service.UpdateServices(obj);
    print(response);
    if (response == true) {
      await sfpd.hide();
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
      Navigator.pushNamed(context, Strings.routeServiceList);
    } else {
      await sfpd.hide();
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
    }
  }
}
