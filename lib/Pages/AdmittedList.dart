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
import 'package:baby_doctor/Models/Sample/PatientSample.dart';
import 'package:baby_doctor/Models/Sample/ReceptionistSample.dart';
import 'package:baby_doctor/Models/Sample/UserSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/AppointmentService.dart';
import 'package:baby_doctor/Service/DoctorService.dart';
import 'package:baby_doctor/Service/ReceptionistService.dart';
import 'package:baby_doctor/constants/QEnum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baby_doctor/Service/PatientService.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

class AdmittedList extends StatefulWidget {
  @override
  _AdmittedListState createState() => _AdmittedListState();
}

class _AdmittedListState extends State<AdmittedList> {
  final formKey = GlobalKey<FormState>();
  AppointmentService appointmentService;
  bool room = true;
  bool er = false;

  // admitted Data
  List<DatatableHeader> admittedHeaders = [];
  List<int> admittedPerPage = [5, 10, 15, 100];
  int admittedTotal = 100;
  int admittedCurrentPerPage;
  int admittedCurrentPage = 1;
  bool admittedIsSearch = false;
  List<Map<String, dynamic>> admittedIsSource = [];
  List<Map<String, dynamic>> admittedSelected = [];
  String admittedSelectableKey = "Invoice";
  String admittedSortColumn;
  String admittedId;
  List<AppointmentSample> listAdmitted;
  List<DoctorSample> listDoctor;
  List<ReceptionistSample> listReceptionist;
  bool admittedSortAscending = true;
  bool admittedIsLoading = true;
  bool admittedShowSelect = false;
  bool showSearchedList;
  bool admittedShowpatientIsSearchedSelect;
  List<Map<String, dynamic>> admittedIsSearched;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;
  DoctorSample doctorSampleDropDown = DoctorSample(id: -1);
  ReceptionistSample receptionistSampleDropDown = ReceptionistSample(id: -1);
  bool hasDoctors = false;
  bool hasReceptionist = false;
  final _tecFromDate = TextEditingController();
  final _tecToDate = TextEditingController();
  DoctorService doctorService;
  ReceptionistService receptionistService;

  @override
  void initState() {
    super.initState();
    appointmentService = AppointmentService();
    doctorService = DoctorService();
    receptionistService = ReceptionistService();
    initAdmittedPatientVariablesAndClasses();
    initializeAdmittedPatientHeaders();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      onSelectDoctorValue();
      onSelectReceptionistValue();
      checkTokenValidityAndGetAdmittedPatients();
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
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleAdmittedList),
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
                          widgetTableType(),
                          widgetAdmittedPatients(),
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

  void initAdmittedPatientVariablesAndClasses() {
    admittedHeaders = [];
    admittedPerPage = [5, 10, 15, 100];
    admittedTotal = 100;
    admittedCurrentPerPage;
    admittedCurrentPage = 1;
    admittedIsSearch = false;
    admittedIsSource = [];
    admittedSelected = [];
    admittedSelectableKey = "Invoice";
    admittedSortColumn;
    admittedSortAscending = true;
    admittedIsLoading = true;
    admittedShowSelect = false;
    showSearchedList = false;
    appointmentService = AppointmentService();
  }

  void initializeAdmittedPatientHeaders() {
    admittedHeaders = [
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
                  onPressed: () {},
                  child: Text('Edit',
                      style: TextStyle(
                        color: Shade.actionButtonTextEdit,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {},
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

  Widget widgetAdmittedPatients() {
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
                  headers: admittedHeaders,
                  source:
                      !showSearchedList ? admittedIsSource : admittedIsSearched,
                  selecteds: admittedSelected,
                  showSelect: admittedShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    // print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      admittedSortColumn = value;
                      admittedSortAscending = !admittedSortAscending;
                      if (admittedSortAscending) {
                        admittedIsSource.sort((a, b) => b["$admittedSortColumn"]
                            .compareTo(a["$admittedSortColumn"]));
                      } else {
                        admittedIsSource.sort((a, b) => a["$admittedSortColumn"]
                            .compareTo(b["$admittedSortColumn"]));
                      }
                    });
                  },
                  sortAscending: admittedSortAscending,
                  sortColumn: admittedSortColumn,
                  isLoading: admittedIsLoading,
                  onSelect: (value, item) {
                    if (value) {
                      setState(() => admittedSelected.add(item));
                    } else {
                      setState(() => admittedSelected
                          .removeAt(admittedSelected.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => admittedSelected = admittedIsSource
                          .map((entry) => entry)
                          .toList()
                          .cast());
                    } else {
                      setState(() => admittedSelected.clear());
                    }
                  },
                ),
              ),
            ),
          ]),
    );
  }

  Future<void> checkTokenValidityAndGetAdmittedPatients() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        getAdmittedPatientFromApiAndLinkToTable();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  void getAdmittedPatientFromApiAndLinkToTable() async {
    setState(() => admittedIsLoading = true);
    listAdmitted = [];
    admittedIsSource = [];
    try {
      AppointmentResponseList roomList =
          await appointmentService.getPatientAppointmentsByCategory(
              context.read<TokenProvider>().tokenSample.jwtToken, 'Admitted');
      if (roomList != null) {
        if (roomList.isSuccess) {
          listAdmitted = roomList.data;
          admittedIsSource
              .addAll(generateAdmittedPatientDataFromApi(listAdmitted));
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              Shade.snackGlobalFailed, roomList.message, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorNull, context);
      }
      setState(() => admittedIsLoading = false);
    } catch (exception) {
      setState(() => admittedIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generateAdmittedPatientDataFromApi(
      List<AppointmentSample> listAdmittedPatient) {
    List<Map<String, dynamic>> tempspatient = [];
    for (AppointmentSample appointmentSample in listAdmittedPatient) {
      tempspatient.add({
        "id": appointmentSample.id,
        "patientId": appointmentSample.patientId,
        "doctorId": appointmentSample.doctorId,
        "receptionistId": appointmentSample.receptionistId,
        "code": appointmentSample.code,
        "date": appointmentSample.date,
        "consultationDate": appointmentSample.consultationDate,
        "type": appointmentSample.type,
        "patientCategory": appointmentSample.patientCategory,
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
    return tempspatient;
  }

  Future<void> onChangedSearchedValue(String search) async {
    if (!admittedIsLoading) {
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
                  category: "admitted",
                  doctor: doctorSampleDropDown.id.toString(),
                  dateFrom: '2021-09-07',
                  dateTo: '2021-09-30',
                  booked: receptionistSampleDropDown.id.toString(),
                  searchFrom: x,
                ),
                context.read<TokenProvider>().tokenSample.jwtToken);
        if (serviceResponse != null) {
          if (serviceResponse.isSuccess) {
            admittedIsSource = [];
            listAdmitted = [];
            listAdmitted = serviceResponse.data;
            admittedIsSource
                .addAll(generateAdmittedPatientDataFromApi(listAdmitted));
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

  String TableType = 'room';

  Widget widgetTableType() {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
            child: Column(
              children: <Widget>[
                Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'Choose Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RadioListTile(
                        title: const Text('Room'),
                        value: "room",
                        groupValue: TableType,
                        onChanged: (String value) {
                          setState(() {
                            TableType = value;
                            room = true;
                            er = false;
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: const Text('ER'),
                        value: "er",
                        groupValue: TableType,
                        onChanged: (String value) {
                          setState(() {
                            TableType = value;
                            room = false;
                            er = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
