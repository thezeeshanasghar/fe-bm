import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Service/NurseService.dart';
import 'package:baby_doctor/ShareArguments/NurseArguments.dart';
import 'package:flutter/material.dart';
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
  //List<NurseData> listNurses;

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
   // listNurses = [];
    showSearchedList = false;

    nurseService = NurseService();
  }

  void getNursesFromApiAndLinkToTable() async {
    setState(() => nurseIsLoading = true);
   // listNurses = [];
    nurseIsSource = [];

    // Nurse nurseResponse = await nurseService.getNurse();
    // listNurses = nurseResponse.data;
    // nurseIsSource.addAll(generateNurseDataFromApi(listNurses));
    setState(() => nurseIsLoading = false);
  }

  // List<Map<String, dynamic>> generateNurseDataFromApi(
  //     List<NurseData> listOfNurses) {
  //   List<Map<String, dynamic>> tempsnurse = [];
  //   for (NurseData nurses in listOfNurses) {
  //     tempsnurse.add({
  //       "Id": nurses.id,
  //       "firstName": nurses.employee.firstName,
  //       "lastName": nurses.employee.lastName,
  //       "fatherHusbandName": nurses.employee.fatherHusbandName,
  //       "contact": nurses.employee.contact,
  //       "emergencyContactNumber": nurses.employee.emergencyContact,
  //       "gender": nurses.employee.gender,
  //       "email": nurses.employee.email,
  //       "experience": nurses.employee.experience,
  //       "employeeId": nurses.employee.id,
  //       "CNIC": nurses.employee.CNIC,
  //       "DutyDuration": nurses.DutyDuration,
  //       "address": nurses.employee.address,
  //       "joiningDate": nurses.employee.joiningDate.substring(0, 10),
  //       "DutyDuration": nurses.DutyDuration,
  //       "Salary": nurses.Salary,
  //       "ProcedureShare": nurses.SharePercentage,
  //       "Action": nurses.id,
  //     });
  //   }
  //   return tempsnurse;
  // }

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
          value: "Id",
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
          value: "joiningDate",
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
    Navigator.pushNamed(context, Strings.routeEditNurse,
        arguments: NurseArguments(
            id:Id,
            DutyDuration: row['DutyDuration'],
            SharePercentage: row['ProcedureShare'],
            Salary: row['Salary'],
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
        // nurseService.DeleteNurse(Id).then((response) async {
        //   if (response == true) {
        //     await sfpd.hide();
        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //         backgroundColor: Shade.snackGlobalSuccess,
        //         content: Row(
        //           children: [
        //             Text('Success: Deleted Nurse '),
        //             Text(
        //               row['firstName'],
        //               style: TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //           ],
        //         )));
        //     getNursesFromApiAndLinkToTable();
        //   } else {
        //     await sfpd.hide();
        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //         backgroundColor: Shade.snackGlobalFailed,
        //         content: Row(
        //           children: [
        //             Text('Error: Try Again: Failed to delete Nurse '),
        //             Text(
        //               row['firstName'],
        //               style: TextStyle(fontWeight: FontWeight.bold),
        //             ),
        //           ],
        //         )));
        //   }
        // });
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
                        nurseIsSource.sort((a, b) => b["$nurseSortColumn"]
                            .compareTo(a["$nurseSortColumn"]));
                      } else {
                        nurseIsSource.sort((a, b) => a["$nurseSortColumn"]
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
                      setState(() => nurseSelecteds =
                          nurseIsSource.map((entry) => entry).toList().cast());
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
