import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Procedures.dart';
import 'package:baby_doctor/Service/ProcedureService.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ProcedureList extends StatefulWidget {
  @override
  _ProcedureListState createState() => _ProcedureListState();
}

class _ProcedureListState extends State<ProcedureList> {
  final formKey = GlobalKey<FormState>();

  int procedureTotal;
  int procedureCurrentPerPage;
  int procedureCurrentPage;
  bool procedureIsSearch;
  String procedureSelectableKey;
  String procedureSortColumn;
  bool procedureSortAscending;
  bool procedureIsLoading;
  bool procedureShowSelect;
  bool showSearchedList;

  List<DatatableHeader> procedureHeaders;
  List<int> procedurePerPage;
  List<Map<String, dynamic>> procedureIsSource;
  List<Map<String, dynamic>> procedureIsSearched;
  List<Map<String, dynamic>> procedureSelecteds;
  List<Procedures> listProcedures;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initHeadersOfProcedureTable();
    getProceduresFromApiAndLinkToTable();
  }

  @override
  void dispose() {
    super.dispose();
    initVariablesAndClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Shade.globalBackgroundColor,
        appBar: AppBar(
          title: Text(Strings.titleProcedureList),
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
                          children: <Widget>[widgetprocedurePatients()],
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
            Navigator.pushNamed(context, Strings.routeAddProcedures);
          },
          child: const Icon(Icons.add),
          backgroundColor: Shade.fabGlobalButtonColor,
        ));
  }

  void initVariablesAndClasses() {
    procedureHeaders = [];
    procedurePerPage = [5, 10, 15, 100];
    procedureTotal = 100;
    procedureCurrentPerPage;
    procedureCurrentPage = 1;
    procedureIsSearch = false;
    procedureIsSource = [];
    procedureIsSearched = [];
    procedureSelecteds = [];
    procedureSelectableKey = "Invoice";
    procedureSortColumn;
    procedureSortAscending = true;
    procedureIsLoading = true;
    procedureShowSelect = false;
    listProcedures = [];
    showSearchedList = false;
  }

  void getProceduresFromApiAndLinkToTable() async {
    setState(() => procedureIsLoading = true);
    ProcedureService procedureService = ProcedureService();
    listProcedures = await procedureService.getProcedures();
    procedureIsSource.addAll(generateProcedureDataFromApi(listProcedures));
    setState(() => procedureIsLoading = false);
  }

  List<Map<String, dynamic>> generateProcedureDataFromApi(
      List<Procedures> listOfProcedures) {
    List<Map<String, dynamic>> tempsprocedure = [];
    for (Procedures procedures in listOfProcedures) {
      tempsprocedure.add({
        "Id": procedures.id,
        "Name": procedures.name,
        "PerformedBy": procedures.performedBy,
        "Charges": procedures.charges,
        "Share": procedures.performerShare,
        "Action": procedures.id,
      });
    }
    return tempsprocedure;
  }

  List<Map<String, dynamic>> generateProcedureSearchData(
      Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsprocedure = [];
    for (var iterable in iterableList) {
      tempsprocedure.add({
        "Id": iterable["Id"],
        "Name": iterable["Name"],
        "PerformedBy": iterable["PerformedBy"],
        "Charges": iterable["Charges"],
        "Share": iterable["Share"],
        "Action": iterable["Action"],
      });
    }
    return tempsprocedure;
  }

  void initHeadersOfProcedureTable() {
    procedureHeaders = [
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
          value: "Name",
          show: true,
          flex: 2,
          sortable: false,
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
          value: "PerformedBy",
          show: true,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Performed By",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Charges",
          show: true,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Charges",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "Share",
          show: true,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Share",
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
                      onPressedEditInTable(Id, row);
                    },
                    child: Text('Edit')),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      onPressedDeleteInTable(Id, row);
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

  bool onPressedEditInTable(Id, row) {
    print('Id');
    print(Id);
    print('row');
    print(row);
  }

  bool onPressedDeleteInTable(Id, row) {
    print('Id');
    print(Id);
    print('row');
    print(row);
  }

  void onChangedSearchedValue(value) {
    if (!procedureIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 2) {
          var searchList = procedureIsSource.where((element) {
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
          procedureIsSearched = [];
          procedureIsSearched.addAll(generateProcedureSearchData(searchList));
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

  Widget widgetprocedurePatients() {
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
                          hintText: 'Search procedure'),
                      onChanged: (value) => onChangedSearchedValue(value),
                    )),
                  ],
                  headers: procedureHeaders,
                  source: !showSearchedList
                      ? procedureIsSource
                      : procedureIsSearched,
                  selecteds: procedureSelecteds,
                  showSelect: procedureShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      procedureSortColumn = value;
                      procedureSortAscending = !procedureSortAscending;
                      if (procedureSortAscending) {
                        procedureIsSource.sort((a, b) =>
                            b["$procedureSortColumn"]
                                .compareTo(a["$procedureSortColumn"]));
                      } else {
                        procedureIsSource.sort((a, b) =>
                            a["$procedureSortColumn"]
                                .compareTo(b["$procedureSortColumn"]));
                      }
                    });
                  },
                  sortAscending: procedureSortAscending,
                  sortColumn: procedureSortColumn,
                  isLoading: procedureIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => procedureSelecteds.add(item));
                    } else {
                      setState(() => procedureSelecteds
                          .removeAt(procedureSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => procedureSelecteds = procedureIsSource
                          .map((entry) => entry)
                          .toList()
                          .cast());
                    } else {
                      setState(() => procedureSelecteds.clear());
                    }
                  },
                ),
              ),
            ),
          ]),
    );
  }
}
