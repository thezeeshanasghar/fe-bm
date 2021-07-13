import 'dart:convert';
import 'dart:io';

import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Doctor.dart';
import 'package:baby_doctor/Models/Employee.dart';
import 'package:baby_doctor/Models/Qualifications.dart';
import 'package:baby_doctor/Models/RequestData/EmployeeModel.dart';
import 'package:baby_doctor/Service/DoctorService.dart';
import 'package:baby_doctor/ShareArguments/DoctorArguments.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class EditDoctor extends StatefulWidget {
  @override
  _EditDoctorState createState() => _EditDoctorState();
}

class _EditDoctorState extends State<EditDoctor> {
  final formKey = GlobalKey<FormState>();
  final joinDateController = TextEditingController();
  final DOBController = TextEditingController();
  int id;
  String DOB;
  String FirstName;
  String LastName;
  String FatherHusbandName;
  String CNIC;
  String ContactNumber;
  String EmergencyContactNumber;
  String Email;
  String Address;
  String Gender = "Choose Gender";
  int employeeId;
  String Speciality = "Select Speciality";
  int ConsultationFee;
  int EmergencyConsultationFee;
  String Experience;
  int FeeShare;
  String JoiningDate;
  String Password = "222222";
  String UserName;
  DoctorService doctorService;
  bool isLoading = false;
  TextEditingController _firstnamecontroller;
  TextEditingController _lastnamecontroller;
  TextEditingController _fatherhusbandnamecontroller;
  TextEditingController _contactnumbercontroller;
  TextEditingController _emergencycontactcontroller;
  TextEditingController _addresscontroller;
  TextEditingController _consultationfeecontroller;
  TextEditingController _emailcontroller;
  TextEditingController _cniccontroller;
  TextEditingController _experiencecontroller;
  TextEditingController _emergencyconsultationfeecontroller;
  TextEditingController _feesharecontroller;
  DoctorArguments arguments;
  SimpleFontelicoProgressDialog sfpd;

  List<Qualifications> qualificationList = [
    new Qualifications(
        employeeId: "", certificate: "", description: "", qualificationType: "")
  ];
  List<Qualifications> diplomaList = [
    new Qualifications(
        employeeId: "", certificate: "", description: "", qualificationType: "")
  ];

  PickedFile _imageFile;
  final ImagePicker _imagePicker = ImagePicker();
  Image image;

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

    setValuesOfDoctor();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initVariablesAndClasses() {
    _firstnamecontroller = new TextEditingController();
    _lastnamecontroller = new TextEditingController();
    _addresscontroller = new TextEditingController();
    _cniccontroller = new TextEditingController();
    _emailcontroller = new TextEditingController();
    _experiencecontroller = new TextEditingController();
    _addresscontroller = new TextEditingController();
    _contactnumbercontroller = new TextEditingController();
    _emergencycontactcontroller = new TextEditingController();
    _fatherhusbandnamecontroller = new TextEditingController();
    _emergencyconsultationfeecontroller = new TextEditingController();
    _consultationfeecontroller = new TextEditingController();
    _feesharecontroller = new TextEditingController();
    doctorService = DoctorService();
  }

