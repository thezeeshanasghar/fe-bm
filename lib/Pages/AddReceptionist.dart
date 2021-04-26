import 'dart:io';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddReceptionist extends StatefulWidget {
  @override
  _AddReceptionistState createState() => _AddReceptionistState();
}

class _AddReceptionistState extends State<AddReceptionist> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Add Receptionist';

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: ReceptionistForm(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ReceptionistForm extends StatefulWidget {
  @override
  _ReceptionistFormState createState() => _ReceptionistFormState();
}

class _ReceptionistFormState extends State<ReceptionistForm> {
  final addReceptionistFormKey = GlobalKey<FormState>();
  final ReceptionistController = TextEditingController();
  final joinDateController = TextEditingController();

  String FirstName;
  String LastName;
  String CNIC;
  String ContactNumber;
  String EmergencyContactNumber;
  String Email;
  String Address;
  String Gender;
  int FlourNo;
  DateTime JoiningDate;
  DateTime DOB;

  @override
  void initState() {
    super.initState();
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
                    key: addReceptionistFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        widgetSizedBox(),
                        widgetFirstName(),
                        widgetLastName(),
                        widgetGender(),
                        widgetDob(),
                        widgetCnicNumber(),
                        widgetContactNumber(),
                        widgetEmail(),
                        widgetAddress(),
                        widgetFlourNo(),
                        widgetJoiningDate(),
                        widgetSubmit()
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    ReceptionistController.dispose();
    super.dispose();
  }


  Widget widgetFirstName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration: InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
                labelText: 'First Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              FirstName = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetLastName() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextFormField(
              autofocus: false,
              maxLength: 15,
              decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Last Name'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                LastName = value;
              },
            )),
      ],
    );
  }

  Widget widgetGender() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropDownFormField(
            value: Gender,
            titleText: 'Gender',
            hintText: 'Select your Gender',
            onSaved: (value) {
              setState(() {
                Gender = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                Gender = value;
              });
            },
            dataSource: [
              {
                "display": "Male",
                "value": "Male",
              },
              {
                "display": "Female",
                "value": "Female",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ],
    );
  }

  Widget widgetCnicNumber() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            decoration: InputDecoration(
                icon: Icon(Icons.credit_card),
                border: OutlineInputBorder(),
                labelText: 'CNIC Number'),
            validator: (String value) {
              int _cnic = int.tryParse(value);
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              } else if (_cnic == null) {
                return 'Syntax Error: CNIC mut be in numeric form\nCorrect Syntax: 6110185363984';
              } else if (value.length > 13 || value.length < 13) {
                return 'Syntax Error: A valid CNIC must have 13 digits';
              }
              return null;
            },
            onSaved: (String value) {
              CNIC = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetContactNumber() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              maxLength: 11,
              autofocus: false,
              decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  labelText: 'Contact Number'),
              validator: (String value) {
                int _number = int.tryParse(value);
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                } else if (_number == null) {
                  return 'Syntax Error: Contact Number must be in numeric form\nCorrect Syntax: 03120607088';
                } else if (value.length < 11) {
                  return 'Syntax Error: A valid Contact Number must have 11 digits\nCorrect Syntax: 03120607088';
                } else if (value.substring(0, 1) != "0") {
                  return 'Syntax Error: A valid Contact Number must start with 0\nCorrect Syntax: 03120607088';
                }
                return null;
              },
              onSaved: (String value) {
                ContactNumber = value;
              }),
        ),
      ],
    );
  }

  Widget widgetEmail() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              maxLength: 40,
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Email'),
              validator: (String value) {
                bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                if (!emailValid) {
                  return 'Syntax Error: email is not valid\nCorrect Syntax: babymedics@gmail.com';
                }
                return null;
              },
              onSaved: (String value) {
                Email = value;
              }),
        ),
      ],
    );
  }

  Widget widgetAddress() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              maxLength: 50,
              autofocus: false,
              decoration: InputDecoration(
                  icon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                  labelText: 'Address'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                Address = value;
              }),
        ),
      ],
    );
  }

  Widget widgetJoiningDate() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: joinDateController,
            decoration: InputDecoration(
              icon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Joining Date',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              JoiningDate = DateTime.parse(value);
            },
            onTap: () {
              pickDate();
            },
          ),
        ),
      ],
    );
  }

  Widget widgetDob() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: joinDateController,
            decoration: InputDecoration(
              icon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Date Of Birth',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              DOB = DateTime.parse(value);
            },
            onTap: () {
              pickDate1();
            },
          ),
        ),
      ],
    );
  }
  Widget widgetFlourNo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              maxLength: 50,
              autofocus: false,
              decoration: InputDecoration(
                  icon: Icon(Icons.home),
                  border: OutlineInputBorder(),
                  labelText: 'FlourNo'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                Address = value;
              }),
        ),
      ],
    );
  }


  Widget widgetSizedBox() {
    return SizedBox(
      height: 30,
    );
  }

  Widget widgetSubmit() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Submit'),
              onPressed: () {
                if (!addReceptionistFormKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                      Text('Error: Some input fields are not filled.')));
                  return;
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Successfull')));
                addReceptionistFormKey.currentState.save();
                print(JoiningDate.toString());
              },
            ),
          ),
        ),
      ],
    );
  }

  // functions required for working
  pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        JoiningDate = date;
        joinDateController.text = JoiningDate.toString();
      });
    }
  }

  pickDate1() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        JoiningDate = date;
        joinDateController.text = JoiningDate.toString();
      });
    }
  }


// void takePhotoFromWeb() async {
//   final pickedFile = await FlutterWebImagePicker.getImage;
//   setState(() {
//     image = pickedFile;
//   });
// }
}
