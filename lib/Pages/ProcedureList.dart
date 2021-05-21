import 'dart:convert';
import 'dart:math';

import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Procedures.dart';
import 'package:baby_doctor/Service/ProcedureService.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:baby_doctor/Service/ProcedureService.dart' as DAL;


class ProcedureList extends StatefulWidget {
  @override
  _ProcedureListState createState() => _ProcedureListState();
}

class _ProcedureListState extends State<ProcedureList> {
  final formKey = GlobalKey<FormState>();

  // procedure Data
  List<DatatableHeader> procedureHeaders = [];
  List<int> procedurePerPage = [5, 10, 15, 100];
  int procedureTotal = 100;
  int procedureCurrentPerPage;
  int procedureCurrentPage = 1;
  bool procedureIsSearch = false;
  List<Map<String, dynamic>> procedureIsSource = [];
  List<Map<String, dynamic>> procedureSelecteds = [];
  String procedureSelectableKey = "Invoice";
  String procedureSortColumn;
  bool procedureSortAscending = true;
  bool procedureIsLoading = true;
  bool procedureShowSelect = false;

  @override
  void initState() {
    super.initState();
    // procedure
    initializeprocedureHeaders();
    procedureInitData();
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
                  title: !procedureIsSearch
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.person_outline_outlined),
                            ),
                            Text(
                              Strings.titleProcedureList,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : null,
                  actions: [
                    if (procedureIsSearch)
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    procedureIsSearch = false;
                                  });
                                }),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.search), onPressed: () {})),
                      )),
                    if (!procedureIsSearch)
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              procedureIsSearch = true;
                            });
                          })
                  ],
                  headers: procedureHeaders,
                  source: procedureIsSource,
                  selecteds: procedureSelecteds,
                  showSelect: procedureShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    // print(data);
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
                  footers: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Rows per page:"),
                    ),
                    if (procedurePerPage != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton(
                            value: procedureCurrentPerPage,
                            items: procedurePerPage
                                .map((e) => DropdownMenuItem(
                                      child: Text("$e"),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                procedureCurrentPerPage = value;
                              });
                            }),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                          "$procedureCurrentPage - $procedureCurrentPerPage of $procedureTotal"),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          procedureCurrentPage = procedureCurrentPage >= 2
                              ? procedureCurrentPage - 1
                              : 1;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        setState(() {
                          procedureCurrentPage++;
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

  // procedure
  List<Map<String, dynamic>> procedureGenerateData({int n: 100,List<dynamic> list }) {
     List<dynamic> sourceprocedure = [];

      List<Map<String, dynamic>> tempsprocedure = [];
      var i = list.length;
      print(i);
      for (var data in list) {
        tempsprocedure.add({
          "Name": data["name"],
          "PerformedBy": data["performedBy"],
          "Charges": data["charges"],
          "Share": data["performerShare"],
          "Action": [i, 100],
        });
        i++;
      }
      return tempsprocedure;
  }

  procedureInitData() async {
    setState(() => procedureIsLoading = true);

    DAL.ProcedureService service =  new DAL.ProcedureService();
    var listOfProducts;
    List<dynamic> sourceprocedure=[];
   await service.getProcedures().then((result) {
      listOfProducts = result;
      setState(() {
        sourceprocedure=jsonDecode(result);
      });
    });
    Future.delayed(Duration(seconds: 0)).then((value) {
      procedureIsSource.addAll(procedureGenerateData(n: 100,list:sourceprocedure));
      setState(() => procedureIsLoading = false);
    });
  }

  initializeprocedureHeaders() {
    procedureHeaders = [
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
          value: "PerformedBy",
          show: true,
          sortable: true,
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
          sortable: true,
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
          sortable: true,
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
                    child: Text('Edit')),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Refund()),
                      // );
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
}
