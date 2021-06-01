import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Employee.dart';
import 'package:baby_doctor/Service/ReceptionistService.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

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
  List<Map<String, dynamic>> receptionistSelecteds;
  List<Employee> listReceptionists;

  ReceptionistService receptionistService;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initHeadersOfReceptionistTable();
    getReceptionistsFromApiAndLinkToTable();
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
                          children: <Widget>[widgetreceptionistPatients()],
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
            Navigator.pushNamed(context, Strings.routeEditReceptionist);
          },
          child: const Icon(Icons.add),
          backgroundColor: Shade.fabGlobalButtonColor,
        ));
  }

  void initVariablesAndClasses() {
    receptionistHeaders = [];
    receptionistPerPage = [5, 10, 15, 100];
    receptionistTotal = 100;
    receptionistCurrentPerPage;
    receptionistCurrentPage = 1;
    receptionistIsSearch = false;
    receptionistIsSource = [];
    receptionistIsSearched = [];
    receptionistSelecteds = [];
    receptionistSelectableKey = "Invoice";
    receptionistSortColumn;
    receptionistSortAscending = true;
    receptionistIsLoading = true;
    receptionistShowSelect = false;
    listReceptionists = [];
    showSearchedList = false;

    receptionistService = ReceptionistService();
  }

  void getReceptionistsFromApiAndLinkToTable() async {
    setState(() => receptionistIsLoading = true);
    listReceptionists = [];
    receptionistIsSource = [];
    listReceptionists = await receptionistService.getReceptionist();
    receptionistIsSource.addAll(generateReceptionistDataFromApi(listReceptionists));
    setState(() => receptionistIsLoading = false);
  }

  List<Map<String, dynamic>> generateReceptionistDataFromApi(
      List<Employee> listOfReceptionists) {
    List<Map<String, dynamic>> tempsreceptionist = [];
    for (Employee receptionists in listOfReceptionists) {
      tempsreceptionist.add({
        "Id": receptionists.id,
        "FirstName": receptionists.firstName,
        "LastName":  receptionists.lastName,
        "Gender":  receptionists.gender,
        // "DOB": receptionists.DOB,
        "CNIC": receptionists.CNIC,
        "ContactNumber":  receptionists.contact,
        "Email":  receptionists.email,
        "Address": receptionists.address,
        "FloorNo": receptionists.flourNo,
        "JoiningDate":  receptionists.joiningDate.substring(0,10),
        "Action": receptionists.id,
      });
    }
    return tempsreceptionist;
  }

  List<Map<String, dynamic>> generateReceptionistSearchData(
      Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsreceptionist = [];
    for (var iterable in iterableList) {
      tempsreceptionist.add({
        "Id": iterable["Id"],
        "FirstName": iterable["FirstName"],
        "LastName": iterable["LastName"],
        "CNIC": iterable["CNIC"],
        "Email": iterable["Email"],
        "ContactNumber": iterable["ContactNumber"],
        "Action": iterable["Action"],
      });
    }
    return tempsreceptionist;
  }

  void initHeadersOfReceptionistTable() {
    receptionistHeaders = [
      DatatableHeader(
          value: "Id",
          show: true,
          flex: 1,
          sortable: false,
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
          value: "FirstName",
          show: true,
          flex: 2,
          sortable: false,
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
          sortable: false,
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
          value: "Email",
          show: true,
          sortable: false,
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
          value: "Address",
          show: false,
          sortable: false,
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
          value: "CNIC",
          show: false,
          sortable: false,
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
          value: "EmergencyContact",
          show: false,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Emergency Contact",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Contact",
          show: false,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Contact",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "FlourNo",
          show: false,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Flour No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "FlourNo",
          show: false,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Flour No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "FlourNo",
          show: false,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Flour No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Gender",
          show: true,
          sortable: false,
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
          value: "JoiningDate",
          show: true,
          sortable: false,
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
    Navigator.pushNamed(context, Strings.routeEditReceptionist,arguments:{'Id': Id});
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
        receptionistService.DeleteReceptionist(Id).then((response) {
          if (response == true) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalSuccess,
                content: Row(
                  children: [
                    Text('Success: Deleted Receptionist '),
                    Text(
                      row['FirstName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )));
            getReceptionistsFromApiAndLinkToTable();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalFailed,
                content: Row(
                  children: [
                    Text('Error: Try Again: Failed to delete Receptionist '),
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
    if (!receptionistIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 2) {
          var searchList = receptionistIsSource.where((element) {
            String searchById = element["Id"].toString().toLowerCase();
            String searchByFirstName= element["FirstName"].toString().toLowerCase();
            String searchByLastName = element["LastName"].toString().toLowerCase();
            String searchByEmail = element["Email"].toString().toLowerCase();
            String searchByContactNumber = element["ContactNumber"].toString().toLowerCase();
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

  Widget widgetreceptionistPatients() {
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
                              hintText: 'Search receptionist'),
                          onChanged: (value) => onChangedSearchedValue(value),
                        )),
                  ],
                  headers: receptionistHeaders,
                  source: !showSearchedList
                      ? receptionistIsSource
                      : receptionistIsSearched,
                  selecteds: receptionistSelecteds,
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
                        receptionistIsSource.sort((a, b) =>
                            b["$receptionistSortColumn"]
                                .compareTo(a["$receptionistSortColumn"]));
                      } else {
                        receptionistIsSource.sort((a, b) =>
                            a["$receptionistSortColumn"]
                                .compareTo(b["$receptionistSortColumn"]));
                      }
                    });
                  },
                  sortAscending: receptionistSortAscending,
                  sortColumn: receptionistSortColumn,
                  isLoading: receptionistIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => receptionistSelecteds.add(item));
                    } else {
                      setState(() => receptionistSelecteds
                          .removeAt(receptionistSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => receptionistSelecteds = receptionistIsSource
                          .map((entry) => entry)
                          .toList()
                          .cast());
                    } else {
                      setState(() => receptionistSelecteds.clear());
                    }
                  },
                ),
              ),
            ),
          ]),
    );
  }
}
