import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:flutter/material.dart';
import 'package:shifting_tabbar/shifting_tabbar.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'dart:math';
import 'package:baby_doctor/Service/PatientService.dart';
import 'package:baby_doctor/Models/Patient.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  bool admitted = false;
  bool walkIn = true;
  bool online = false;

  final formKey = GlobalKey<FormState>();

  // walkIn Data
  List<DatatableHeader> walkInHeaders = [];
  List<int> walkInPerPage = [5, 10, 15, 100];
  int walkInTotal = 100;
  int walkInCurrentPerPage;
  int walkInCurrentPage = 1;
  bool walkInIsSearch = false;
  List<Map<String, dynamic>> walkInIsSource = [];
  List<Map<String, dynamic>> walkInSelecteds = [];
  String walkInSelectableKey = "Invoice";
  String walkInSortColumn;
  bool walkInSortAscending = true;
  bool walkInIsLoading = true;
  bool walkInShowSelect = false;

  String dropdownDoctor = "Select Doctor";
  String dropdownDate = "Select Date";
  String dropdownBookedBy = "Select Booked By";

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
  bool onlineSortAscending = true;
  bool onlineIsLoading = true;
  bool onlineShowSelect = false;

  // Admitted Data
  List<DatatableHeader> admittedHeaders = [];
  List<int> admittedPerPage = [5, 10, 15, 100];
  int admittedTotal = 100;
  int admittedCurrentPerPage;
  int admittedCurrentPage = 1;
  bool admittedIsSearch = false;
  List<Map<String, dynamic>> admittedIsSource = [];
  List<Map<String, dynamic>> admittedSelecteds = [];
  String admittedSelectableKey = "Invoice";
  String admittedSortColumn;
  bool admittedSortAscending = true;
  bool admittedIsLoading = true;
  bool admittedShowSelect = false;
  PatientService patientService;

  // walk in
  List<Map<String, dynamic>> walkInGenerateData({int n: 100}) {
    final List source = List.filled(n, Random.secure());
    List<Map<String, dynamic>> temps = [];
    var i = walkInIsSource.length;
    print(i);
    for (var data in source) {
      temps.add({
        "Invoice": i + 1000,
        "Date": "Feb 24, 2021",
        "Name": "Syed Basit Ali Shah $i",
        "FatherName": "Father-$i",
        "DOB": "Jan 18, 1994",
        "Total": "Rs. 20",
        "Discount": "Rs. 1$i",
        "NetTotal": "Rs. 5$i",
        "Refund": "Rs. 0",
        "NewInvoice": [i, 100],
      });
      i++;
    }
    return temps;
  }

  walkInInitData() async {
    // setState(() => walkInIsLoading = true);
    // Future.delayed(Duration(seconds: 0)).then((value) {
    //   walkInIsSource.addAll(walkInGenerateData(n: 100));
    //   setState(() => walkInIsLoading = false);
    // });
    getWalkInPatientsFromApiAndLinkToTable();
  }

  void getWalkInPatientsFromApiAndLinkToTable() async {
    setState(() => walkInIsLoading = true);
    var listwalkindata = [];
    Patient patientResponse = await patientService.getPatientsInvoices('WalkIn');
    listwalkindata = patientResponse.data;
    walkInIsSource.addAll(generateWalkinPatientsDataFromApi(listwalkindata));

    setState(() => walkInIsLoading = false);
  }

  List<Map<String, dynamic>> generateWalkinPatientsDataFromApi(
      List<PatientData> listOfPatients) {
    List<Map<String, dynamic>> tempspatient = [];
    for (PatientData patient in listOfPatients) {
      tempspatient.add({
        "Id": patient.id,
        "Invoice": patient.id,
        "Name": patient.Name,
        "DOB": patient.DOB.substring(0,10),
        "PatientId": patient.PatientId,
        "FatherHusbandName": patient.FatherHusbandName,
        "Sex": patient.Sex,
        "Discount": patient.Discount,
        "NetTotal": patient.NetAmount,
        "Total": patient.NetAmount- patient.Discount,
        "Category": patient.Category,
        "appointmentId": patient.AppointmentId,
        "Action": patient.id,
      });
    }
    return tempspatient;
  }

  void getOnCallPatientsFromApiAndLinkToTable() async {
    setState(() => onlineIsLoading = true);
    var listonlineindata = [];
    Patient patientResponse = await patientService.getPatientsInvoices('Oncall');
    listonlineindata = patientResponse.data;
    onlineIsSource.addAll(generateWalkinPatientsDataFromApi(listonlineindata));
    setState(() => onlineIsLoading = false);
  }

  List<Map<String, dynamic>> generateOnCallPatientsDataFromApi(
      List<PatientData> listOfPatients) {
    List<Map<String, dynamic>> tempspatient = [];
    for (PatientData patient in listOfPatients) {
      tempspatient.add({
        "Id": patient.id,
        "Name": patient.Name,
        "DOB": patient.DOB.substring(0,10),
        "PatientId": patient.PatientId,
        "FatherHusbandName": patient.FatherHusbandName,
        "Category": patient.Category,
        "AppointmentId": patient.AppointmentId,
        "Action": patient.id,
      });

    }

    return tempspatient;
  }

  void getAdmittedPatientsFromApiAndLinkToTable() async {
    setState(() => admittedIsLoading = true);
    var listadmitteddata = [];
    Patient patientResponse = await patientService.getPatientsInvoices('Admitted');
    listadmitteddata = patientResponse.data;
    admittedIsSource.addAll(generateWalkinPatientsDataFromApi(listadmitteddata));
    setState(() => admittedIsLoading = false);
  }

  List<Map<String, dynamic>> generateAdmittedPatientsDataFromApi(
      List<PatientData> listOfPatients) {
    List<Map<String, dynamic>> tempspatient = [];
    for (PatientData patient in listOfPatients) {
      tempspatient.add({
        "Id": patient.id,
        "Name": patient.Name,
        "DOB": patient.DOB.substring(0,10),
        "PatientId": patient.PatientId,
        "FatherHusbandName": patient.FatherHusbandName,
        "AppointmentId": patient.AppointmentId,
        "Action": patient.id,
      });
    }
    return tempspatient;
  }

  initializeWalkInHeaders() {
    walkInHeaders = [
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
          value: "Date",
          show: false,
          sortable: true,
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
          value: "Name",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "FatherHusbandName",
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
          value: "DOB",
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
          value: "Total",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Discount",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Discount",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "NetTotal",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Net Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Refund",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Refund",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Details",
          show: true,
          //flex: 3,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          sourceBuilder: (value, row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => NewInvoice()),
                      // );
                    },
                    child: Text('View')),
                SizedBox(
                  width: 5,
                ),

              ],
            );
          }),
    ];
  }

  // online
  List<Map<String, dynamic>> onlineGenerateData({int n: 100}) {
    final List sourceOnline = List.filled(n, Random.secure());
    List<Map<String, dynamic>> tempsOnline = [];
    var i = onlineIsSource.length;
    print(i);
    for (var data in sourceOnline) {
      tempsOnline.add({
        "Date": "Feb 24, 2021",
        "PatientName": "Syed Basit Ali Shah $i",
        "FatherName": "Syed Basit Ali Shah $i",
        "DOB": "Jan 19, 1994",
        "CheckupType": "Pediatrician",
        "BookingNo": "GH-0167$i",
        "Action": [i, 100],
      });
      i++;
    }
    return tempsOnline;
  }

  onlineInitData() async {
    // setState(() => onlineIsLoading = true);
    // Future.delayed(Duration(seconds: 0)).then((value) {
    //   onlineIsSource.addAll(onlineGenerateData(n: 100));
    //   setState(() => onlineIsLoading = false);
    // });
    getOnCallPatientsFromApiAndLinkToTable();
  }

  initializeOnlineHeaders() {
    onlineHeaders = [
      DatatableHeader(
          value: "Date",
          show: false,
          sortable: true,
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
          value: "Name",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Patient Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "FatherHusbandName",
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
          value: "appointmentId",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Appointment Id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "DOB",
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
          value: "Category",
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
          value: "Action",
          show: true,
          flex: 1,
          sortable: true,
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
          sourceBuilder: (value, row) {
            return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => NewInvoice()),
                          // );
                        },
                        child: Text('view')),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ));
          }),
    ];
  }

  // admitted
  List<Map<String, dynamic>> admittedGenerateData({int n: 100}) {
    final List sourceAdmitted = List.filled(n, Random.secure());
    List<Map<String, dynamic>> tempsAdmitted = [];
    var i = admittedIsSource.length;
    print(i);
    for (var data in sourceAdmitted) {
      tempsAdmitted.add({
        "Date": "Feb 24, 2021",
        "PatientName": "Syed Basit Ali Shah $i",
        "FatherName": "Syed Basit Ali Shah $i",
        "DOB": "Jan 19, 1994",
        "CheckupType": "Pediatrician",
        "BookingNo": "GH-0167$i",
        "Action": [i, 100],
      });
      i++;
    }
    return tempsAdmitted;
  }

  admittedInitData() async {
    // setState(() => admittedIsLoading = true);
    // Future.delayed(Duration(seconds: 0)).then((value) {
    //   admittedIsSource.addAll(onlineGenerateData(n: 100));
    //   setState(() => admittedIsLoading = false);
    // });
    getAdmittedPatientsFromApiAndLinkToTable();
  }

  initializeAdmittedHeaders() {
    admittedHeaders = [
      DatatableHeader(
          value: "Date",
          show: false,
          sortable: true,
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
          value: "Name",
          show: true,
          flex: 2,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Patient Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "FatherHusbandName",
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
          value: "DOB",
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
          value: "CheckupType",
          show: false,
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
          value: "AppointmentId",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Appointment No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Action",
          show: true,
          flex: 2,
          sortable: true,
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
          sourceBuilder: (value, row) {
            return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => NewInvoice()),
                          // );
                        },
                        child: Text('View')),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ));
          }),
    ];
  }

  @override
  void initState() {
    super.initState();
    patientService = PatientService();
    // walk in
    initializeWalkInHeaders();
    walkInInitData();

    // online
    initializeOnlineHeaders();
    onlineInitData();

    // admitted
    initializeAdmittedHeaders();
    admittedInitData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
   Widget build(BuildContext context )  {

    return MaterialApp(
      // Define a controller for TabBar and TabBarViews
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          // Use ShiftingTabBar instead of appBar
          appBar: ShiftingTabBar(
            color: Colors.blueGrey,
            labelStyle: TextStyle(color: Colors.white70),
            tabs: <ShiftingTab>[
              // Also you should use ShiftingTab widget instead of Tab widget to get shifting animation
              ShiftingTab(
                icon: const Icon(
                  Icons.directions_walk_sharp,
                  color: Colors.white70,
                ),
                text: 'Walk-In',
              ),
              ShiftingTab(
                icon: const Icon(
                  Icons.call,
                  color: Colors.white70,
                ),
                text: 'On Call',
              ),
              ShiftingTab(
                icon: const Icon(
                  Icons.online_prediction,
                  color: Colors.white70,
                ),
                text: 'Online',
              ),
            ],
          ),

          body: TabBarView(
            children: <Widget>[
              widgetWalkInPatients(),
              widgetOnlinePatients(),
              widgetAdmittedPatients(),
            ],
          ),
        ),
      ),
    );

  }

  String TableType = 'Walk-in Patients';
  Widget widgetWalkInPatients() {
    return SingleChildScrollView(
      child: Card(
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
                  color: Colors.grey[50],
                  child: Row(
                    children: [
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
                                //       'Doctor',
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
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropdownDoctor,
                                        elevation: 16,
                                        underline: Container(
                                          height: 0,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownDoctor = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Select Doctor',
                                          'Dr. Salman',
                                          'Dr. Faisal',
                                          'Dr. Nawaz',
                                          'Dr. Sadia'
                                        ].map<DropdownMenuItem<String>>(
                                                (String value) {
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
                                //       'Date',
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
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropdownDate,
                                        elevation: 16,
                                        underline: Container(
                                          height: 0,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownDate = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Select Date',
                                          'All',
                                        ].map<DropdownMenuItem<String>>(
                                                (String value) {
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
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: dropdownBookedBy,
                                        elevation: 16,
                                        underline: Container(
                                          height: 0,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownBookedBy = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Select Booked By',
                                          'All',
                                        ].map<DropdownMenuItem<String>>(
                                                (String value) {
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
                    title: !walkInIsSearch
                        ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.directions_walk_sharp),
                        ),
                        Text(
                          'Walk-in (Out Patients)',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                        : null,
                    actions: [
                      if (walkInIsSearch)
                        Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                      icon: Icon(Icons.cancel),
                                      onPressed: () {
                                        setState(() {
                                          walkInIsSearch = false;
                                        });
                                      }),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.search), onPressed: () {})),
                            )),
                      if (!walkInIsSearch)
                        IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                walkInIsSearch = true;
                              });
                            })
                    ],
                    headers: walkInHeaders,
                    source: walkInIsSource,
                    selecteds: walkInSelecteds,
                    showSelect: walkInShowSelect,
                    autoHeight: false,
                    onTabRow: (data) {
                      // print(data);
                    },
                    onSort: (value) {
                      setState(() {
                        walkInSortColumn = value;
                        walkInSortAscending = !walkInSortAscending;
                        if (walkInSortAscending) {
                          walkInIsSource.sort((a, b) => b["$walkInSortColumn"]
                              .compareTo(a["$walkInSortColumn"]));
                        } else {
                          walkInIsSource.sort((a, b) => a["$walkInSortColumn"]
                              .compareTo(b["$walkInSortColumn"]));
                        }
                      });
                    },
                    sortAscending: walkInSortAscending,
                    sortColumn: walkInSortColumn,
                    isLoading: walkInIsLoading,
                    onSelect: (value, item) {
                      print("$value  $item ");
                      if (value) {
                        setState(() => walkInSelecteds.add(item));
                      } else {
                        setState(() => walkInSelecteds
                            .removeAt(walkInSelecteds.indexOf(item)));
                      }
                    },
                    onSelectAll: (value) {
                      if (value) {
                        setState(() => walkInSelecteds =
                            walkInIsSource.map((entry) => entry).toList().cast());
                      } else {
                        setState(() => walkInSelecteds.clear());
                      }
                    },
                    footers: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Rows per page:"),
                      ),
                      if (walkInPerPage != null)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButton(
                              value: walkInCurrentPerPage,
                              items: walkInPerPage
                                  .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  walkInCurrentPerPage = value;
                                });
                              }),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                            "$walkInCurrentPage - $walkInCurrentPerPage of $walkInTotal"),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        onPressed: () {
                          setState(() {
                            walkInCurrentPage = walkInCurrentPage >= 2
                                ? walkInCurrentPage - 1
                                : 1;
                          });
                        },
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios, size: 16),
                        onPressed: () {
                          setState(() {
                            walkInCurrentPage++;
                          });
                        },
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget widgetOnlinePatients() {
    return SingleChildScrollView(
      child: Card(
        elevation: 1,
        shadowColor: Colors.black,
        clipBehavior: Clip.none,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
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
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.search), onPressed: () {})),
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
                      print("$value  $item ");
                      if (value) {
                        setState(() => onlineSelecteds.add(item));
                      } else {
                        setState(() => onlineSelecteds
                            .removeAt(onlineSelecteds.indexOf(item)));
                      }
                    },
                    onSelectAll: (value) {
                      if (value) {
                        setState(() => onlineSelecteds =
                            onlineIsSource.map((entry) => entry).toList().cast());
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
                        child: Text(
                            "$onlineCurrentPage - $onlineCurrentPerPage of $onlineTotal"),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        onPressed: () {
                          setState(() {
                            onlineCurrentPage = onlineCurrentPage >= 2
                                ? onlineCurrentPage - 1
                                : 1;
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
      ),
    );
  }

  Widget widgetAdmittedPatients() {
    return SingleChildScrollView(
      child: Card(
        elevation: 1,
        shadowColor: Colors.black,
        clipBehavior: Clip.none,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(0),
                constraints: BoxConstraints(
                  maxHeight: 500,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ResponsiveDatatable(
                    title: !admittedIsSearch
                        ? Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.king_bed),
                        ),
                        Text(
                          "Admitted",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                        : null,
                    actions: [
                      if (admittedIsSearch)
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
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.search), onPressed: () {})),
                            )),
                      if (!admittedIsSearch)
                        IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                admittedIsSearch = true;
                              });
                            })
                    ],
                    headers: admittedHeaders,
                    source: admittedIsSource,
                    selecteds: admittedSelecteds,
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
                      print("$value  $item ");
                      if (value) {
                        setState(() => admittedSelecteds.add(item));
                      } else {
                        setState(() => admittedSelecteds
                            .removeAt(admittedSelecteds.indexOf(item)));
                      }
                    },
                    onSelectAll: (value) {
                      if (value) {
                        setState(() => admittedSelecteds = admittedIsSource
                            .map((entry) => entry)
                            .toList()
                            .cast());
                      } else {
                        setState(() => admittedSelecteds.clear());
                      }
                    },
                    footers: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Rows per page:"),
                      ),
                      if (admittedPerPage != null)
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: DropdownButton(
                              value: admittedCurrentPerPage,
                              items: admittedPerPage
                                  .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  admittedCurrentPerPage = value;
                                });
                              }),
                        ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                            "$admittedCurrentPage - $admittedCurrentPerPage of $admittedTotal"),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 16,
                        ),
                        onPressed: () {
                          setState(() {
                            admittedCurrentPage = admittedCurrentPage >= 2
                                ? admittedCurrentPage - 1
                                : 1;
                          });
                        },
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward_ios, size: 16),
                        onPressed: () {
                          setState(() {
                            admittedCurrentPage++;
                          });
                        },
                        padding: EdgeInsets.symmetric(horizontal: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: Shade.globalBackgroundColor,
  //       appBar: AppBar(
  //         title: Text(Strings.titlePatientList),
  //         centerTitle: false,
  //         backgroundColor: Shade.globalAppBarColor,
  //         elevation: 0.0,
  //       ),
  //       body: PatientsTabController());
  // }
}

class PatientsTabController extends StatefulWidget {
  const PatientsTabController({Key key}) : super(key: key);

  @override
  _PatientsTabControllerState createState() => _PatientsTabControllerState();
}

class _PatientsTabControllerState extends State<PatientsTabController> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define a controller for TabBar and TabBarViews
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          // Use ShiftingTabBar instead of appBar
          appBar: ShiftingTabBar(
            color: Colors.blueGrey,
            labelStyle: TextStyle(color: Colors.white70),
            tabs: <ShiftingTab>[
              // Also you should use ShiftingTab widget instead of Tab widget to get shifting animation
              ShiftingTab(
                icon: const Icon(
                  Icons.airline_seat_flat,
                  color: Colors.white70,
                ),
                text: 'Admitted',
              ),
              ShiftingTab(
                icon: const Icon(
                  Icons.call,
                  color: Colors.white70,
                ),
                text: 'On Call',
              ),
              ShiftingTab(
                icon: const Icon(
                  Icons.bedtime_sharp,
                  color: Colors.white70,
                ),
                text: 'Admitted',
              ),
            ],
          ),

          body: const TabBarView(
            children: <Widget>[
              Icon(Icons.home),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_car),
            ],
          ),
        ),
      ),
    );
  }
}