import 'dart:io';

import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddNurse extends StatefulWidget {
  @override
  _AddNurseState createState() => _AddNurseState();
}

class _AddNurseState extends State<AddNurse> {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Add Nurse';
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: NurseForm(),
    );
  }
}

class NurseForm extends StatefulWidget {
  @override
  _NurseFormState createState() => _NurseFormState();
}

class _NurseFormState extends State<NurseForm> {
  final nurseFormKey = GlobalKey<FormState>();
  final joinDateController = TextEditingController();

  String FirstName;
  String LastName;
  String FatherHusbandName;
  String Gender;
  String CNIC;
  String ContactNumber;
  String EmergencyContactNumber;
  String Email;
  String Address;
  String Speciality;
  int DutyDuration;
  int EmergencyConsultationFee;
  int FeeShare;
  int ProceduresShare;
  int Salary;
  DateTime JoiningDate;
  List<String> qualificationList = [''];

  PickedFile _imageFile;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    Gender = "Male";
  }

  @override
  void dispose() {
    super.dispose();
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
                    key: nurseFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        // widgetProfileImage(),
                        // widgetSizedBox(),
                        widgetFirstName(),
                        widgetLastName(),
                        widgetFatherOrHusbandName(),
                        widgetGender(),
                        widgetCnicNumber(),
                        widgetContactNumber(),
                        widgetEmergencyContactNumber(),
                        // widgetEmail(),
                        widgetAddress(),
                        widgetDuration(),
                        // widgetSpeciality(),
                        // widgetConsultationFee(),
                        // widgetEmergencyConsultationFee(),
                        widgetJoiningDate(),
                        widgetProcedureShare(),
                        widgetSalary(),
                        ...widgetQualification(),
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

  void takePhotoFromPhone(ImageSource source) async {
    final pickedFile = await _imagePicker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  // widget functions
  List<Widget> widgetQualification() {
    List<Widget> qualificationWidgetList = [];

    for (int i = 0; i < qualificationList.length; i++) {
      qualificationWidgetList.add(Column(
        children: [
          Card(
            color: Colors.grey[100],
            shadowColor: Colors.grey,
            child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: [
                            Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: _imageFile != null
                                      ? FileImage(File(_imageFile.path))
                                      : AssetImage('assets/certificate.png'),
                                ),
                                Positioned(
                                    bottom: 10.0,
                                    right: 10.0,
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) =>
                                                bottomSheet()));
                                      },
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.teal,
                                        size: 22,
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            autofocus: false,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Qualification'),
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
                        SizedBox(
                          width: 10,
                        ),
                        _addRemoveButton(i == qualificationList.length - 1, i)
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ));
    }
    return qualificationWidgetList;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          qualificationList.insert(0, null);
        } else {
          qualificationList.removeAt(index);
        }
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget widgetProfileImage() {
    return Column(
      children: [
        Center(
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                radius: 90,
                backgroundImage: _imageFile != null
                    ? FileImage(File(_imageFile.path))
                    : AssetImage('assets/doctordp.jpg'),
              ),
              Positioned(
                  bottom: 30.0,
                  right: 30.0,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: ((builder) => bottomSheet()));
                    },
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.teal,
                      size: 28,
                    ),
                  ))
            ],
          ),
        ),
      ],
    );
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

  Widget widgetFatherOrHusbandName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              maxLength: 30,
              decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Father Name OR Husband Name'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                FatherHusbandName = value;
              }),
        ),
      ],
    );
  }

  Widget widgetGender() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(48, 10, 8, 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [Text("Select Gender:")],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(
                        value: "Male",
                        groupValue: Gender,
                        onChanged: (value) {
                          setState(() {
                            print(value);
                            Gender = value;
                          });
                        }),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Male"),
                    SizedBox(
                      width: 10,
                    ),
                    Radio(
                        value: "Female",
                        groupValue: Gender,
                        onChanged: (value) {
                          setState(() {
                            print(value);
                            Gender = value;
                          });
                        }),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Female"),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            )),
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

  Widget widgetEmergencyContactNumber() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              maxLength: 11,
              decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  labelText: 'Emergency Contact Number'),
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
                EmergencyContactNumber = value;
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

  Widget widgetSpeciality() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: DropDownFormField(
            value: Speciality,
            titleText: 'Speciality',
            hintText: 'Please choose one',
            onSaved: (value) {
              setState(() {
                Speciality = value;
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
                Speciality = value;
              });
            },
            dataSource: [
              {
                "display": "Speciality 1",
                "value": "Speciality 1",
              },
              {
                "display": "Speciality 2",
                "value": "Speciality 2",
              },
              {
                "display": "Speciality 3",
                "value": "Speciality 3",
              },
            ],
            textField: 'display',
            valueField: 'value',
          ),
        ),
      ],
    );
  }

  Widget widgetSalary() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              maxLength: 5,
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Salary'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFee = int.tryParse(value);
                if (_cFee == null && !value.isEmpty) {
                  return 'Input Error: fee must be in numeric form\nCorrect Syntax: 2000';
                }
                if (_cFee <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 2000';
                }
                return null;
              },
              onSaved: (String value) {
                Salary = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetProcedureShare() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              maxLength: 3,
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Procedures Share (in percentage %)'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFee = int.tryParse(value);
                if (_cFee == null && !value.isEmpty) {
                  return 'Input Error: Procedures Share must be in numeric form\nCorrect Syntax: 20';
                }
                if (_cFee <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 20';
                }
                if (_cFee > 100) {
                  return 'Input Error: percentage cannot be greater than 100\nCorrect Syntax: 20';
                }
                return null;
              },
              onSaved: (String value) {
                ProceduresShare = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetDuration() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
              autofocus: false,
              maxLength: 2,
              decoration: InputDecoration(
                  icon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Duty Duration (in hrs)'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFee = int.tryParse(value);
                if (_cFee == null && !value.isEmpty) {
                  return 'Input Error: Duty Duration must be in numeric form\nCorrect Syntax: 8';
                }
                if (_cFee <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 20';
                }
                if (_cFee > 24) {
                  return 'Input Error: Duty Duration cannot be greater than 24\nCorrect Syntax: 8';
                }
                return null;
              },
              onSaved: (String value) {
                DutyDuration = int.parse(value);
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
                if (!nurseFormKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                          Text('Error: Some input fields are not filled.')));
                  return;
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Successfull')));
                nurseFormKey.currentState.save();
                print(JoiningDate.toString());
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    if (kIsWeb) {
                      takePhotoFromPhone(ImageSource.gallery);
                    } else {
                      takePhotoFromPhone(ImageSource.camera);
                    }
                  },
                  icon: Icon(Icons.camera),
                  label: Text("Camera")),
              SizedBox(
                width: 30,
              ),
              TextButton.icon(
                  onPressed: () {
                    if (kIsWeb) {
                      takePhotoFromPhone(ImageSource.gallery);
                    } else {
                      takePhotoFromPhone(ImageSource.gallery);
                    }
                  },
                  icon: Icon(Icons.image),
                  label: Text("Gallery"))
            ],
          )
        ],
      ),
    );
  }
}
