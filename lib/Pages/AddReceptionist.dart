import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/QualificationRequest.dart';
import 'package:baby_doctor/Models/Requests/ReceptionistRequest.dart';
import 'package:baby_doctor/Models/Responses/ReceptionistResponse.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baby_doctor/Service/ReceptionistService.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:provider/provider.dart';

class AddReceptionist extends StatefulWidget {
  @override
  _AddReceptionistState createState() => _AddReceptionistState();
}

class _AddReceptionistState extends State<AddReceptionist> {
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
  String Gender = 'Choose Gender';
  int FloorNo;
  String JoiningDate;
  String DOB;
  bool loadingButtonProgressIndicator = false;
  String FatherHusbandName;
  String Password;
  String UserName;
  String Experience;
  SimpleFontelicoProgressDialog sfpd;
  ReceptionistService receptionistService;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;
  List<QualificationRequest> qualificationList = [
    QualificationRequest(Certificate: '', Description: '', QualificationType: '')
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    ReceptionistController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    receptionistService = ReceptionistService();
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleAddReceptionist),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          widgetFirstName(),
                          widgetLastName(),
                          widgetFatherHusbandName(),
                          widgetGender(),
                          widgetDob(),
                          widgetCnicNumber(),
                          widgetContactNumber(),
                          widgetEmergencyContactNumber(),
                          widgetEmail(),
                          widgetAddress(),
                          widgetFloorNo(),
                          widgetJoiningDate(),
                          widgetSubmit(),
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

  Widget widgetEmergencyContactNumber() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 11,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone), border: OutlineInputBorder(), labelText: 'Emergency Contact Number'),
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

  Widget widgetFirstName() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 15,
            decoration:
                InputDecoration(prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'First Name'),
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
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
            child: TextFormField(
              autofocus: false,
              maxLength: 15,
              decoration:
                  InputDecoration(prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Last Name'),
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
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
            child: TextFormField(
              autofocus: false,
              maxLength: 15,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), border: OutlineInputBorder(), labelText: 'Father/Husband Name'),
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
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
            child: TextFormField(
              autofocus: false,
              maxLength: 15,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.supervised_user_circle), border: OutlineInputBorder(), labelText: 'User Name'),
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
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
            child: TextFormField(
              autofocus: false,
              maxLength: 15,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_rounded), border: OutlineInputBorder(), labelText: 'Password'),
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  Dimens.globalDbffLeft, Dimens.globalDbffTop, Dimens.globalDbffRight, Dimens.globalDbffBottom),
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: Gender,
                elevation: 16,
                decoration: InputDecoration.collapsed(hintText: ''),
                validator: (String value) {
                  if (value == 'Choose Gender') {
                    return 'This field cannot be empty';
                  }
                  return null;
                },
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
            maxLength: 13,
            autofocus: false,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card), border: OutlineInputBorder(), labelText: 'CNIC Number'),
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 11,
              autofocus: false,
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 40,
              decoration:
                  InputDecoration(prefixIcon: Icon(Icons.email), border: OutlineInputBorder(), labelText: 'Email'),
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              maxLength: 50,
              autofocus: false,
              decoration:
                  InputDecoration(prefixIcon: Icon(Icons.home), border: OutlineInputBorder(), labelText: 'Address'),
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
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
              return null;
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
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
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
              return null;
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

  Widget widgetFloorNo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
          child: TextFormField(
              autofocus: false,
              maxLength: 3,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.monetization_on), border: OutlineInputBorder(), labelText: 'Flour No'),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'This field cannot be empty';
                }
                int _cFloorNo = int.tryParse(value);
                if (_cFloorNo == null && !value.isEmpty) {
                  return 'Input Error: FloorNo must be in numeric form\nCorrect Syntax: 20';
                }
                if (_cFloorNo <= 0) {
                  return 'Input Error: cannot enter negative digits\nCorrect Syntax: 20';
                }
                return null;
              },
              onSaved: (String value) {
                FloorNo = int.parse(value);
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

  Future<void> onPressedSubmitButton() async {
    if (!formKey.currentState.validate()) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorInputValidation, context);
      return;
    }
    formKey.currentState.save();
    try {
      globalProgressDialog.showSimpleFontellicoProgressDialog(
          false, Strings.dialogSubmitting, SimpleFontelicoProgressDialogType.multilines);
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        onCallingInsertReceptionist();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }

  Future<void> onCallingInsertReceptionist() async {
    try {
      ReceptionistService receptionistService = ReceptionistService();
      ReceptionistResponse receptionistResponse = await receptionistService.insertReceptionist(
          ReceptionistRequest(
            firstName: FirstName,
            lastName: LastName,
            fatherHusbandName: FatherHusbandName,
            gender: Gender,
            dateOfBirth: DOB,
            cnic: CNIC,
            contact: ContactNumber,
            emergencyContact: EmergencyContactNumber,
            email: Email,
            address: Address,
            floorNo: FloorNo,
            joiningDate: JoiningDate,
            qualificationList: qualificationList,
          ),
          context.read<TokenProvider>().tokenSample.jwtToken);
      if (receptionistResponse != null) {
        if (receptionistResponse.isSuccess) {
          resetValues();
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, receptionistResponse.message, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, receptionistResponse.message, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }

  void resetValues() {
    formKey.currentState.reset();
    setState(() {
      Gender = 'Choose Gender';
      joinDateController.text = '';
      DOBController.text = '';
    });
  }
}
