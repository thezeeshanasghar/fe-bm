import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Responses/AppointmentResponse.dart';
import 'package:baby_doctor/Models/Responses/PatientResponse.dart';
import 'package:baby_doctor/Models/Sample/AppointmentSample.dart';
import 'package:baby_doctor/Models/Sample/PatientSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/AppointmentService.dart';
import 'package:baby_doctor/Service/PatientService.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class OnlineList extends StatefulWidget {
  @override
  _OnlineListState createState() => _OnlineListState();
}

class _OnlineListState extends State<OnlineList> {
  bool admitted = false;
  bool walkIn = false;
  bool online = true;

  final formKey = GlobalKey<FormState>();
  PatientService patientService;
  AppointmentService appointmentService;

  // Online Data
  List<DatatableHeader> onlineHeaders = [];
  List<int> onlinePerPage = [5, 10, 15, 100];
  int onlineTotal = 100;
  int onlineCurrentPerPage;
  int onlineCurrentPage = 1;
  bool onlineIsSearch = false;
  List<Map<String, dynamic>> onlineIsSource = [];
  List<Map<String, dynamic>> onlineSelecteds = [];
  String onlineSelectableKey = "Invoice";
  String onlineSortColumn;
  String PatientId;
  List<AppointmentSample> listOnline;
  bool onlineSortAscending = true;
  bool onlineIsLoading = true;
  bool onlineShowSelect = false;

  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;

  @override
  void initState() {
    super.initState();
    patientService = PatientService();
    appointmentService = AppointmentService();
    initOnlineVariablesAndClasses();
    initializeOnlineHeaders();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      checkTokenValidityAndGetPatients();
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
    return widgetOnlinePatients();
  }

  void initOnlineVariablesAndClasses() {
    onlineHeaders = [];
    onlinePerPage = [5, 10, 15, 100];
    onlineTotal = 100;
    onlineCurrentPerPage;
    onlineCurrentPage = 1;
    onlineIsSearch = false;
    onlineIsSource = [];
    onlineSelecteds = [];
    onlineSelectableKey = "Invoice";
    onlineSortColumn;
    onlineSortAscending = true;
    onlineIsLoading = true;
    onlineShowSelect = false;

    patientService = PatientService();
  }

