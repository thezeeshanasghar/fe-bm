import 'dart:convert';
import 'dart:io';

import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/ShareArguments/NurseArguments.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:baby_doctor/Models/Requests/EmployeeModel.dart';
import 'package:baby_doctor/Service/NurseService.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditNurse extends StatefulWidget {
  @override
  _EditNurseState createState() => _EditNurseState();
}

class _EditNurseState extends State<EditNurse> {
  final formKey = GlobalKey<FormState>();
  final joinDateController = TextEditingController();

  int id;
  String FirstName;
  String LastName;
  String FatherHusbandName;
  String Gender = 'Choose Gender';
  String CNIC;
  String ContactNumber;
  String EmergencyContactNumber;
  String Email;
  String Address;
  String Speciality;
  int DutyDuration;
  String UserName;
  int EmergencyConsultationFee;
  int FeeShare;
  String Experience;
  int ProceduresShare;
  int Salary;
  String JoiningDate;
  int employeeId;
  bool isLoading = false;
  NurseService nurseService;
  List<String> qualificationList = [''];
  NurseArguments arguments;
  PickedFile _imageFile;
  final ImagePicker _imagePicker = ImagePicker();
  SimpleFontelicoProgressDialog sfpd;
  TextEditingController _firstnamecontroller;
  TextEditingController _lastnamecontroller;
  TextEditingController _fatherhusbandnamecontroller;
  TextEditingController _contacnumbercontroller;
  TextEditingController _emergencycontactcontroller;
  TextEditingController _addresscontroller;
  TextEditingController _consultationfeecontroller;
  TextEditingController _emailcontroller;
  TextEditingController _cniccontroller;
  TextEditingController _experiencecontroller;
  TextEditingController _dutydurationcontroller;
  TextEditingController _salerycontroller;
  TextEditingController sharePercentageController;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    arguments = ModalRoute.of(context).settings.arguments;
    setValuesOfNurse();
  }

  void initVariablesAndClasses() {
    _firstnamecontroller = new TextEditingController();
    _lastnamecontroller = new TextEditingController();
    _addresscontroller = new TextEditingController();
    _cniccontroller = new TextEditingController();
    _emailcontroller = new TextEditingController();
    _experiencecontroller = new TextEditingController();
    _contacnumbercontroller = new TextEditingController();
    _emergencycontactcontroller = new TextEditingController();
    _fatherhusbandnamecontroller = new TextEditingController();
    _dutydurationcontroller = new TextEditingController();
    sharePercentageController = new TextEditingController();
    _salerycontroller = new TextEditingController();
    nurseService = NurseService();
  }

  void setValuesOfNurse() {
    setState(() {
      id = arguments.id;
      _firstnamecontroller.text = arguments.firstName;
      _lastnamecontroller.text = arguments.lastName;
      _addresscontroller.text = arguments.address;
      _cniccontroller.text = arguments.CNIC;
      _emailcontroller.text = arguments.email;
      _experiencecontroller.text = arguments.experience;
      _contacnumbercontroller.text = arguments.contact;
      _emergencycontactcontroller.text = arguments.emergencyContact;
      _fatherhusbandnamecontroller.text = arguments.fatherHusbandName;
       Gender=arguments.gender;
      _dutydurationcontroller.text = arguments.DutyDuration.toString();
      joinDateController.text = arguments.joiningDate.toString().substring(0,10);
      sharePercentageController.text = arguments.SharePercentage.toString();
      _dutydurationcontroller.text = arguments.DutyDuration.toString();
      _salerycontroller.text = arguments.Salary.toString();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleEditNurse),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          // widgetProfileImage(),
                          // widgetSizedBox(),
                          if (!isLoading) widgetFirstName(),
                          if (!isLoading) widgetLastName(),
                          if (!isLoading) widgetFatherOrHusbandName(),
                          if (!isLoading) widgetGender(),
                          if (!isLoading) widgetCnicNumber(),
                          if (!isLoading) widgetContactNumber(),
                          if (!isLoading) widgetEmergencyContactNumber(),
                          if (!isLoading) widgetEmail(),
                          if (!isLoading) widgetExperience(),
                          if (!isLoading) widgetAddress(),
                          if (!isLoading) widgetDuration(),
                          if (!isLoading) widgetJoiningDate(),
                          if (!isLoading) widgetProcedureShare(),
                          if (!isLoading) widgetSalary(),
                          if (!isLoading) ...widgetQualification(),
                          if (!isLoading) widgetSubmit(),
                          if (isLoading) widgetCircularProgress(),
                        ],
                      ),
                    )),
              ),
            );
          },
        ),
      ),
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

  // functions required for working
  pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        JoiningDate = date.toString();
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            controller: _firstnamecontroller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
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
            padding: const EdgeInsets.fromLTRB(
                Dimens.globalInputFieldleft,
                Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight,
                Dimens.globalInputFieldBottom),
            child: TextFormField(
              autofocus: false,
              maxLength: 15,
              controller: _lastnamecontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 30,
              controller: _fatherhusbandnamecontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottomWithoutMaxLength),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: Gender,
                elevation: 16,
                underline: Container(
                  height: 0,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    Gender = newValue;
                  });
                },
                items: <String>[
                  'Choose Gender',
                  'Male',
                  'Female',
                  'Other',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget widgetCnicNumber() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            controller: _cniccontroller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 11,
              autofocus: false,
              controller: _contacnumbercontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 11,
              controller: _emergencycontactcontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 40,
              controller: _emailcontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 50,
              autofocus: false,
              controller: _addresscontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.home),
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

  Widget widgetExperience() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottomWithoutMaxLength),
          child: TextFormField(
            autofocus: false,
            controller: _experiencecontroller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.date_range_sharp),
                border: OutlineInputBorder(),
                labelText: 'Experience'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              Experience = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetSalary() {
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
              controller: _salerycontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 3,
              controller: sharePercentageController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 2,
              controller: _dutydurationcontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottomWithoutMaxLength),
          child: TextFormField(
            controller: joinDateController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Joining Date',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              JoiningDate = value;
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
      height: 10,
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
              child: Text('Submit'),
              onPressed: () {
                onPressedSubmitButton();
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

  void onPressedSubmitButton() async {
      List<dynamic> degrees = [];
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
      NurseModel nurseData = NurseModel(
          arguments.id,
          arguments.employeeId,
          DutyDuration,
          ProceduresShare,
          Salary,
          EmployeeModelDetails(
              arguments.employeeId,
              'Nurse',
              FirstName,
              LastName,
              FatherHusbandName,
              Gender,
              CNIC,
              ContactNumber,
              EmergencyContactNumber,
              Email,
              Address,
              JoiningDate,
              UserName,
              'Password',
              2,
              Experience, []));
      //
      // bool hasUpdated = await nurseService.UpdateNurse(nurseData);
      // if (hasUpdated) {
      //   await sfpd.hide();
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       backgroundColor: Shade.snackGlobalSuccess,
      //       content: Text('Success: Updated $FirstName')));
      //
      //   Navigator.pushNamed(context, Strings.routeNurseList);
      // } else {
      //   await sfpd.hide();
      //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //       backgroundColor: Shade.snackGlobalFailed,
      //       content: Text('Error: Failed to update $FirstName')));
      // }
  }
}
