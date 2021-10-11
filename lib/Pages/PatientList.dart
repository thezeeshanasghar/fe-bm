import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Responses/PatientResponse.dart';
import 'package:baby_doctor/Models/Sample/PatientSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baby_doctor/Service/PatientService.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  final formKey = GlobalKey<FormState>();
  PatientService patientService;

  // patient Data
  List<DatatableHeader> patientHeaders = [];
  List<int> patientPerPage = [5, 10, 15, 100];
  int patientTotal = 100;
  int patientCurrentPerPage;
  int patientCurrentPage = 1;
  bool patientIsSearch = false;
  List<Map<String, dynamic>> patientIsSource = [];
  List<Map<String, dynamic>> patientSelected = [];
  String patientSelectableKey = "Invoice";
  String patientSortColumn;
  String PatientId;
  List<PatientSample> listPatient;
  bool patientSortAscending = true;
  bool patientIsLoading = true;
  bool patientShowSelect = false;
  bool showSearchedList;
  bool patientShowpatientIsSearchedSelect;
  List<Map<String, dynamic>> patientIsSearched;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;

  @override
  void initState() {
    super.initState();
    patientService = PatientService();
    initPatientVariablesAndClasses();
    initializePatientHeaders();
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
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titlePatientList),
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
                          widgetPatients(),
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

  void initPatientVariablesAndClasses() {
    patientHeaders = [];
    patientPerPage = [5, 10, 15, 100];
    patientTotal = 100;
    patientCurrentPerPage;
    patientCurrentPage = 1;
    patientIsSearch = false;
    patientIsSource = [];
    patientSelected = [];
    patientSelectableKey = "Invoice";
    patientSortColumn;
    patientSortAscending = true;
    patientIsLoading = true;
    patientShowSelect = false;
    showSearchedList = false;
    patientService = PatientService();
  }

  void initializePatientHeaders() {
    patientHeaders = [
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
          show: true,
          flex: 1,
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
          value: "fatherName",
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
          value: "type",
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
          value: "category",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Category",
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

  Widget widgetPatients() {
    return Card(
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
                  actions: [
                    widgetSearch(),
                  ],
                  headers: patientHeaders,
                  source:
                      !showSearchedList ? patientIsSource : patientIsSearched,
                  selecteds: patientSelected,
                  showSelect: patientShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    // print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      patientSortColumn = value;
                      patientSortAscending = !patientSortAscending;
                      if (patientSortAscending) {
                        patientIsSource.sort((a, b) => b["$patientSortColumn"]
                            .compareTo(a["$patientSortColumn"]));
                      } else {
                        patientIsSource.sort((a, b) => a["$patientSortColumn"]
                            .compareTo(b["$patientSortColumn"]));
                      }
                    });
                  },
                  sortAscending: patientSortAscending,
                  sortColumn: patientSortColumn,
                  isLoading: patientIsLoading,
                  onSelect: (value, item) {
                    // print("$value  $item ");
                    if (value) {
                      setState(() => patientSelected.add(item));
                    } else {
                      setState(() => patientSelected
                          .removeAt(patientSelected.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => patientSelected = patientIsSource
                          .map((entry) => entry)
                          .toList()
                          .cast());
                    } else {
                      setState(() => patientSelected.clear());
                    }
                  },
                ),
              ),
            ),
          ]),
    );
  }

  Future<void> checkTokenValidityAndGetPatients() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        getPatientFromApiAndLinkToTable();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  void getPatientFromApiAndLinkToTable() async {
    setState(() => patientIsLoading = true);
    listPatient = [];
    patientIsSource = [];
    try {
      PatientResponseList walkInList = await patientService
          .getPatients(context.read<TokenProvider>().tokenSample.jwtToken);
      if (walkInList != null) {
        if (walkInList.isSuccess) {
          listPatient = walkInList.data;
          patientIsSource.addAll(generatePatientDataFromApi(listPatient));
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              Shade.snackGlobalFailed, walkInList.message, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorNull, context);
      }
      setState(() => patientIsLoading = false);
    } catch (exception) {
      setState(() => patientIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generatePatientDataFromApi(
      List<PatientSample> listPatient) {
    List<Map<String, dynamic>> tempspatient = [];
    for (PatientSample patientsample in listPatient) {
      tempspatient.add({
        "Invoice": patientsample.id,
        "id": patientsample.id,
        "userId": patientsample.userId,
        "birthPlace": patientsample.birthPlace,
        "type": patientsample.type,
        "externalId": patientsample.externalId,
        "bloodGroup": patientsample.bloodGroup,
        "clinicSite": patientsample.clinicSite,
        "referredBy": patientsample.referredBy,
        "referredDate": patientsample.referredDate,
        "guardian": patientsample.guardian,
        "paymentProfile": patientsample.paymentProfile,
        "description": patientsample.description,
        "userType": patientsample.user.userType,
        "firstName": patientsample.user.firstName,
        "lastName": patientsample.user.lastName,
        "fatherName": patientsample.user.fatherHusbandName,
        "dateOfBirth":
            patientsample.user.dateOfBirth.toString().substring(0, 10),
        "contact": patientsample.user.contact,
        "email": patientsample.user.email,
        "Action": patientsample.id,
      });
    }
    return tempspatient;
  }

  Future<void> onChangedSearchedValue(String search) async {
    if (!patientIsLoading) {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        if (search.isEmpty) {
          getPatientFromApiAndLinkToTable();
          return;
        }
        PatientResponseList patientResponse =
            await patientService.getPatientBySearch(
                context.read<TokenProvider>().tokenSample.jwtToken, search);
        if (patientResponse != null) {
          if (patientResponse.isSuccess) {
            patientIsSource = [];
            listPatient = [];
            listPatient = patientResponse.data;
            patientIsSource.addAll(generatePatientDataFromApi(listPatient));
            setState(() {
              showSearchedList = false;
            });
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
}
