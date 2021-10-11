import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/AppointmentSearchRequest.dart';
import 'package:baby_doctor/Models/Responses/AppointmentResponse.dart';
import 'package:baby_doctor/Models/Responses/DoctorResponse.dart';
import 'package:baby_doctor/Models/Responses/PatientResponse.dart';
import 'package:baby_doctor/Models/Responses/ReceptionistResponse.dart';
import 'package:baby_doctor/Models/Sample/AppointmentSample.dart';
import 'package:baby_doctor/Models/Sample/DoctorSample.dart';
import 'package:baby_doctor/Models/Sample/ReceptionistSample.dart';
import 'package:baby_doctor/Models/Sample/UserSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/AppointmentService.dart';
import 'package:baby_doctor/Service/DoctorService.dart';
import 'package:baby_doctor/Service/PatientService.dart';
import 'package:baby_doctor/Service/ReceptionistService.dart';
import 'package:baby_doctor/constants/QEnum.dart';
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
  final formKey = GlobalKey<FormState>();
  bool online = true;
  List<DatatableHeader> onlineHeaders = [];
  List<int> onlinePerPage = [5, 10, 15, 100];
  int onlineTotal = 100;
  int onlineCurrentPerPage;
  int onlineCurrentPage = 1;
  bool onlineIsSearch;
  List<Map<String, dynamic>> onlineIsSource = [];
  List<Map<String, dynamic>> onlineSelected = [];
  String onlineSelectableKey = "Invoice";
  String onlineSortColumn;
  bool onlineSortAscending = true;
  bool onlineIsLoading = true;
  bool onlineShowSelect = false;
  List<AppointmentSample> listOnline;
  List<DoctorSample> listDoctor;
  List<ReceptionistSample> listReceptionist;
  AppointmentService appointmentService;
  List<Map<String, dynamic>> onlineIsSearched;
  final _tecFromDate = TextEditingController();
  final _tecToDate = TextEditingController();
  String fromDate;
  String toDate;
  DoctorService doctorService;
  PatientService patientService;
  ReceptionistService receptionistService;
  bool showSearchedList;
  DoctorSample doctorSampleDropDown = DoctorSample(id: -1);
  ReceptionistSample receptionistSampleDropDown = ReceptionistSample(id: -1);
  bool hasDoctors = false;
  bool hasReceptionist = false;

  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;

  @override
  void initState() {
    super.initState();
    appointmentService = AppointmentService();
    patientService = PatientService();
    doctorService = DoctorService();
    receptionistService = ReceptionistService();
    initonlineVariablesAndClasses();
    initializeonlineHeaders();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      onSelectDoctorValue();
      onSelectReceptionistValue();
      checkTokenValidityAndGetPatients();
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tecToDate.dispose();
    _tecFromDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widgetOnlinePatients();
  }

  void initonlineVariablesAndClasses() {
    onlineHeaders = [];
    onlinePerPage = [5, 10, 15, 100];
    onlineTotal = 100;
    onlineCurrentPerPage;
    onlineCurrentPage = 1;
    onlineIsSearch = false;
    onlineIsSource = [];
    onlineSelected = [];
    onlineSelectableKey = "Invoice";
    onlineSortColumn;
    listOnline = [];
    onlineSortAscending = true;
    onlineIsLoading = true;
    onlineShowSelect = false;
    showSearchedList = false;
    appointmentService = AppointmentService();
    patientService = PatientService();
  }

  Widget widgetOnlinePatients() {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Container(
                color: Colors.grey[100],
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey[300])),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: hasDoctors
                                      ? DropdownButton<DoctorSample>(
                                          isExpanded: true,
                                          elevation: 16,
                                          value: doctorSampleDropDown,
                                          underline: Container(
                                            height: 0,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged:
                                              (DoctorSample doctorSample) {
                                            setState(() {
                                              doctorSampleDropDown =
                                                  doctorSample;
                                              print(doctorSampleDropDown.id);
                                            });
                                          },
                                          items: listDoctor.map<
                                                  DropdownMenuItem<
                                                      DoctorSample>>(
                                              (DoctorSample doctorSample) {
                                            return DropdownMenuItem<
                                                DoctorSample>(
                                              value: doctorSample,
                                              child: Text(
                                                  '${doctorSample.user.firstName} ${doctorSample.user.lastName}'),
                                            );
                                          }).toList(),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator())),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: TextFormField(
                                    cursorColor: Colors.grey[600],
                                    readOnly: true,
                                    controller: _tecFromDate,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[300]),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[300]),
                                      ),
                                      focusColor: Colors.grey[600],
                                      labelText: 'From Date',
                                      suffixIcon: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.date_range_outlined,
                                              color: Colors.grey[600],
                                            ),
                                            onPressed: () => _pickDate(
                                                context: context,
                                                dateType:
                                                    searchDateType.fromDate,
                                                firstDate: DateTime(
                                                    DateTime.now().month - 1),
                                                initialDate: DateTime.now(),
                                                lastDate: DateTime.now(),
                                                tecDate: _tecFromDate),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.clear_outlined,
                                                color: Colors.grey[600],
                                              ),
                                              onPressed: () {
                                                _tecFromDate.text = '';
                                              }),
                                        ],
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: TextFormField(
                                    cursorColor: Colors.grey[600],
                                    readOnly: true,
                                    controller: _tecToDate,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[300]),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey[300]),
                                      ),
                                      focusColor: Colors.grey[600],
                                      labelText: 'To Date',
                                      suffixIcon: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.date_range_outlined,
                                              color: Colors.grey[600],
                                            ),
                                            onPressed: () => _pickDate(
                                                context: context,
                                                dateType:
                                                    searchDateType.fromDate,
                                                firstDate: DateTime(
                                                    DateTime.now().month - 1),
                                                initialDate: DateTime.now(),
                                                lastDate: DateTime.now(),
                                                tecDate: _tecToDate),
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.clear_outlined,
                                                color: Colors.grey[600],
                                              ),
                                              onPressed: () {
                                                _tecToDate.text = '';
                                              }),
                                        ],
                                      ),
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          // Column(
                          //   children: [
                          //     Text(
                          //       'Booked By',
                          //       style: TextStyle(fontWeight: FontWeight.bold),
                          //     ),
                          //   ],
                          // ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: Colors.grey[300])),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: hasReceptionist
                                      ? DropdownButton<ReceptionistSample>(
                                          isExpanded: true,
                                          elevation: 16,
                                          value: receptionistSampleDropDown,
                                          underline: Container(
                                            height: 0,
                                            color: Colors.deepPurpleAccent,
                                          ),
                                          onChanged: (ReceptionistSample
                                              receptionistSample) {
                                            setState(() {
                                              receptionistSampleDropDown =
                                                  receptionistSample;
                                              print(receptionistSampleDropDown
                                                  .id);
                                            });
                                          },
                                          items: listReceptionist.map<
                                                  DropdownMenuItem<
                                                      ReceptionistSample>>(
                                              (ReceptionistSample
                                                  receptionistSample) {
                                            return DropdownMenuItem<
                                                ReceptionistSample>(
                                              value: receptionistSample,
                                              child: Text(
                                                  '${receptionistSample.user.firstName} ${receptionistSample.user.lastName}'),
                                            );
                                          }).toList(),
                                        )
                                      : Center(
                                          child: CircularProgressIndicator())),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
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
                    widgetSearch(),
                  ],
                  headers: onlineHeaders,
                  source: !showSearchedList ? onlineIsSource : onlineIsSearched,
                  selecteds: onlineSelected,
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
                        onlineIsSource.sort((a, b) => b["$onlineSortColumn"]
                            .compareTo(a["$onlineSortColumn"]));
                      } else {
                        onlineIsSource.sort((a, b) => a["$onlineSortColumn"]
                            .compareTo(b["$onlineSortColumn"]));
                      }
                    });
                  },
                  sortAscending: onlineSortAscending,
                  sortColumn: onlineSortColumn,
                  isLoading: onlineIsLoading,
                  onSelect: (value, item) {
                    if (value) {
                      setState(() => onlineSelected.add(item));
                    } else {
                      setState(() => onlineSelected
                          .removeAt(onlineSelected.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => onlineSelected =
                          onlineIsSource.map((entry) => entry).toList().cast());
                    } else {
                      setState(() => onlineSelected.clear());
                    }
                  },
                ),
              ),
            ),
          ]),
    );
  }

  initializeonlineHeaders() {
    onlineHeaders = [
      DatatableHeader(
          value: "id",
          show: true,
          flex: 1,
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
          value: "patientId",
          show: false,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Patient Id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorId",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Doctor Id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receptionistId",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Receptionist Id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "code",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Code",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "date",
          show: true,
          sortable: true,
          flex: 2,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "consultationDate",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Consultation Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "type",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Type",
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
                  "Patient Category",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "userId",
          show: false,
          sortable: true,
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
          value: "birthPlace",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Birth Place",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientType",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Patient Type",
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
                  "externalId",
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
                  "bloodGroup",
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
                  "clinicSite",
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
                  "referredBy",
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
                  "referredDate",
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
                  "guardian",
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
                  "description",
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
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  void getOnlineFromApiAndLinkToTable() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        AppointmentResponseList onlineList =
            await appointmentService.getPatientAppointmentsByCategory(
                context.read<TokenProvider>().tokenSample.jwtToken, 'Online');
        print(listOnline);
        if (onlineList != null) {
          if (onlineList.isSuccess) {
            listOnline = onlineList.data;
            onlineIsSource.addAll(generateOnlineDataFromApi(listOnline));
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(
                Shade.snackGlobalFailed, onlineList.message, context);
          }
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              Shade.snackGlobalFailed, Strings.errorNull, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
      setState(() => onlineIsLoading = false);
    } catch (exception) {
      setState(() => onlineIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generateOnlineDataFromApi(
      List<AppointmentSample> listOnlines) {
    List<Map<String, dynamic>> tempsonline = [];
    for (AppointmentSample appointmentSample in listOnlines) {
      tempsonline.add({
        "id": appointmentSample.id,
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
        "Action": appointmentSample.id,
      });
    }
    return tempsonline;
  }

  void onPressedDeleteFromTable(id, row) {
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text("Cancel",
          style: TextStyle(
              color: Shade.alertBoxButtonTextCancel,
              fontWeight: FontWeight.w900)),
    );

    Widget deleteButton = TextButton(
      child: Text("Delete",
          style: TextStyle(
              color: Shade.alertBoxButtonTextDelete,
              fontWeight: FontWeight.w900)),
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
      actionsPadding: EdgeInsets.fromLTRB(
          Dimens.actionsGlobalButtonLeft,
          Dimens.actionsGlobalButtonTop,
          Dimens.actionsGlobalButtonRight,
          Dimens.actionsGlobalButtonBottom),
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
    globalProgressDialog.showSimpleFontellicoProgressDialog(false,
        Strings.dialogDeleting, SimpleFontelicoProgressDialogType.multilines);
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        PatientResponse patientResponse = await patientService.deletePatient(
            id, context.read<TokenProvider>().tokenSample.jwtToken);
        if (patientResponse != null) {
          if (patientResponse.isSuccess) {
            checkTokenValidityAndGetPatients();
            GlobalSnackbar.showMessageUsingSnackBar(
                Shade.snackGlobalSuccess, patientResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(
                Shade.snackGlobalFailed, patientResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
          }
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              Shade.snackGlobalFailed, Strings.errorNull, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }

  Widget widgetSearch() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey[300]),
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Colors.grey[600],
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search_outlined,
                color: Colors.grey[600],
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
              ),
              focusColor: Colors.grey[600],
              hintText: 'Search'),
          onChanged: (value) => onChangedSearchedValue(value),
        ),
      ),
    ));
  }

  Future<void> onChangedSearchedValue(String search) async {
    if (!onlineIsLoading) {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        String x = 'Category';
        if (doctorSampleDropDown.id != -2 &&
            receptionistSampleDropDown.id == -2 &&
            _tecFromDate.toString().length == 0 &&
            _tecToDate.toString().length == 0) {
          x = 'CategoryAndDoctor';
          print(x);
        } else if (receptionistSampleDropDown.id != -2 &&
            doctorSampleDropDown.id == -2 &&
            _tecFromDate.toString().length == 0 &&
            _tecToDate.toString().length == 0) {
          x = 'CategoryAndBooked';
          print(x);
        } else if (receptionistSampleDropDown.id == -2 &&
            doctorSampleDropDown.id == -2 &&
            _tecFromDate.toString().length > 0 &&
            _tecToDate.toString().length > 0) {
          x = 'CategoryAndDate';
          print(x);
        } else if (doctorSampleDropDown.id != -2 &&
            receptionistSampleDropDown.id == -2 &&
            _tecFromDate.toString().length > 0 &&
            _tecToDate.toString().length > 0) {
          x = 'CategoryAndDoctorAndDate';
          print(x);
        } else if (doctorSampleDropDown.id != -2 &&
            receptionistSampleDropDown.id != -2 &&
            _tecFromDate.toString().length == 0 &&
            _tecToDate.toString().length == 0) {
          x = 'CategoryAndDoctorAndBooked';
          print(x);
        } else if (receptionistSampleDropDown.id != -2 &&
            doctorSampleDropDown.id == -2 &&
            _tecFromDate.toString().length > 0 &&
            _tecToDate.toString().length > 0) {
          x = 'CategoryAndDateAndBooked';
          print(x);
        } else if (doctorSampleDropDown.id != -2 &&
            receptionistSampleDropDown.id != -2 &&
            _tecFromDate.toString().length > 0 &&
            _tecToDate.toString().length > 0) {
          x = 'CategoryAndDoctorAndDateAndBooked';
          print(x);
        }
        AppointmentService service = AppointmentService();
        AppointmentResponseList serviceResponse =
            await service.getPatientAppointmentsBySearch(
                AppointmentSearchRequest(
                  search: search,
                  category: "online",
                  doctor: doctorSampleDropDown.id.toString(),
                  dateFrom: '2021-09-07',
                  dateTo: '2021-09-30',
                  booked: receptionistSampleDropDown.id.toString(),
                  searchFrom: x,
                ),
                context.read<TokenProvider>().tokenSample.jwtToken);
        if (serviceResponse != null) {
          if (serviceResponse.isSuccess) {
            onlineIsSource = [];
            listOnline = [];
            listOnline = serviceResponse.data;
            onlineIsSource.addAll(generateOnlineDataFromApi(listOnline));
            setState(() {
              showSearchedList = false;
            });
          }
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    }
  }

  Future<void> _pickDate({
    @required initialDate,
    @required firstDate,
    @required lastDate,
    @required dateType,
    @required context,
    @required TextEditingController tecDate,
  }) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (date != null) {
      if (dateType == searchDateType.fromDate) {
        tecDate.text = date.toString().substring(0, 10);
        _tecFromDate.text = tecDate.text;
      } else if (dateType == searchDateType.toDate) {
        tecDate.text = date.toString().substring(0, 10);
        _tecToDate.text = tecDate.text;
      }
    }
  }

  List<Map<String, dynamic>> generateOnlineSearchData(
      Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsPatient = [];
    for (var iterable in iterableList) {
      tempsPatient.add({
        "id": iterable["id"],
        "firstName": iterable["firstName"],
        "lastName": iterable["lastName"],
        "email": iterable["email"],
        "category": iterable["category"],
        "dateOfBirth": iterable["dateOfBirth"],
        "fatherName": iterable["fatherName"],
        "Action": iterable["Action"],
      });
    }
    return tempsPatient;
  }

  Future<void> onSelectDoctorValue() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        DoctorResponseList doctorResponseList = await doctorService
            .getDoctors(context.read<TokenProvider>().tokenSample.jwtToken);
        if (doctorResponseList != null) {
          if (doctorResponseList.isSuccess) {
            listDoctor = doctorResponseList.data;
            listDoctor.insert(
                0,
                DoctorSample(
                    id: -2,
                    user:
                        UserSample(firstName: 'Select', lastName: ' Doctor')));
            setState(() {
              doctorSampleDropDown = listDoctor[0];
              hasDoctors = true;
            });
          }
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  Future<void> onSelectReceptionistValue() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        ReceptionistResponseList receptionistResponseList =
            await receptionistService.getReceptionists(
                context.read<TokenProvider>().tokenSample.jwtToken);
        if (receptionistResponseList != null) {
          if (receptionistResponseList.isSuccess) {
            listReceptionist = receptionistResponseList.data;
            listReceptionist.insert(
                0,
                ReceptionistSample(
                    id: -2,
                    user: UserSample(
                        firstName: 'Select', lastName: ' Receptionist')));
            setState(() {
              receptionistSampleDropDown = listReceptionist[0];
              hasReceptionist = true;
            });
          }
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }
}
