import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Service/ProcedureService.dart' ;
import 'package:baby_doctor/Models/Procedures.dart';

class EditProcedures extends StatefulWidget {

  @override
  _EditProceduresState createState() => _EditProceduresState();
}

class _EditProceduresState extends State<EditProcedures> {
  @override
  final formKey = GlobalKey<FormState>();
  String Id;
  String ProcedureName;
  String PerformedBy;
  double Charges;
  double Share;
  bool loadingButtonProgressIndicator = false;
  ProcedureService procedureService;
  TextEditingController _namecontroller;
  TextEditingController _performedbycontroller;
  TextEditingController _chargescontroller;
  TextEditingController _sharecontroller;
  dynamic arguments;
  Widget build(BuildContext context) {

    arguments = ModalRoute.of(context).settings.arguments as Map;
    procedureService = ProcedureService();

    if (arguments != null) {
      procedureService.getProceduresById(arguments["Id"]).then((value) {
        _namecontroller = new TextEditingController(text: value["name"]);
        _performedbycontroller =
        new TextEditingController(text: value["performedBy"]);
        _chargescontroller =
        new TextEditingController(text: value["charges"].toString());
        _sharecontroller =
        new TextEditingController(text: value["performerShare"].toString());
      });
    }
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.editProcedure),
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

  @override
  void initState() {
    super.initState();
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
            controller: _namecontroller,
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
            controller: _performedbycontroller,
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
            controller: _chargescontroller,
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
            controller: _sharecontroller,
            keyboardType: TextInputType.number,
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

    Procedures obj = new Procedures(
        id:arguments["Id"],
        name: ProcedureName,
        performedBy: PerformedBy,
        charges: Charges,
        performerShare: Share);
    var response = await procedureService.InsertProcedure(obj);
    print(response);
    if (response == true) {
      setState(() {
        loadingButtonProgressIndicator = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalSuccess,
          content: Row(
            children: [
              Text('Success:procedure Updated'),
              Text(
                ProcedureName,
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
                ProcedureName,
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