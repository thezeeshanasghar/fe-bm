import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Doctor.dart';
import 'package:baby_doctor/Service/DoctorService.dart';
import 'package:baby_doctor/ShareArguments/DoctorArguments.dart';
import 'package:flutter/material.dart';
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
  List<Map<String, dynamic>> doctorSelecteds;
  List<DoctorData> listDoctors;

  DoctorService doctorService;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initializeDoctorHeaders();
    getDoctorsFromApiAndLinkToTable();
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
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
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
                          children: <Widget>[widgetdoctorPatients()],
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

  void initVariablesAndClasses() {
    doctorHeaders = [];
    doctorPerPage = [5, 10, 15, 100];
    doctorTotal = 100;
    doctorCurrentPerPage;
    doctorCurrentPage = 1;
    doctorIsSearch = false;
    doctorIsSource = [];
    doctorIsSearched = [];
    doctorSelecteds = [];
    doctorSelectableKey = "Invoice";
    doctorSortColumn;
    doctorSortAscending = true;
    doctorIsLoading = true;
    doctorShowSelect = false;
    listDoctors = [];
    showSearchedList = false;
    doctorService = DoctorService();
  }

  void getDoctorsFromApiAndLinkToTable() async {
    setState(() => doctorIsLoading = true);
    listDoctors = [];
    doctorIsSource = [];
    Doctor doctorResponse = await doctorService.getDoctor();
    listDoctors = doctorResponse.data;
    doctorIsSource.addAll(generateDoctorDataFromApi(listDoctors));

    setState(() => doctorIsLoading = false);
  }

  List<Map<String, dynamic>> generateDoctorDataFromApi(
      List<DoctorData> listOfDoctors) {
    List<Map<String, dynamic>> tempsdoctor = [];
    for (DoctorData doctors in listOfDoctors) {
      tempsdoctor.add({
        "id": doctors.id,
        "firstName": doctors.employee.firstName,
        "lastName": doctors.employee.lastName,
        "fatherHusbandName": doctors.employee.fatherHusbandName,
        "gender": doctors.employee.gender,
        "CNIC": doctors.employee.CNIC,
        "contact": doctors.employee.contact,
        "emergencyContactNumber": doctors.employee.emergencyContact,
        "email": doctors.employee.email,
        "address": doctors.employee.address,
        "employeeId": doctors.employee.id,
        "joiningDate": doctors.employee.joiningDate.substring(0,10),
        "experience": doctors.employee.experience,
        "SpecialityType": doctors.SpecialityType,
        "ConsultationFee": doctors.ConsultationFee,
        "EmergencyConsultationFee": doctors.EmergencyConsultationFee,
        "FeeShare": doctors.ShareInFee,
        "Action": doctors.id,
      });
    }
    return tempsdoctor;
  }

  List<Map<String, dynamic>> generateDoctorSearchData(
      Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsdoctor = [];
    for (var iterable in iterableList) {
      tempsdoctor.add({
        "Id": iterable["Id"],
        "ConsultationFee": iterable["consultationFee"],
        "EmergencyConsultationFee": iterable["emergencyConsultationFee"],
        "ShareInFee": iterable["shareInFee"],
        "SpecialityType": iterable["specialityType"],
        "Action": iterable["Action"],
      });
    }
    return tempsdoctor;
  }

  initializeDoctorHeaders() {
    doctorHeaders = [
      DatatableHeader(
          value: "Id",
          show: false,
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
                  "Father Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "CNIC",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "CNIC",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "contact",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Contact Number",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "emergencyContactNumber",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Emergency Contact Number",
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
                  "Email",
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
                  "Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "SpecialityType",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Speciality",
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
                  "Experience",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "ConsultationFee",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Consultation Fee",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "EmergencyConsultationFee",
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
          value: "FeeShare",
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
          value: "joiningDate",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "JoiningDate",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Qualification",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Qualification",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Diplomas",
          show: false,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Diplomas",
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
          sourceBuilder: (Id, row) {
            return Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    onPressedEditFromTable(Id, row);
                  },
                  child: Text('Edit',
                      style: TextStyle(
                        color: Shade.actionButtonTextEdit,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      onPressedDeleteFromTable(Id, row);
                    },
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

  void onPressedEditFromTable(Id, row) {
    print(Id);
    Navigator.pushNamed(context, Strings.routeEditDoctor,
        arguments: DoctorArguments(
            id:Id,
            ConsultationFee: row['ConsultationFee'],
            EmergencyConsultationFee: row['EmergencyConsultationFee'],
            ShareInFee: row['FeeShare'],
            SpecialityType: row['SpecialityType'],
            firstName: row['firstName'],
            employeeId: row['employeeId'],
            lastName: row['lastName'],
            fatherHusbandName: row['fatherHusbandName'],
            gender: row['gender'],
            CNIC: row['CNIC'],
            contact: row['contact'],
            emergencyContact: row['emergencyContactNumber'],
            experience: row['experience'],
            flourNo: row['flourNo'],
            password: row['password'],
            userName: row['userName'],
            joiningDate: row['joiningDate'],
            address: row['address'],
            email: row['email']));
    print(row['employeeId']);
  }

  void onPressedDeleteFromTable(Id, row) {
    Widget cancelButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
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
      onPressed: () async {
        Navigator.of(context).pop();
        sfpd = SimpleFontelicoProgressDialog(
            context: context, barrierDimisable: false);
        await sfpd.show(
            message: 'Deleting ...',
            type: SimpleFontelicoProgressDialogType.hurricane,
            width: MediaQuery.of(context).size.width - 20,
            horizontal: true);
        doctorService.DeleteDoctor(Id).then((response) async {
          if (response == true) {
            await sfpd.hide();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalSuccess,
                content: Row(
                  children: [
                    Text('Success: Deleted doctor '),
                    Text(
                      row['firstName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )));
            getDoctorsFromApiAndLinkToTable();
          } else {
            await sfpd.hide();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalFailed,
                content: Row(
                  children: [
                    Text('Error: Try Again: Failed to delete Doctor '),
                    Text(
                      row['FirstName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )));
          }
        });
      },
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

  void onChangedSearchedValue(value) {
    if (!doctorIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 2) {
          var searchList = doctorIsSource.where((element) {
            String searchById = element["Id"].toString().toLowerCase();
            String searchByName = element["Name"].toString().toLowerCase();
            String searchByPerformedBy =
                element["PerformedBy"].toString().toLowerCase();
            String searchByCharges =
                element["Charges"].toString().toLowerCase();
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
      }
    }
  }

  Widget widgetdoctorPatients() {
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
                    Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search_outlined),
                          hintText: 'Search doctor'),
                      onChanged: (value) => onChangedSearchedValue(value),
                    )),
                  ],
                  headers: doctorHeaders,
                  source: !showSearchedList ? doctorIsSource : doctorIsSearched,
                  selecteds: doctorSelecteds,
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
                        doctorIsSource.sort((a, b) => b["$doctorSortColumn"]
                            .compareTo(a["$doctorSortColumn"]));
                      } else {
                        doctorIsSource.sort((a, b) => a["$doctorSortColumn"]
                            .compareTo(b["$doctorSortColumn"]));
                      }
                    });
                  },
                  sortAscending: doctorSortAscending,
                  sortColumn: doctorSortColumn,
                  isLoading: doctorIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => doctorSelecteds.add(item));
                    } else {
                      setState(() => doctorSelecteds
                          .removeAt(doctorSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => doctorSelecteds =
                          doctorIsSource.map((entry) => entry).toList().cast());
                    } else {
                      setState(() => doctorSelecteds.clear());
                    }
                  },
                ),
              ),
            ),
          ]),
    );
  }
}
