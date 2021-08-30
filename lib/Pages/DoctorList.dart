import 'dart:async';

import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/DoctorRequest.dart';
import 'package:baby_doctor/Models/Requests/QualificationRequest.dart';
import 'package:baby_doctor/Models/Responses/DoctorResponse.dart';
import 'package:baby_doctor/Models/Sample/DoctorSample.dart';
import 'package:baby_doctor/Models/Sample/QualificationSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/DoctorService.dart';
import 'package:baby_doctor/ShareArguments/DoctorArguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final formKey = GlobalKey<FormState>();
  int doctorTotal;
  int doctorCurrentPerPage;
  int doctorCurrentPage;
  bool doctorIsSearch;
  String doctorSelectableKey;
  String doctorSortColumn;
  bool doctorSortAscending;
  bool doctorIsLoading;
  bool doctorShowSelect;
  bool showSearchedList;
  SimpleFontelicoProgressDialog sfpd;
  List<DatatableHeader> doctorHeaders;
  List<int> doctorPerPage;
  List<Map<String, dynamic>> doctorIsSource;
  List<Map<String, dynamic>> doctorIsSearched;
  List<Map<String, dynamic>> doctorSelected;
  List<DoctorSample> listDoctor;
  DoctorService doctorService;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initializeDoctorHeaders();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      checkTokenValidityAndGetDoctor();
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
          title: Text(Strings.titleDoctorList),
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
                          children: <Widget>[widgetDoctorPatients()],
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
            Navigator.pushNamed(context, Strings.routeAddDoctor);
          },
          child: const Icon(Icons.add),
          backgroundColor: Shade.fabGlobalButtonColor,
        ));
  }

  FutureOr onGoBack(dynamic value) {
    checkTokenValidityAndGetDoctor();
  }

  void initVariablesAndClasses() {
    doctorHeaders = [];
    doctorPerPage = [5, 10, 15, 100];
    doctorTotal = 100;
    doctorCurrentPage = 1;
    doctorIsSearch = false;
    doctorIsSource = [];
    doctorIsSearched = [];
    doctorSelected = [];
    doctorSelectableKey = "Invoice";
    doctorSortAscending = true;
    doctorIsLoading = true;
    doctorShowSelect = false;
    listDoctor = [];
    showSearchedList = false;
    doctorService = DoctorService();
  }

  Future<void> checkTokenValidityAndGetDoctor() async {
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
    setState(() => doctorIsLoading = true);
    listDoctor = [];
    doctorIsSource = [];
    try {
      DoctorResponseList doctorList =
          await doctorService.getDoctors(context.read<TokenProvider>().tokenSample.jwtToken);
      if (doctorList != null) {
        if (doctorList.isSuccess) {
          listDoctor = doctorList.data;
          doctorIsSource.addAll(generateDoctorDataFromApi(listDoctor));
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, doctorList.message, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
      }
      setState(() => doctorIsLoading = false);
    } catch (exception) {
      setState(() => doctorIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generateDoctorDataFromApi(List<DoctorSample> listOfDoctors) {
    List<Map<String, dynamic>> tempsdoctor = [];
    for (DoctorSample doctors in listOfDoctors) {
      tempsdoctor.add({
        "id": doctors.id,
        "userId": doctors.userId,
        "consultationFee": doctors.consultationFee,
        "emergencyConsultationFee": doctors.emergencyConsultationFee,
        "shareInFee": doctors.shareInFee,
        "specialityType": doctors.specialityType,
        "userType": doctors.user.userType,
        "dateOfBirth": doctors.user.dateOfBirth,
        "maritalStatus": doctors.user.maritalStatus,
        "religion": doctors.user.religion,
        "firstName": doctors.user.firstName,
        "lastName": doctors.user.lastName,
        "fatherHusbandName": doctors.user.fatherHusbandName,
        "gender": doctors.user.gender,
        "cnic": doctors.user.cnic,
        "contact": doctors.user.contact,
        "emergencyContact": doctors.user.emergencyContact,
        "email": doctors.user.email,
        "address": doctors.user.address,
        "joiningDate": doctors.user.joiningDate,
        "floorNo": doctors.user.floorNo,
        "experience": doctors.user.experience,
        "qualifications": doctors.user.qualifications,
        "Action": doctors.id,
      });
    }
    return tempsdoctor;
  }

  List<Map<String, dynamic>> generateDoctorSearchData(Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsdoctor = [];
    for (var iterable in iterableList) {
      tempsdoctor.add({
        "id": iterable["id"],
        "firstName": iterable["firstName"],
        "lastName": iterable["lastName"],
        "specialityType": iterable["specialityType"],
        "Action": iterable["Action"],
      });
    }
    return tempsdoctor;
  }

  void initializeDoctorHeaders() {
    doctorHeaders = [
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
          value: "consultationFee",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Fee",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "emergencyConsultationFee",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Emergency Fee",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "shareInFee",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Fee Share",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "specialityType",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Speciality Type",
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

    DoctorRequest doctorRequest = DoctorRequest(
      id: row['id'],
      consultationFee: row['consultationFee'],
      emergencyConsultationFee: row['emergencyConsultationFee'],
      shareInFee: row['shareInFee'],
      specialityType: row['specialityType'],
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
      Strings.routeEditDoctor,
      arguments: doctorRequest,
    ).then((value) => onGoBack(value));
  }

  void onPressedDeleteFromTable(id, row) {
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text("Cancel", style: TextStyle(color: Shade.alertBoxButtonTextCancel, fontWeight: FontWeight.w900)),
    );

    Widget deleteButton = TextButton(
      child: Text("Delete", style: TextStyle(color: Shade.alertBoxButtonTextDelete, fontWeight: FontWeight.w900)),
      onPressed: () => onCallingDeleteDoctor(id),
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

  Future<void> onCallingDeleteDoctor(int id) async {
    Navigator.pop(context);
    globalProgressDialog.showSimpleFontellicoProgressDialog(
        false, Strings.dialogDeleting, SimpleFontelicoProgressDialogType.multilines);
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        DoctorResponse doctorResponse =
            await doctorService.deleteDoctor(id, context.read<TokenProvider>().tokenSample.jwtToken);
        if (doctorResponse != null) {
          if (doctorResponse.isSuccess) {
            checkTokenValidityAndGetDoctor();
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
    if (!doctorIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 1) {
          var searchList = doctorIsSource.where((element) {
            String searchById = element["id"].toString().toLowerCase();
            String searchByName = element["firstName"].toString().toLowerCase();
            String searchByPerformedBy = element["lastName"].toString().toLowerCase();
            String searchByCharges = element["specialityType"].toString().toLowerCase();
            if (searchById.contains(value.toLowerCase()) ||
                searchByName.contains(value.toLowerCase()) ||
                searchByPerformedBy.contains(value.toLowerCase()) ||
                searchByCharges.contains(value.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          });
          doctorIsSearched = [];
          doctorIsSearched.addAll(generateDoctorSearchData(searchList));
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

  Widget widgetDoctorPatients() {
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
                      border: InputBorder.none, prefixIcon: Icon(Icons.search_outlined), hintText: 'Search doctor'),
                  onChanged: (value) => onChangedSearchedValue(value),
                )),
              ],
              headers: doctorHeaders,
              source: !showSearchedList ? doctorIsSource : doctorIsSearched,
              selecteds: doctorSelected,
              showSelect: doctorShowSelect,
              autoHeight: false,
              onTabRow: (data) {
                print(data);
              },
              onSort: (value) {
                setState(() {
                  doctorSortColumn = value;
                  doctorSortAscending = !doctorSortAscending;
                  if (doctorSortAscending) {
                    doctorIsSource.sort((a, b) => b["$doctorSortColumn"].compareTo(a["$doctorSortColumn"]));
                  } else {
                    doctorIsSource.sort((a, b) => a["$doctorSortColumn"].compareTo(b["$doctorSortColumn"]));
                  }
                });
              },
              sortAscending: doctorSortAscending,
              sortColumn: doctorSortColumn,
              isLoading: doctorIsLoading,
              onSelect: (value, item) {
                print("$value  $item ");
                if (value) {
                  setState(() => doctorSelected.add(item));
                } else {
                  setState(() => doctorSelected.removeAt(doctorSelected.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value) {
                  setState(() => doctorSelected = doctorIsSource.map((entry) => entry).toList().cast());
                } else {
                  setState(() => doctorSelected.clear());
                }
              },
            ),
          ),
        ),
      ]),
    );
  }
}
