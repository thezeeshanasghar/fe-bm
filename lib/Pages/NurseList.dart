import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Nurse.dart';
import 'package:baby_doctor/Service/NurseService.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
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

  List<DatatableHeader> nurseHeaders;
  List<int> nursePerPage;
  List<Map<String, dynamic>> nurseIsSource;
  List<Map<String, dynamic>> nurseIsSearched;
  List<Map<String, dynamic>> nurseSelecteds;
  List<Nurse> listNurses;

  NurseService nurseService;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initializenurseListHeaders();
    getNursesFromApiAndLinkToTable();
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

  void initVariablesAndClasses() {
    nurseHeaders = [];
    nursePerPage = [5, 10, 15, 100];
    nurseTotal = 100;
    nurseCurrentPerPage;
    nurseCurrentPage = 1;
    nurseIsSearch = false;
    nurseIsSource = [];
    nurseIsSearched = [];
    nurseSelecteds = [];
    nurseSelectableKey = "Invoice";
    nurseSortColumn;
    nurseSortAscending = true;
    nurseIsLoading = true;
    nurseShowSelect = false;
    listNurses = [];
    showSearchedList = false;

    nurseService = NurseService();
  }

  void getNursesFromApiAndLinkToTable() async {
    setState(() => nurseIsLoading = true);
    listNurses = [];
    nurseIsSource = [];
    listNurses = await nurseService.getNurse();
    nurseIsSource.addAll(generateNurseDataFromApi(listNurses));
    setState(() => nurseIsLoading = false);
  }

  List<Map<String, dynamic>> generateNurseDataFromApi(
      List<Nurse> listOfNurses) {
    List<Map<String, dynamic>> tempsnurse = [];
    for (Nurse nurses in listOfNurses) {
      tempsnurse.add({
        "Id": nurses.id,
        "FirstName": nurses.employee.firstName,
        "lastName": nurses.employee.lastName,
        "FatherName": nurses.employee.fatherHusbandName,
        "ContactNumber": nurses.employee.contact,
        "EmergencyContactNumber": nurses.employee.emergencyContact,
        "Gender": nurses.employee.gender,
        "CNIC": nurses.employee.CNIC,
        "DutyDuration": nurses.DutyDuration,
        "Address": nurses.employee.address,
        "JoiningDate": nurses.employee.joiningDate.substring(0,10),
        "DutyDuration": nurses.DutyDuration,
        "Salary": nurses.Salary,
        "ProcedureShare": nurses.SharePercentage,
        "Action": nurses.id,
      });
    }
    return tempsnurse;
  }

  List<Map<String, dynamic>> generateNurseSearchData(
      Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsnurse = [];
    for (var iterable in iterableList) {
      tempsnurse.add({
        "Id": iterable["Id"],
        "ConsultationFee": iterable["consultationFee"],
        "EmergencyConsultationFee": iterable["emergencyConsultationFee"],
        "ShareInFee": iterable["shareInFee"],
        "SpecialityType": iterable["specialityType"],
        "Action": iterable["Action"],
      });
    }
    return tempsnurse;
  }

  initializenurseListHeaders() {
    nurseHeaders = [
      DatatableHeader(
          value: "FirstName",
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
          value: "LastName",
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
          value: "FatherName",
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
          value: "Gender",
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
          value: "ContactNumber",
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
          value: "EmergencyContactNumber",
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
          value: "Address",
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
          value: "DutyDuration",
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
          value: "JoiningDate",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Joining Date",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "ProcedureShare",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Procedure Share",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Salary",
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
                        child: Text('Edit')),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          onPressedDeleteFromTable(Id, row);
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        )),
                  ],
                ));
          }),
    ];
  }

  void onPressedEditFromTable(Id, row) {
    print(Id);
    Navigator.pushNamed(context, Strings.routeEditNurse,arguments:{'Id': Id});
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
      onPressed: () {
        Navigator.of(context).pop();
        nurseService.DeleteNurse(Id).then((response) {
          if (response == true) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalSuccess,
                content: Row(
                  children: [
                    Text('Success: Deleted Nurse '),
                    Text(
                      row['FirstName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )));
            getNursesFromApiAndLinkToTable();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalFailed,
                content: Row(
                  children: [
                    Text('Error: Try Again: Failed to delete Nurse '),
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
            row['FirstName'] + ' ?',
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
    if (!nurseIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 2) {
          var searchList = nurseIsSource.where((element) {
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
      }
    }
  }

  Widget widgetnursePatients() {
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
                              hintText: 'Search nurse'),
                          onChanged: (value) => onChangedSearchedValue(value),
                        )),
                  ],
                  headers: nurseHeaders,
                  source: !showSearchedList
                      ? nurseIsSource
                      : nurseIsSearched,
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
                        nurseIsSource.sort((a, b) =>
                            b["$nurseSortColumn"]
                                .compareTo(a["$nurseSortColumn"]));
                      } else {
                        nurseIsSource.sort((a, b) =>
                            a["$nurseSortColumn"]
                                .compareTo(b["$nurseSortColumn"]));
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
                      setState(() => nurseSelecteds
                          .removeAt(nurseSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => nurseSelecteds = nurseIsSource
                          .map((entry) => entry)
                          .toList()
                          .cast());
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