  void setValuesOfDoctor() {
    setState(() {
       _firstnamecontroller.text = arguments.firstName;
       _lastnamecontroller.text = arguments.lastName;
       _fatherhusbandnamecontroller.text = arguments.fatherHusbandName;
       Gender=arguments.gender;
       _cniccontroller.text = arguments.CNIC;
       _contactnumbercontroller.text = arguments.contact;
       _emergencycontactcontroller.text = arguments.emergencyContact;
        _emailcontroller.text = arguments.email;
       _addresscontroller.text = arguments.address;
       _experiencecontroller.text = arguments.experience;
        joinDateController.text = arguments.joiningDate.toString().substring(0,10);
       _emergencyconsultationfeecontroller.text = arguments.EmergencyConsultationFee.toString();
      _consultationfeecontroller.text = arguments.ConsultationFee.toString();
      _feesharecontroller.text = arguments.ShareInFee.toString();
      Speciality=arguments.SpecialityType;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    doctorService = DoctorService();
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleEditDoctor),
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
                          if (!isLoading) widgetAddress(),
                          if (!isLoading) widgetSpeciality(),
                          if (!isLoading) widgetExperience(),
                          if (!isLoading) widgetConsultationFee(),
                          if (!isLoading) widgetEmergencyConsultationFee(),
                          if (!isLoading) widgetFeeShare(),
                          if (!isLoading) widgetJoiningDate(),
                          if (!isLoading) widgetSizedBox(),
                          if (!isLoading) ...widgetQualification(),
                          if (!isLoading) widgetSizedBox(),
                          if (!isLoading) ...widgetDiplomas(),
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

  Widget widgetUserName() {
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
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.supervised_user_circle),
                  border: OutlineInputBorder(),
                  labelText: 'User Name'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                UserName = value;
              },
            )),
      ],
    );
  }

  Widget widgetPassword() {
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
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_rounded),
                  border: OutlineInputBorder(),
                  labelText: 'Password'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                Password = value;
              },
            )),
      ],
    );
  }

  // widget functions
  Widget widgetDob() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottomWithoutMaxLength),
          child: TextFormField(
            controller: DOBController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Date Of Birth',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              DOB = value;
            },
            onTap: () {
              pickDateDob();
            },
          ),
        ),
      ],
    );
  }

  pickDateDob() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        DOB = date.toString();
        DOBController.text = DOB.toString();
      });
    }
  }

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
                              setState(() {
                                qualificationList[i] = new Qualifications(
                                    certificate: "",
                                    description: value,
                                    qualificationType: "Qualification");
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        _addRemoveButton(i == qualificationList.length - 1, i,
                            qualificationList)
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

  Widget _addRemoveButton(bool add, int index, List<Qualifications> list) {
    return InkWell(
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

  List<Widget> widgetDiplomas() {
    List<Widget> diplomaWidgetList = [];

    for (int i = 0; i < diplomaList.length; i++) {
      diplomaWidgetList.add(Column(
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
                                      : AssetImage('assets/diplomas.png'),
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
                                labelText: 'Diplomas'),
                            validator: (String value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be empty';
                              }
                              return null;
                            },
                            onSaved: (String value) {
                              setState(() {
                                // diplomaList[i]=value;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        _addRemoveButton(
                            i == diplomaList.length - 1, i, diplomaList)
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ));
    }
    return diplomaWidgetList;
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
              controller: _contactnumbercontroller,
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

  Widget widgetSpeciality() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
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
                value: Speciality,
                elevation: 16,
                underline: Container(
                  height: 0,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    Speciality = newValue;
                  });
                },
                items: <String>[
                  'Select Speciality',
                  'Speciality 1',
                  'Speciality 2',
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

  Widget widgetConsultationFee() {
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
              maxLength: 4,
              controller: _consultationfeecontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Consultation Fee'),
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
                ConsultationFee = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetEmergencyConsultationFee() {
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
              maxLength: 4,
              controller: _emergencyconsultationfeecontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Emergency Consultation Fee'),
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
                EmergencyConsultationFee = int.parse(value);
              }),
        ),
      ],
    );
  }

  Widget widgetFeeShare() {
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
              controller: _feesharecontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Fee Share (in percentage %)'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFee = int.tryParse(value);
                if (_cFee == null && !value.isEmpty) {
                  return 'Input Error: fee must be in numeric form\nCorrect Syntax: 20';
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
                FeeShare = int.parse(value);
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
              Dimens.globalInputFieldBottom),
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
                      // takePhotoFromWeb();
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
                      // takePhotoFromWeb();
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

  // functions required for working
  pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2014),
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
    DoctorModel doctorModel = DoctorModel(
        arguments.id,
        arguments.employeeId,
        ConsultationFee,
        EmergencyConsultationFee,
        FeeShare,
        Speciality,
        EmployeeModelDetails(
            arguments.employeeId,
            'Doctor',
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

    bool hasUpdated = await doctorService.UpdateDoctor(doctorModel);
    if (hasUpdated) {
      await sfpd.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalSuccess,
          content: Text('Success: Updated $FirstName')));
      Navigator.pushNamed(context, Strings.routeDoctorList);
    } else {
      await sfpd.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Text('Error: Failed to update $FirstName')));
    }
  }
}
