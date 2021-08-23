import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/ServiceRequest.dart';
import 'package:baby_doctor/Models/Responses/ServiceResponse.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/Service.dart';
import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:provider/provider.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final formKey = GlobalKey<FormState>();
  String name;
  String description;
  SimpleFontelicoProgressDialog sfpd;
  bool loadingButtonProgressIndicator = false;
  GlobalProgressDialog globalProgressDialog;
  bool hasChangeDependencies = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
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
                  padding: EdgeInsets.fromLTRB(Dimens.globalPaddingLeft, Dimens.globalPaddingTop,
                      Dimens.globalPaddingRight, Dimens.globalPaddingBottom),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[widgetServiceName(), widgetDescription(), widgetSubmit()],
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 30,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.fact_check), border: OutlineInputBorder(), labelText: 'Service Name'),
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

  Widget widgetDescription() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 100,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.description), border: OutlineInputBorder(), labelText: 'Service Description'),
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
                  padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                      Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
                  child: ElevatedButton(
                    autofocus: false,
                    style: ElevatedButton.styleFrom(
                      primary: Shade.submitButtonColor,
                      minimumSize: Size(double.infinity, 45),
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    ),
                    child: Text('Submit'),
                    onPressed: () => onPressedSubmit(),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              )
      ],
    );
  }

  Future<void> onPressedSubmit() async {
    if (!formKey.currentState.validate()) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, Strings.errorInputValidation, context);
      return;
    }
    formKey.currentState.save();
    globalProgressDialog.showSimpleFontellicoProgressDialog(
        false, Strings.dialogSubmitting, SimpleFontelicoProgressDialogType.multilines);
    bool hasRefreshToken = await GlobalRefreshToken.hasRefreshedToken(context);
    if (hasRefreshToken) {
      onInsertService();
    } else {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }

  Future<void> onInsertService() async {
    Service service = Service();
    ServiceResponse serviceResponse = await service.insertService(
        ServiceRequest(
          Id: 0,
          Name: name,
          Description: description,
        ),
        context.read<TokenProvider>().tokenSample.jwtToken);
    if (serviceResponse != null) {
      if (serviceResponse.isSuccess) {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, serviceResponse.message, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, serviceResponse.message, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } else {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }
}
