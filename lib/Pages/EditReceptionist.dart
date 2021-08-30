import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/ReceptionistRequest.dart';
import 'package:baby_doctor/Models/Responses/ReceptionistResponse.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/ShareArguments/ReceptionistArguments.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Service/ReceptionistService.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class EditReceptionist extends StatefulWidget {
  @override
  _EditReceptionistState createState() => _EditReceptionistState();
}

class _EditReceptionistState extends State<EditReceptionist> {
  final formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String cnic;
  String contactNumber;
  String emergencyContactNumber;
  String email;
  String address;
  String gender;
  int floor;
  String joiningDate;
  String dob;
  String fatherHusbandName;
  String experience;
  bool isLoading = false;
  ReceptionistService receptionistService;
  TextEditingController tecFirstName;
  TextEditingController tecLastName;
  TextEditingController tecCnic;
  TextEditingController tecGender;
  TextEditingController tecFloor;
  TextEditingController tecEmail;
  TextEditingController tecAddress;
  TextEditingController tecContact;
  TextEditingController tecEmergencyContact;
  TextEditingController tecFatherHusbandName;
  TextEditingController tecDob;
  TextEditingController tecJoiningDate;
  ReceptionistRequest arguments;
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
      setValuesOfReceptionist();
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
                  padding: EdgeInsets.fromLTRB(Dimens.globalPaddingLeft, Dimens.globalPaddingTop,
                      Dimens.globalPaddingRight, Dimens.globalPaddingBottom),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        !isLoading
                            ? Column(
                                children: [
                                  widgetFirstName(),
                                  widgetLastName(),
                                  widgetFatherHusbandName(),
                                  widgetGender(),
                                  widgetDob(),
                                  widgetCnicNumber(),
                                  widgetContactNumber(),
                                  widgetEmail(),
                                  widgetAddress(),
                                  widgetFloor(),
                                  widgetJoiningDate(),
                                  widgetSubmit(),
                                ],
                              )
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

  void initVariablesAndClasses() {
    tecFirstName = TextEditingController();
    tecLastName = TextEditingController();
    tecCnic = TextEditingController();
    tecFloor = TextEditingController();
    tecEmail = TextEditingController();
    tecAddress = TextEditingController();
    tecContact = TextEditingController();
    tecEmergencyContact = TextEditingController();
    tecJoiningDate = TextEditingController();
    tecFatherHusbandName = TextEditingController();
    tecDob = TextEditingController();
    receptionistService = ReceptionistService();
  }

  void setValuesOfReceptionist() {
    setState(() {
      tecFirstName.text = arguments.firstName;
      tecLastName.text = arguments.lastName;
      tecFatherHusbandName.text = arguments.fatherHusbandName;
      tecJoiningDate.text = arguments.joiningDate.toString().substring(0, 10);
      tecCnic.text = arguments.cnic;
      gender = arguments.gender;
      tecFloor.text = arguments.floorNo.toString();
      tecEmail.text = arguments.email;
      tecAddress.text = arguments.address;
      tecContact.text = arguments.contact;
      tecEmergencyContact.text = arguments.emergencyContact;
      tecDob.text = arguments.dateOfBirth;
      isLoading = false;
    });
  }

  Widget widgetFirstName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            controller: tecFirstName,
            decoration:
                InputDecoration(prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'First Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              firstName = value;
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
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
            child: TextFormField(
              autofocus: false,
              maxLength: 15,
              controller: tecLastName,
              decoration:
                  InputDecoration(prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Last Name'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                lastName = value;
              },
            )),
      ],
    );
  }

  Widget widgetFatherHusbandName() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
            child: TextFormField(
              autofocus: false,
              maxLength: 15,
              controller: tecFatherHusbandName,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Father/Husband Name'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                fatherHusbandName = value;
              },
            )),
      ],
    );
  }

  Widget widgetGender() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: gender,
                elevation: 16,
                underline: Container(
                  height: 0,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    gender = newValue;
                  });
                },
                items: <String>[
                  'Choose gender',
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            controller: tecCnic,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card), border: OutlineInputBorder(), labelText: 'cnic Number'),
            validator: (String value) {
              int _cnic = int.tryParse(value);
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              } else if (_cnic == null) {
                return 'Syntax Error: cnic mut be in numeric form\nCorrect Syntax: 6110185363984';
              } else if (value.length > 13 || value.length < 13) {
                return 'Syntax Error: A valid cnic must have 13 digits';
              }
              return null;
            },
            onSaved: (String value) {
              cnic = value;
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 11,
              autofocus: false,
              controller: tecContact,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone), border: OutlineInputBorder(), labelText: 'Contact Number'),
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
                contactNumber = value;
              }),
        ),
      ],
    );
  }

  Widget widgetEmail() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 40,
              controller: tecEmail,
              decoration:
                  InputDecoration(prefixIcon: Icon(Icons.email), border: OutlineInputBorder(), labelText: 'email'),
              validator: (String value) {
                bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                if (!emailValid) {
                  return 'Syntax Error: email is not valid\nCorrect Syntax: babymedics@gmail.com';
                }
                return null;
              },
              onSaved: (String value) {
                email = value;
              }),
        ),
      ],
    );
  }

  Widget widgetAddress() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 50,
              autofocus: false,
              controller: tecAddress,
              decoration:
                  InputDecoration(prefixIcon: Icon(Icons.home), border: OutlineInputBorder(), labelText: 'address'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                address = value;
              }),
        ),
      ],
    );
  }

  Widget widgetJoiningDate() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
          child: TextFormField(
            controller: tecJoiningDate,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Joining Date',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              joiningDate = value;
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
          child: TextFormField(
            controller: tecDob,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Date Of Birth',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              dob = value;
            },
            onTap: () {
              pickDate();
            },
          ),
        ),
      ],
    );
  }

  Widget widgetFloor() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 3,
              controller: tecFloor,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on), border: OutlineInputBorder(), labelText: 'Flour No'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFlourNo = int.tryParse(value);
                if (_cFlourNo == null) {
                  return 'Input Error: floor must be in numeric form\nCorrect Syntax: 20';
                }
                if (_cFlourNo <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 20';
                }
                return null;
              },
              onSaved: (String value) {
                floor = int.parse(value);
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
              onPressed: () {
                onPressedSubmitButton();
              },
            ),
          ),
        )
      ],
    );
  }

  Future<void> pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        dob = date.toString();
        tecDob.text = dob.toString();
      });
    }
  }

  Future<void> pickDate1() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2014),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        joiningDate = date.toString();
        tecJoiningDate.text = joiningDate.toString();
      });
    }
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
        ReceptionistResponse receptionistResponse = await receptionistService.updateReceptionist(
            ReceptionistRequest(
              id: arguments.id,
              firstName: firstName,
              lastName: lastName,
              fatherHusbandName: fatherHusbandName,
              gender: gender,
              dateOfBirth: dob,
              cnic: cnic,
              contact: contactNumber,
              emergencyContact: emergencyContactNumber,
              email: email,
              address: address,
              floorNo: floor,
              joiningDate: joiningDate,
            ),
            context.read<TokenProvider>().tokenSample.jwtToken);
        if (receptionistResponse != null) {
          if (receptionistResponse.isSuccess) {
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, receptionistResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
            Navigator.pop(context);
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, receptionistResponse.message, context);
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
}
