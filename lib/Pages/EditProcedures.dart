import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Responses/ProcedureResponse.dart';
import 'package:baby_doctor/ShareArguments/ProcedureArguments.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Service/ProcedureService.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class EditProcedures extends StatefulWidget {
  @override
  _EditProceduresState createState() => _EditProceduresState();
}

class _EditProceduresState extends State<EditProcedures> {
  final formKey = GlobalKey<FormState>();
  String Id;
  String ProcedureName;
  String PerformedBy;
  int Charges;
  int Share;
  bool isLoading = false;
  SimpleFontelicoProgressDialog sfpd;
  ProcedureService procedureService;
  TextEditingController tecName;
  TextEditingController tecPerformedBy;
  TextEditingController tecCharges;
  TextEditingController tecShare;
  ProcedureArguments arguments;

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
                        if (!isLoading) widgetProcedureName(),
                        if (!isLoading) widgetPerformedBy(),
                        if (!isLoading) widgetCharges(),
                        if (!isLoading) widgetShare(),
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

  void setValuesOfProcedures() {
    setState(() {
      tecName.text = arguments.name;
      tecShare.text = arguments.performerShare.toString();
      tecPerformedBy.text = arguments.performedBy;
      tecCharges.text = arguments.charges.toString();
      isLoading = false;
    });
  }

  void initVariablesAndClasses() {
    tecName = new TextEditingController();
    tecShare = new TextEditingController();
    tecPerformedBy = new TextEditingController();
    tecCharges = new TextEditingController();
    procedureService = ProcedureService();
  }

  Future<void> onPressedSubmitButton()  async {
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
    ProcedureData obj = new ProcedureData(
        id: arguments.id,
        name: ProcedureName,
        performedBy: PerformedBy,
        charges: Charges,
        performerShare: Share);
    var response = await procedureService.UpdateProcedure(obj);
    print(response);
    if (response == true) {
      await sfpd.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalSuccess,
          content: Row(
            children: [
              Text('Success: Procedure Updated '),
              Text(
                ProcedureName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
      formKey.currentState.reset();
      Navigator.pushNamed(context, Strings.routeProcedureList);
    } else {
      await sfpd.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Row(
            children: [
              Text('Error: Try Again: Failed to edit '),
              Text(
                ProcedureName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 30,
            controller: tecName,
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
            controller: tecPerformedBy,
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
            controller: tecCharges,
            keyboardType: TextInputType.number,
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
              Charges = int.parse(value);
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
            controller: tecShare,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(),
                labelText: 'Performer Share'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              // if(value >= 0 || value<=100){
              // return 'This field cannot be empty';
              // }
              return null;
            },
            onSaved: (String value) {
              Share = int.tryParse(value);
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
}
