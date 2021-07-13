import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/ShareArguments/ReceptionistArguments.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Service/ReceptionistService.dart';
import 'package:baby_doctor/Models/Employee.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class EditReceptionist extends StatefulWidget {
  @override
  _EditReceptionistState createState() => _EditReceptionistState();
}

class _EditReceptionistState extends State<EditReceptionist> {
  @override
  final formKey = GlobalKey<FormState>();
  final ReceptionistController = TextEditingController();
  final joinDateController = TextEditingController();
  final DOBController = TextEditingController();
  String FirstName;
  String LastName;
  String CNIC;
  String ContactNumber;
  String EmergencyContactNumber;
  String Email;
  String Address;
  String Gender;
  int FlourNo;
  String JoiningDate;
  String DOB;
  String FatherHusbandName;
  String Password;
  String UserName;
  String Experience;
  bool isLoading = false;
  ReceptionistService receptionistService;
  SimpleFontelicoProgressDialog sfpd;
  TextEditingController _firstnamecontroller;
  TextEditingController _lastnamecontroller;
  TextEditingController _usennamecontroller;
  TextEditingController _cniccontroller;
  TextEditingController _gendercontroller;
  TextEditingController _flournocontroller;
  TextEditingController _emailcontroller;
  TextEditingController _passwwordcontroller;
  TextEditingController _addresscontroller;
  TextEditingController _contactnumbercontroller;
  TextEditingController _emergencycontactnumbercontroller;
  TextEditingController _fatherhusbandnamecontroller;
  TextEditingController _dobcontroller;

  ReceptionistArguments arguments;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void initVariablesAndClasses() {
    _firstnamecontroller = new TextEditingController();
    _lastnamecontroller = new TextEditingController();
    _usennamecontroller = new TextEditingController();
    _cniccontroller = new TextEditingController();
    _flournocontroller = new TextEditingController();
    _emailcontroller = new TextEditingController();
    _passwwordcontroller = new TextEditingController();
    _addresscontroller = new TextEditingController();
    _contactnumbercontroller = new TextEditingController();
    _emergencycontactnumbercontroller = new TextEditingController();
    _fatherhusbandnamecontroller = new TextEditingController();
    _dobcontroller = new TextEditingController();
    receptionistService = ReceptionistService();
  }

  void setValuesOfReceptionist() {
    setState(() {
      _firstnamecontroller.text = arguments.firstName;
      _lastnamecontroller.text = arguments.lastName;
      _fatherhusbandnamecontroller.text = arguments.fatherHusbandName;
      _usennamecontroller.text = arguments.userName;
      joinDateController.text = arguments.joiningDate.toString().substring(0,10);
      _cniccontroller.text = arguments.CNIC;

      Gender = arguments.gender;

      _flournocontroller.text = arguments.flourNo.toString();
      _emailcontroller.text = arguments.email;
      _passwwordcontroller.text = arguments.password;
      _addresscontroller.text = arguments.address;
      _contactnumbercontroller.text = arguments.contact;
      _emergencycontactnumbercontroller.text = arguments.emergencyContact;

      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleEditReceptionist),
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
                        if (!isLoading) widgetFirstName(),
                        if (!isLoading) widgetLastName(),
                        if (!isLoading) widgetFatherHusbandName(),
                        if (!isLoading) widgetUserName(),
                        if (!isLoading) widgetPassword(),
                        if (!isLoading) widgetGender(),
                        if (!isLoading) widgetDob(),
                        if (!isLoading) widgetCnicNumber(),
                        if (!isLoading) widgetContactNumber(),
                        if (!isLoading) widgetEmail(),
                        if (!isLoading) widgetAddress(),
                        if (!isLoading) widgetFlourNo(),
                        if (!isLoading) widgetJoiningDate(),
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

  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    arguments = ModalRoute.of(context).settings.arguments;
    setValuesOfReceptionist();


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

  Widget widgetFatherHusbandName() {
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
              controller: _fatherhusbandnamecontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  labelText: 'Father/Husband Name'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                FatherHusbandName = value;
              },
            )),
      ],
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
              controller: _usennamecontroller,
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
              controller: _passwwordcontroller,
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
              pickDate1();
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
              pickDate();
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
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 3,
              controller: _flournocontroller,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on),
                  border: OutlineInputBorder(),
                  labelText: 'Flour No'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFlourNo = int.tryParse(value);
                if (_cFlourNo == null && !value.isEmpty) {
                  return 'Input Error: FlourNo must be in numeric form\nCorrect Syntax: 20';
                }
                if (_cFlourNo <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 20';
                }
                return null;
              },
              onSaved: (String value) {
                FlourNo = int.parse(value);
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
      ],
    );
  }

  // functions required for working
  pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        DOB = date.toString();
        DOBController.text = DOB.toString();
      });
    }
  }

  pickDate1() async {
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

  onPressedSubmitButton() async {
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

    EmployeeData obj = new EmployeeData(
        employeeType: 'Receptionist',
        id: arguments.id,
        firstName: FirstName,
        lastName: LastName,
        fatherHusbandName: FatherHusbandName,
        gender: Gender,
        CNIC: CNIC,
        contact: ContactNumber,
        emergencyContact: EmergencyContactNumber,
        experience: Experience,
        flourNo: FlourNo,
        password: Password,
        userName: UserName,
        joiningDate: JoiningDate,
        // DOB: DOB,
        address: Address,
        email: Email);
    var response = await receptionistService.UpdateReceptionist(obj);
    print(response);
    if (response == true) {

      await sfpd.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalSuccess,
          content: Row(
            children: [
              Text('Success: Updated Receptionist '),
              Text(
                FirstName + ' ' + LastName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
      formKey.currentState.reset();
      Navigator.pushNamed(context, Strings.routeReceptionistList);
    } else {
      await sfpd.hide();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Row(
            children: [
              Text('Error: Try Again: Failed to add '),
              Text(
                FirstName + ' ' + LastName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
    }
  }

}
