import 'dart:async';

import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/NurseRequest.dart';
import 'package:baby_doctor/Models/Requests/QualificationRequest.dart';
import 'package:baby_doctor/Models/Responses/NurseResponse.dart';
import 'package:baby_doctor/Models/Sample/NurseSample.dart';
import 'package:baby_doctor/Models/Sample/QualificationSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/NurseService.dart';
import 'package:baby_doctor/ShareArguments/NurseArguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class NurseList extends StatefulWidget {
  @override
  _NurseListState createState() => _NurseListState();
}

class _NurseListState extends State<NurseList> {
  final formKey = GlobalKey<FormState>();

  int nurseTotal;
  int nurseCurrentPerPage;
  int nurseCurrentPage;
  bool nurseIsSearch;
  String nurseSelectableKey;
  String nurseSortColumn;
  bool nurseSortAscending;
  bool nurseIsLoading;
  bool nurseShowSelect;
  bool showSearchedList;
  SimpleFontelicoProgressDialog sfpd;
  List<DatatableHeader> nurseHeaders;
  List<int> nursePerPage;
  List<Map<String, dynamic>> nurseIsSource;
  List<Map<String, dynamic>> nurseIsSearched;
  List<Map<String, dynamic>> nurseSelecteds;
  List<NurseSample> listNurse;
  NurseService nurseService;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initializeNurseListHeaders();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      checkTokenValidityAndGetNurse();
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
          title: Text(Strings.titleNurseList),
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
                          children: <Widget>[widgetnursePatients()],
                        ),
                      )),
                ),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, Strings.routeAddNurse);
          },
          child: const Icon(Icons.add),
          backgroundColor: Shade.fabGlobalButtonColor,
        ));
  }

  FutureOr onGoBack(dynamic value) {
    checkTokenValidityAndGetNurse();
  }

  void initVariablesAndClasses() {
    nurseHeaders = [];
    nursePerPage = [5, 10, 15, 100];
    nurseTotal = 100;
    nurseCurrentPage = 1;
    nurseIsSearch = false;
    nurseIsSource = [];
    nurseIsSearched = [];
    nurseSelecteds = [];
    nurseSelectableKey = "Invoice";
    nurseSortAscending = true;
    nurseIsLoading = true;
    nurseShowSelect = false;
    listNurse = [];
    showSearchedList = false;
    nurseService = NurseService();
  }

  Future<void> checkTokenValidityAndGetNurse() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        getDoctorsFromApiAndLinkToTable();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  Future<void> getDoctorsFromApiAndLinkToTable() async {
    setState(() => nurseIsLoading = true);
    listNurse = [];
    nurseIsSource = [];
    try {
      NurseResponseList nurseList = await nurseService.getNurses(context.read<TokenProvider>().tokenSample.jwtToken);
      if (nurseList != null) {
        if (nurseList.isSuccess) {
          listNurse = nurseList.data;
          nurseIsSource.addAll(generateDoctorDataFromApi(listNurse));
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, nurseList.message, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
      }
      setState(() => nurseIsLoading = false);
    } catch (exception) {
      setState(() => nurseIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generateDoctorDataFromApi(List<NurseSample> listOfNurse) {
    List<Map<String, dynamic>> tempNurse = [];
    for (NurseSample nurse in listOfNurse) {
      tempNurse.add({
        "id": nurse.id,
        "userId": nurse.userId,
        "dutyDuration": nurse.dutyDuration,
        "sharePercentage": nurse.sharePercentage,
        "salary": nurse.salary,
        "userType": nurse.user.userType,
        "dateOfBirth": nurse.user.dateOfBirth,
        "maritalStatus": nurse.user.maritalStatus,
        "religion": nurse.user.religion,
        "firstName": nurse.user.firstName,
        "lastName": nurse.user.lastName,
        "fatherHusbandName": nurse.user.fatherHusbandName,
        "gender": nurse.user.gender,
        "cnic": nurse.user.cnic,
        "contact": nurse.user.contact,
        "emergencyContact": nurse.user.emergencyContact,
        "email": nurse.user.email,
        "address": nurse.user.address,
        "joiningDate": nurse.user.joiningDate,
        "floorNo": nurse.user.floorNo,
        "experience": nurse.user.experience,
        "qualifications": nurse.user.qualifications,
        "Action": nurse.id,
      });
    }
    return tempNurse;
  }

  List<Map<String, dynamic>> generateNurseSearchData(Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsnurse = [];
    for (var iterable in iterableList) {
      tempsnurse.add({
        "id": iterable["id"],
        "firstName": iterable["firstName"],
        "lastName": iterable["lastName"],
        "email": iterable["email"],
        "Action": iterable["Action"],
      });
    }
    return tempsnurse;
  }

  initializeNurseListHeaders() {
    nurseHeaders = [
      DatatableHeader(
          value: "id",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "userId",
          show: false,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "User Id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "firstName",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "First Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "dutyDuration",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Duty Duration",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "sharePercentage",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Share Percentage",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "salary",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Salary",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "userType",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "User Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "dateOfBirth",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Birth Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "maritalStatus",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Marital Status",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "religion",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Religion",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "lastName",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Last Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "fatherHusbandName",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "fatherHusbandName",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "gender",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Gender",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "cnic",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "cnic",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "contact",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "contact",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "emergencyContact",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "emergencyContact",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "email",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "email",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "address",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "joiningDate",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "joiningDate",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "floorNo",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "floorNo",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "experience",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "experience",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Action",
          show: true,
          flex: 1,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Action",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          sourceBuilder: (id, row) {
            return Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => onPressedEditFromTable(id, row),
                  child: Text('Edit',
                      style: TextStyle(
                        color: Shade.actionButtonTextEdit,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () => onPressedDeleteFromTable(id, row),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Shade.actionButtonTextDelete,
                      ),
                    )),
              ],
            ));
          }),
    ];
  }

  void onPressedEditFromTable(id, row) {
    List<QualificationRequest> qualificationRequestList = [];
    List<QualificationSample> qualificationSampleList = row['qualifications'];
    if (qualificationSampleList != null) {
      if (qualificationSampleList.length > 0) {
        for (QualificationSample qualificationSample in qualificationSampleList) {
          qualificationRequestList.add(QualificationRequest(
            Id: qualificationSample.id,
            UserId: qualificationSample.userId,
            Certificate: qualificationSample.certificate,
            Description: qualificationSample.description,
            QualificationType: qualificationSample.qualificationType,
          ));
        }
      }
    }

    NurseRequest nurseRequest = NurseRequest(
      id: row['id'],
      userId: row['userId'],
      dutyDuration: row['dutyDuration'],
      sharePercentage: row['sharePercentage'],
      salary: row['salary'],
      firstName: row['firstName'],
      lastName: row['lastName'],
      fatherHusbandName: row['fatherHusbandName'],
      gender: row['gender'],
      cnic: row['cnic'],
      contact: row['contact'],
      emergencyContact: row['emergencyContact'],
      experience: row['experience'],
      floorNo: row['floorNo'],
      joiningDate: row['joiningDate'],
      address: row['address'],
      userType: row['userType'],
      email: row['email'],
      dateOfBirth: row['dateOfBirth'],
      maritalStatus: row['maritalStatus'],
      religion: row['religion'],
      qualificationList: qualificationRequestList,
    );

    Navigator.pushNamed(
      context,
      Strings.routeEditNurse,
      arguments: nurseRequest,
    ).then((value) => onGoBack(value));
  }

  void onPressedDeleteFromTable(id, row) {
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text("Cancel", style: TextStyle(color: Shade.alertBoxButtonTextCancel, fontWeight: FontWeight.w900)),
    );

    Widget deleteButton = TextButton(
      child: Text("Delete", style: TextStyle(color: Shade.alertBoxButtonTextDelete, fontWeight: FontWeight.w900)),
      onPressed: () => onCallingDeleteNurse(id),
    );

    AlertDialog alert = AlertDialog(
      title: Row(
        children: [
          Text(Strings.alertDialogTitleDelete),
        ],
      ),
      content: Row(
        children: [
          Text(Strings.alertDialogTitleDeleteNote),
          Text(
            row['firstName'],
            style: TextStyle(fontWeight: FontWeight.w100, color: Colors.red),
          )
        ],
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
      actionsPadding: EdgeInsets.fromLTRB(Dimens.actionsGlobalButtonLeft, Dimens.actionsGlobalButtonTop,
          Dimens.actionsGlobalButtonRight, Dimens.actionsGlobalButtonBottom),
    );

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> onCallingDeleteNurse(int id) async {
    Navigator.pop(context);
    globalProgressDialog.showSimpleFontellicoProgressDialog(
        false, Strings.dialogDeleting, SimpleFontelicoProgressDialogType.multilines);
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        NurseResponse doctorResponse =
            await nurseService.deleteNurse(id, context.read<TokenProvider>().tokenSample.jwtToken);
        if (doctorResponse != null) {
          if (doctorResponse.isSuccess) {
            checkTokenValidityAndGetNurse();
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, doctorResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, doctorResponse.message, context);
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

  void onChangedSearchedValue(value) {
    if (!nurseIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 1) {
          var searchList = nurseIsSource.where((element) {
            String searchById = element["id"].toString().toLowerCase();
            String searchByFirstName = element["firstName"].toString().toLowerCase();
            String searchByLastName = element["lastName"].toString().toLowerCase();
            String searchByEmail = element["email"].toString().toLowerCase();
            if (searchById.contains(value.toLowerCase()) ||
                searchByFirstName.contains(value.toLowerCase()) ||
                searchByLastName.contains(value.toLowerCase()) ||
                searchByEmail.contains(value.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          });
          nurseIsSearched = [];
          nurseIsSearched.addAll(generateNurseSearchData(searchList));
          setState(() {
            showSearchedList = true;
          });
        } else {
          setState(() {
            showSearchedList = false;
          });
        }
      } else {
        setState(() {
          showSearchedList = false;
        });
      }
    }
  }

  Widget widgetnursePatients() {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(0),
          constraints: BoxConstraints(
            maxHeight: 500,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ResponsiveDatatable(
              actions: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none, prefixIcon: Icon(Icons.search_outlined), hintText: 'Search nurse'),
                  onChanged: (value) => onChangedSearchedValue(value),
                )),
              ],
              headers: nurseHeaders,
              source: !showSearchedList ? nurseIsSource : nurseIsSearched,
              selecteds: nurseSelecteds,
              showSelect: nurseShowSelect,
              autoHeight: false,
              onTabRow: (data) {
                print(data);
              },
              onSort: (value) {
                setState(() {
                  nurseSortColumn = value;
                  nurseSortAscending = !nurseSortAscending;
                  if (nurseSortAscending) {
                    nurseIsSource.sort((a, b) => b["$nurseSortColumn"].compareTo(a["$nurseSortColumn"]));
                  } else {
                    nurseIsSource.sort((a, b) => a["$nurseSortColumn"].compareTo(b["$nurseSortColumn"]));
                  }
                });
              },
              sortAscending: nurseSortAscending,
              sortColumn: nurseSortColumn,
              isLoading: nurseIsLoading,
              onSelect: (value, item) {
                print("$value  $item ");
                if (value) {
                  setState(() => nurseSelecteds.add(item));
                } else {
                  setState(() => nurseSelecteds.removeAt(nurseSelecteds.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value) {
                  setState(() => nurseSelecteds = nurseIsSource.map((entry) => entry).toList().cast());
                } else {
                  setState(() => nurseSelecteds.clear());
                }
              },
            ),
          ),
        ),
      ]),
    );
  }
}
