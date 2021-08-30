import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/ProcedureRequest.dart';
import 'package:baby_doctor/Models/Responses/ProcedureResponse.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/ShareArguments/ProcedureArguments.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Service/ProcedureService.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class EditProcedures extends StatefulWidget {
  @override
  _EditProceduresState createState() => _EditProceduresState();
}

class _EditProceduresState extends State<EditProcedures> {
  final formKey = GlobalKey<FormState>();
  String id;
  String procedureName;
  String executant;
  int charges;
  int share;
  ProcedureService procedureService;
  TextEditingController tecName;
  TextEditingController tecPerformedBy;
  TextEditingController tecCharges;
  TextEditingController tecShare;
  ProcedureRequest arguments;
  bool isLoading = true;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      arguments = ModalRoute.of(context).settings.arguments;
      globalProgressDialog = GlobalProgressDialog(context);
      setValuesOfProcedures();
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleEditProcedure),
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        !isLoading
                            ? Column(children: [
                                widgetProcedureName(),
                                widgetPerformedBy(),
                                widgetCharges(),
                                widgetShare(),
                                widgetSubmit(),
                              ])
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

  void setValuesOfProcedures() {
    setState(() {
      tecName.text = arguments.name;
      tecShare.text = arguments.executantShare.toString();
      tecPerformedBy.text = arguments.executant;
      tecCharges.text = arguments.charges.toString();
      isLoading = false;
    });
  }

  void initVariablesAndClasses() {
    tecName = TextEditingController();
    tecShare = TextEditingController();
    tecPerformedBy = TextEditingController();
    tecCharges = TextEditingController();
    procedureService = ProcedureService();
  }

  Future<void> onPressedSubmitButton() async {
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
        ProcedureResponse procedureResponse = await procedureService.updateProcedure(
            ProcedureRequest(
              id: arguments.id,
              charges: charges,
              executant: executant,
              executantShare: share,
              name: procedureName,
            ),
            context.read<TokenProvider>().tokenSample.jwtToken);
        if (procedureResponse != null) {
          if (procedureResponse.isSuccess) {
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, procedureResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
            Navigator.pop(context);
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, procedureResponse.message, context);
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

  Widget widgetProcedureName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 30,
            controller: tecName,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.fact_check), border: OutlineInputBorder(), labelText: 'Procedure Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              procedureName = value;
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            controller: tecPerformedBy,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Performed By'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              executant = value;
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 5,
            controller: tecCharges,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.monetization_on), border: OutlineInputBorder(), labelText: 'charges'),
            validator: (String value) {
              if (value.isEmpty) {
                return 'This field cannot be empty';
              }
              int intValue = int.tryParse(value);
              if (intValue == null) {
                return 'Input Error: fee must be in numeric form\nCorrect Syntax: 20';
              }
              if (intValue <= 0) {
                return 'Input Error: cannot enter negative digits\nCorrect Syntax: 20';
              }
              if (intValue > 100) {
                return 'Input Error: percentage cannot be greater than 100\nCorrect Syntax: 20';
              }
              return null;
            },
            onSaved: (String value) {
              charges = int.parse(value);
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 3,
            controller: tecShare,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.monetization_on), border: OutlineInputBorder(), labelText: 'Performer share'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              if (int.parse(value) >= 0 || int.parse(value) <= 100) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              share = int.tryParse(value);
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
              onPressed: () => onPressedSubmitButton(),
            ),
          ),
        )
      ],
    );
  }
}
