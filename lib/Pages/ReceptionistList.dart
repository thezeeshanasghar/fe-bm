import 'dart:async';

import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/QualificationRequest.dart';
import 'package:baby_doctor/Models/Requests/ReceptionistRequest.dart';
import 'package:baby_doctor/Models/Responses/ReceptionistResponse.dart';
import 'package:baby_doctor/Models/Sample/QualificationSample.dart';
import 'package:baby_doctor/Models/Sample/ReceptionistSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/ReceptionistService.dart';
import 'package:baby_doctor/ShareArguments/ReceptionistArguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ReceptionistList extends StatefulWidget {
  @override
  _ReceptionistListState createState() => _ReceptionistListState();
}

class _ReceptionistListState extends State<ReceptionistList> {
  final formKey = GlobalKey<FormState>();
  int receptionistTotal;
  int receptionistCurrentPerPage;
  int receptionistCurrentPage;
  bool receptionistIsSearch;
  String receptionistSelectableKey;
  String receptionistSortColumn;
  bool receptionistSortAscending;
  bool receptionistIsLoading;
  bool receptionistShowSelect;
  bool showSearchedList;
  List<DatatableHeader> receptionistHeaders;
  List<int> receptionistPerPage;
  List<Map<String, dynamic>> receptionistIsSource;
  List<Map<String, dynamic>> receptionistIsSearched;
  List<Map<String, dynamic>> receptionistSelected;
  List<ReceptionistSample> listReceptionist;
  ReceptionistService receptionistService;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initHeadersOfReceptionistTable();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      checkTokenValidityAndGetReceptionist();
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
          title: Text(Strings.titleReceptionistList),
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
                          children: <Widget>[widgetReceptionist()],
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
            Navigator.pushNamed(context, Strings.routeAddReceptionist);
          },
          child: const Icon(Icons.add),
          backgroundColor: Shade.fabGlobalButtonColor,
        ));
  }

  FutureOr onGoBack(dynamic value) {
    checkTokenValidityAndGetReceptionist();
  }

  void initVariablesAndClasses() {
    receptionistHeaders = [];
    receptionistPerPage = [5, 10, 15, 100];
    receptionistTotal = 100;
    receptionistCurrentPage = 1;
    receptionistIsSearch = false;
    receptionistIsSource = [];
    receptionistIsSearched = [];
    receptionistSelected = [];
    receptionistSelectableKey = "Invoice";
    receptionistSortAscending = true;
    receptionistIsLoading = true;
    receptionistShowSelect = false;
    listReceptionist = [];
    showSearchedList = false;
    receptionistService = ReceptionistService();
  }

  Future<void> checkTokenValidityAndGetReceptionist() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        getReceptionistFromApiAndLinkToTable();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  Future<void> getReceptionistFromApiAndLinkToTable() async {
    setState(() => receptionistIsLoading = true);
    listReceptionist = [];
    receptionistIsSource = [];
    try {
      ReceptionistResponseList receptionistList =
          await receptionistService.getReceptionists(context.read<TokenProvider>().tokenSample.jwtToken);
      if (receptionistList != null) {
        if (receptionistList.isSuccess) {
          listReceptionist = receptionistList.data;
          receptionistIsSource.addAll(generateReceptionistDataFromApi(listReceptionist));
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, receptionistList.message, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
      }
      setState(() => receptionistIsLoading = false);
    } catch (exception) {
      setState(() => receptionistIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generateReceptionistDataFromApi(List<ReceptionistSample> listOfReceptionist) {
    List<Map<String, dynamic>> tempsReceptionist = [];
    for (ReceptionistSample receptionist in listOfReceptionist) {
      tempsReceptionist.add({
        "id": receptionist.id,
        "userId": receptionist.userId,
        "jobType": receptionist.jobType,
        "shiftTime": receptionist.shiftTime,
        "userType": receptionist.user.userType,
        "dateOfBirth": receptionist.user.dateOfBirth,
        "maritalStatus": receptionist.user.maritalStatus,
        "religion": receptionist.user.religion,
        "firstName": receptionist.user.firstName,
        "lastName": receptionist.user.lastName,
        "fatherHusbandName": receptionist.user.fatherHusbandName,
        "gender": receptionist.user.gender,
        "cnic": receptionist.user.cnic,
        "contact": receptionist.user.contact,
        "emergencyContact": receptionist.user.emergencyContact,
        "email": receptionist.user.email,
        "address": receptionist.user.address,
        "joiningDate": receptionist.user.joiningDate,
        "floorNo": receptionist.user.floorNo,
        "experience": receptionist.user.experience,
        "qualifications": receptionist.user.qualifications,
        "Action": receptionist.id,
      });
    }
    return tempsReceptionist;
  }

  List<Map<String, dynamic>> generateReceptionistSearchData(Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsreceptionist = [];
    for (var iterable in iterableList) {
      tempsreceptionist.add({
        "Id": iterable["Id"],
        "firstName": iterable["firstName"],
        "lastName": iterable["lastName"],
        "CNIC": iterable["CNIC"],
        "email": iterable["email"],
        "contact": iterable["contact"],
        "Action": iterable["Action"],
      });
    }
    return tempsreceptionist;
  }

  void initHeadersOfReceptionistTable() {
    receptionistHeaders = [
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
          value: "jobType",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Job Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "shiftTime",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Shift Time",
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

    ReceptionistRequest receptionistRequest = ReceptionistRequest(
      id: row['id'],
      jobType: row['jobType'],
      shiftTime: row['shiftTime'],
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
      userId: row['userId'],
      userType: row['userType'],
      email: row['email'],
      dateOfBirth: row['dateOfBirth'],
      maritalStatus: row['maritalStatus'],
      religion: row['religion'],
      qualificationList: qualificationRequestList,
    );

    Navigator.pushNamed(
      context,
      Strings.routeEditReceptionist,
      arguments: receptionistRequest,
    ).then((value) => onGoBack(value));
  }

  void onPressedDeleteFromTable(id, row) {
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text("Cancel", style: TextStyle(color: Shade.alertBoxButtonTextCancel, fontWeight: FontWeight.w900)),
    );

    Widget deleteButton = TextButton(
      child: Text("Delete", style: TextStyle(color: Shade.alertBoxButtonTextDelete, fontWeight: FontWeight.w900)),
      onPressed: () => onCallingDeleteReceptionist(id),
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
            row['firstName'] + ' ?',
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

  Future<void> onCallingDeleteReceptionist(int id) async {
    Navigator.pop(context);
    globalProgressDialog.showSimpleFontellicoProgressDialog(
        false, Strings.dialogDeleting, SimpleFontelicoProgressDialogType.multilines);
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        ReceptionistResponse receptionistResponse =
            await receptionistService.deleteReceptionist(id, context.read<TokenProvider>().tokenSample.jwtToken);
        if (receptionistResponse != null) {
          if (receptionistResponse.isSuccess) {
            checkTokenValidityAndGetReceptionist();
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
    if (!receptionistIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 2) {
          var searchList = receptionistIsSource.where((element) {
            String searchById = element["Id"].toString().toLowerCase();
            String searchByFirstName = element["firstName"].toString().toLowerCase();
            String searchByLastName = element["lastName"].toString().toLowerCase();
            String searchByEmail = element["email"].toString().toLowerCase();
            String searchByContactNumber = element["contactNumber"].toString().toLowerCase();
            if (searchById.contains(value.toLowerCase()) ||
                searchByFirstName.contains(value.toLowerCase()) ||
                searchByLastName.contains(value.toLowerCase()) ||
                searchByEmail.contains(value.toLowerCase()) ||
                searchByContactNumber.contains(value.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          });
          receptionistIsSearched = [];
          receptionistIsSearched.addAll(generateReceptionistSearchData(searchList));
          setState(() {
            showSearchedList = true;
          });
        } else {
          setState(() {
            showSearchedList = false;
          });
        }
      }
    }
  }

  Widget widgetReceptionist() {
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
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search_outlined),
                      hintText: 'Search receptionist'),
                  onChanged: (value) => onChangedSearchedValue(value),
                )),
              ],
              headers: receptionistHeaders,
              source: !showSearchedList ? receptionistIsSource : receptionistIsSearched,
              selecteds: receptionistSelected,
              showSelect: receptionistShowSelect,
              autoHeight: false,
              onTabRow: (data) {
                print(data);
              },
              onSort: (value) {
                setState(() {
                  receptionistSortColumn = value;
                  receptionistSortAscending = !receptionistSortAscending;
                  if (receptionistSortAscending) {
                    receptionistIsSource
                        .sort((a, b) => b["$receptionistSortColumn"].compareTo(a["$receptionistSortColumn"]));
                  } else {
                    receptionistIsSource
                        .sort((a, b) => a["$receptionistSortColumn"].compareTo(b["$receptionistSortColumn"]));
                  }
                });
              },
              sortAscending: receptionistSortAscending,
              sortColumn: receptionistSortColumn,
              isLoading: receptionistIsLoading,
              onSelect: (value, item) {
                print("$value  $item ");
                if (value) {
                  setState(() => receptionistSelected.add(item));
                } else {
                  setState(() => receptionistSelected.removeAt(receptionistSelected.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value) {
                  setState(() => receptionistSelected = receptionistIsSource.map((entry) => entry).toList().cast());
                } else {
                  setState(() => receptionistSelected.clear());
                }
              },
            ),
          ),
        ),
      ]),
    );
  }
}
