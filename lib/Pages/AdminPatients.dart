import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

class AdminPatient extends StatefulWidget {
  @override
  _AdminPatientState createState() => _AdminPatientState();
}

class _AdminPatientState extends State<AdminPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Admin Patients"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: AdminPatientForm(),
    );
  }
}

class AdminPatientForm extends StatefulWidget {
  @override
  _AdminPatientFormState createState() => _AdminPatientFormState();
}

class _AdminPatientFormState extends State<AdminPatientForm> {
  final formKey = GlobalKey<FormState>();

  List<DatatableHeader> walkInHeaders = [
    DatatableHeader(
        text: "Invoice",
        value: "Invoice",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Date",
        value: "Date",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Name",
        value: "Name",
        show: true,
        flex: 2,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Father Name",
        value: "FatherName",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "DOB",
        value: "DOB",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Total",
        value: "Total",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Discount",
        value: "Discount",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Net Total",
        value: "NetTotal",
        show: true,
        sortable: true,
        textAlign: TextAlign.center),
    DatatableHeader(
        text: "Action",
        value: "NewInvoice",
        show: true,
        sortable: true,
        textAlign: TextAlign.center,
        sourceBuilder: (value, row) {
          List list = List.from(value);
          return Container(
              child:
                  ElevatedButton(onPressed: () {}, child: Text('New Invoice')));
        }),
  ];

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
        "Discount": "Rs. 1${i}",
        "NetTotal": "Rs. 5${i}",
        "NewInvoice": [i, i],
      });
      i++;
    }
    return temps;
  }

  walkInInitData() async {
    setState(() => walkInIsLoading = true);
    Future.delayed(Duration(seconds: 3)).then((value) {
      walkInIsSource.addAll(walkInGenerateData(n: 1000));
      setState(() => walkInIsLoading = false);
    });
  }

  @override
  void initState() {
    super.initState();
    walkInInitData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.minHeight,
              ),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        widgetWalkInPatients('Walk-in (Out Patients)'),
                        SizedBox(height: 20,),
                        widgetWalkInPatients('Online'),
                        SizedBox(height: 20,),
                        widgetWalkInPatients('In-Patients (Admitted)')
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }

  Widget widgetWalkInPatients(String name) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(0),
            constraints: BoxConstraints(
              maxHeight: 500,
            ),
            child: Card(
              elevation: 1,
              shadowColor: Colors.black,
              clipBehavior: Clip.none,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ResponsiveDatatable(
                  title: !walkInIsSearch
                      ? Text(
                          name,
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                    print(data);
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ]);
  }
}
