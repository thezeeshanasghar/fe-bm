import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/ServiceRequest.dart';
import 'package:baby_doctor/Models/Responses/ServiceResponse.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/Service.dart';
import 'package:baby_doctor/ShareArguments/ServiceArguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class EditService extends StatefulWidget {
  @override
  _EditServiceState createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  final formKey = GlobalKey<FormState>();
  String Id;
  String ServiceName;
  String ServiceDescription;
  bool isLoading = true;
  Service service;
  SimpleFontelicoProgressDialog sfpd;
  TextEditingController tecServiceName;
  TextEditingController tecServiceDescription;
  ServiceArguments arguments;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
  }

  @override
  void didChangeDependencies() async {
    if (!hasChangeDependencies) {
      arguments = ModalRoute.of(context).settings.arguments;
      globalProgressDialog = GlobalProgressDialog(context);
      setValuesOfProcedures();
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
  }

  @override
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
                  padding: EdgeInsets.fromLTRB(Dimens.globalPaddingLeft, Dimens.globalPaddingTop,
                      Dimens.globalPaddingRight, Dimens.globalPaddingBottom),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        !isLoading
                            ? Column(
                                children: [
                                  widgetServiceName(),
                                  widgetServiceDescription(),
                                  widgetSubmit(),
                                ],
                              )
                            : widgetCircularProgress(),
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

  void initVariablesAndClasses() {
    tecServiceName = new TextEditingController();
    tecServiceDescription = new TextEditingController();
    service = Service();
  }

  void setValuesOfProcedures() {
    setState(() {
      tecServiceName.text = arguments.name;
      tecServiceDescription.text = arguments.description;
      isLoading = false;
    });
  }

  Widget widgetServiceName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 30,
            controller: tecServiceName,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.fact_check), border: OutlineInputBorder(), labelText: 'Service Name'),
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 100,
            controller: tecServiceDescription,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Service Description'),
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
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                primary: Shade.submitButtonColor,
                minimumSize: Size(double.infinity, 45),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              child: Text(Strings.submitGlobal),
              onPressed: () => onPressedSubmit(),
            ),
          ),
        )
      ],
    );
  }

  Future<void> onPressedSubmit() async {
    if (!formKey.currentState.validate()) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorInputValidation, context);
      return;
    }
    formKey.currentState.save();

    globalProgressDialog.showSimpleFontellicoProgressDialog(
        false, Strings.dialogUpdating, SimpleFontelicoProgressDialogType.multilines);
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        ServiceResponse serviceResponse = await service.updateService(
            ServiceRequest(
              id: arguments.id,
              name: ServiceName,
              description: ServiceDescription,
            ),
            context.read<TokenProvider>().tokenSample.jwtToken);
        if (serviceResponse != null) {
          if (serviceResponse.isSuccess) {
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, serviceResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
            Navigator.pop(context);
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, serviceResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
          }
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }
}
