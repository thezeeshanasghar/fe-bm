import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NurseMedication extends StatefulWidget {
  @override
  _NurseMedicationState createState() => _NurseMedicationState();
}

class _NurseMedicationState extends State<NurseMedication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Patient Name"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: MedicationForm(),
    );
  }
}

class MedicationForm extends StatefulWidget {
  @override
  _MedicationFormState createState() => _MedicationFormState();
}

class _MedicationFormState extends State<MedicationForm> {
  final formKey = GlobalKey<FormState>();

  String Status;
  List<String> medicationList = ['Bed charges'];

  @override
  void initState() {
    super.initState();
    Status = "Status";
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _addRemoveButton(bool add, int index, List<String> list) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
      child: InkWell(
        onTap: () {
          if (add) {
            list.insert(0, null);
          } else {
            list.removeAt(index);
          }
          setState(() {});
        },
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: (add) ? Colors.grey[400] : Colors.red[400],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            (add) ? Icons.add : Icons.remove,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  List<Widget> widgetMedicationList() {
    List<Widget> medicationWidgetList = [];

    for (int i = 0; i < medicationList.length; i++) {
      medicationWidgetList.add(Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text(
                        medicationList[i].toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _addRemoveButton(
                      i == medicationList.length - 1, i, medicationList)
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: Status,
                            hint: Text("Status"),
                            // icon: const Icon(Icons.arrow_circle_down_sharp),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.grey),
                            underline: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                Status = newValue;
                              });
                            },
                            items: <String>['Given', 'Pending', 'Status']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      child: TextFormField(
                        autofocus: false,
                        decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Medication Name'),
                        validator: (String value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be empty';
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          // FirstName = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      child: const Text('Save'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/BedTime');
                        // Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }
    return medicationWidgetList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.minHeight,
              ),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ...widgetMedicationList(),
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