  initializeOnlineHeaders() {
    onlineHeaders = [
      DatatableHeader(
          value: "Invoice",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Invoice",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "firstName",
          show: true,
          flex: 1,
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
          value: "lastName",
          show: false,
          flex: 2,
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
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Father Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "dateOfBirth",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "DOB",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientCategory",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Checkup Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "birthPlace",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Place Of Birth",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "externalId",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "External Id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "bloodGroup",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Blood Group",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "clinicSite",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Clinic Site",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "referredBy",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Referred By",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "referredDate",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Referred Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "guardian",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Guardian",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "paymentProfile",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Payment Profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "description",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Action",
          show: true,
          flex: 2,
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
                      // onPressed: () => onPressedEditFromTable(id, row),
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

  Future<void> checkTokenValidityAndGetPatients() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        getOnlineFromApiAndLinkToTable();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  Future<void>  getOnlineFromApiAndLinkToTable() async {
    setState(() => onlineIsLoading = true);
    listOnline = [];
    onlineIsSource = [];
    try {
      AppointmentResponseList walkInList =
          await appointmentService.getPatientAppointmentsByCategory(context.read<TokenProvider>().tokenSample.jwtToken, 'Online');
      print(listOnline);
      if (walkInList != null) {
        if (walkInList.isSuccess) {
          listOnline = walkInList.data;
          print(listOnline);
          onlineIsSource.addAll(generateOnlineDataFromApi(listOnline));
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, walkInList.message, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
      }
      setState(() => onlineIsLoading = false);
    } catch (exception) {
      setState(() => onlineIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generateOnlineDataFromApi(List<AppointmentSample> listOnline) {
    List<Map<String, dynamic>> tempsOnline = [];
    for (AppointmentSample appointmentSample in listOnline) {
      tempsOnline.add({
        "id": appointmentSample.id,
        "Invoice": appointmentSample.id,
        "patientId": appointmentSample.patientId,
        "doctorId": appointmentSample.doctorId,
        "receptionistId": appointmentSample.receptionistId,
        "code": appointmentSample.code,
        "date": appointmentSample.date,
        "consultationDate": appointmentSample.consultationDate,
        "type": appointmentSample.type,
        "patientCategory": appointmentSample.patientCategory,
        "userId": appointmentSample.patient.userId,
        "birthPlace": appointmentSample.patient.birthPlace,
        "externalId": appointmentSample.patient.externalId,
        "bloodGroup": appointmentSample.patient.bloodGroup,
        "clinicSite": appointmentSample.patient.clinicSite,
        "referredBy": appointmentSample.patient.referredBy,
        "referredDate": appointmentSample.patient.referredDate,
        "guardian": appointmentSample.patient.guardian,
        "paymentProfile": appointmentSample.patient.paymentProfile,
        "description": appointmentSample.patient.description,
        "userType": appointmentSample.patient.user.userType,
        "dateOfBirth": appointmentSample.patient.user.dateOfBirth.substring(0,10),
        "maritalStatus": appointmentSample.patient.user.maritalStatus,
        "religion": appointmentSample.patient.user.religion,
        "firstName": appointmentSample.patient.user.firstName,
        "lastName": appointmentSample.patient.user.lastName,
        "fatherHusbandName": appointmentSample.patient.user.fatherHusbandName,
        "gender": appointmentSample.patient.user.gender,
        "cnic": appointmentSample.patient.user.cnic,
        "contact": appointmentSample.patient.user.contact,
        "emergencyContact": appointmentSample.patient.user.emergencyContact,
        "email": appointmentSample.patient.user.email,
        "address": appointmentSample.patient.user.address,
        "joiningDate": appointmentSample.patient.user.joiningDate,
        "floorNo": appointmentSample.patient.user.floorNo,
        "experience": appointmentSample.patient.user.experience,
        "Action": appointmentSample.id,
      });
    }
    return tempsOnline;
  }

  Widget widgetOnlinePatients() {
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
              title: !onlineIsSearch
                  ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.online_prediction),
                        ),
                        Text(
                          "Online",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : null,
              actions: [
                if (onlineIsSearch)
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(
                        prefixIcon: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                onlineIsSearch = false;
                              });
                            }),
                        suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {})),
                  )),
                if (!onlineIsSearch)
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          onlineIsSearch = true;
                        });
                      })
              ],
              headers: onlineHeaders,
              source: onlineIsSource,
              selecteds: onlineSelecteds,
              showSelect: onlineShowSelect,
              autoHeight: false,
              onTabRow: (data) {
                // print(data);
              },
              onSort: (value) {
                setState(() {
                  onlineSortColumn = value;
                  onlineSortAscending = !onlineSortAscending;
                  if (onlineSortAscending) {
                    onlineIsSource.sort((a, b) => b["$onlineSortColumn"].compareTo(a["$onlineSortColumn"]));
                  } else {
                    onlineIsSource.sort((a, b) => a["$onlineSortColumn"].compareTo(b["$onlineSortColumn"]));
                  }
                });
              },
              sortAscending: onlineSortAscending,
              sortColumn: onlineSortColumn,
              isLoading: onlineIsLoading,
              onSelect: (value, item) {
                print("$value  $item ");
                if (value) {
                  setState(() => onlineSelecteds.add(item));
                } else {
                  setState(() => onlineSelecteds.removeAt(onlineSelecteds.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value) {
                  setState(() => onlineSelecteds = onlineIsSource.map((entry) => entry).toList().cast());
                } else {
                  setState(() => onlineSelecteds.clear());
                }
              },
              footers: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("Rows per page:"),
                ),
                if (onlinePerPage != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: DropdownButton(
                        value: onlineCurrentPerPage,
                        items: onlinePerPage
                            .map((e) => DropdownMenuItem(
                                  child: Text("$e"),
                                  value: e,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            onlineCurrentPerPage = value;
                          });
                        }),
                  ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text("$onlineCurrentPage - $onlineCurrentPerPage of $onlineTotal"),
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      onlineCurrentPage = onlineCurrentPage >= 2 ? onlineCurrentPage - 1 : 1;
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    setState(() {
                      onlineCurrentPage++;
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void onPressedDeleteFromTable(id, row) {
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text("Cancel", style: TextStyle(color: Shade.alertBoxButtonTextCancel, fontWeight: FontWeight.w900)),
    );

    Widget deleteButton = TextButton(
      child: Text("Delete", style: TextStyle(color: Shade.alertBoxButtonTextDelete, fontWeight: FontWeight.w900)),
      onPressed: () => onCallingDeletePatient(id),
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

  Future<void> onCallingDeletePatient(int id) async {
    Navigator.pop(context);
    globalProgressDialog.showSimpleFontellicoProgressDialog(
        false, Strings.dialogDeleting, SimpleFontelicoProgressDialogType.multilines);
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        PatientResponse patientResponse =
            await patientService.deletePatient(id, context.read<TokenProvider>().tokenSample.jwtToken);
        if (patientResponse != null) {
          if (patientResponse.isSuccess) {
            checkTokenValidityAndGetPatients();
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, patientResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, patientResponse.message, context);
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
