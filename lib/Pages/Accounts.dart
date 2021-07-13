import 'dart:convert';
import 'dart:math';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

class Accounts extends StatefulWidget {
  @override
  _AccountsState createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
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
  bool walkInIsSearch;
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
  String PatientId;
  bool onlineSortAscending = true;
  bool onlineIsLoading = true;
  bool onlineShowSelect = false;

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
    setState(() => walkInIsLoading = true);
    Future.delayed(Duration(seconds: 0)).then((value) {
      walkInIsSource.addAll(walkInGenerateData(n: 100));
      setState(() => walkInIsLoading = false);
    });
  }

  void initWalkInVariablesAndClasses() {
    walkInHeaders = [];
    walkInPerPage = [5, 10, 15, 100];
    walkInTotal = 100;
    walkInCurrentPerPage;
    walkInCurrentPage = 1;
    walkInIsSearch = false;
    walkInIsSource = [];
    walkInSelecteds = [];
    walkInSelectableKey = "Invoice";
    walkInSortColumn;
    walkInSortAscending = true;
    walkInIsLoading = true;
    walkInShowSelect = false;
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
          value: "FatherName",
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
          show: false,
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
          value: "Action",
          show: true,
          flex: 3,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "New Invoice",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          sourceBuilder: (Id, row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      print(Id);
                      // Navigator.pushNamed(context, Strings.routeNewInvoice,
                      //     arguments: PatientArguments(Id: Id));
                    },
                    child: Text('New Invoice')),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Refund()),
                      // );
                    },
                    child: Text(
                      'Admit',
                      style: TextStyle(color: Colors.green),
                    )),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Refund()),
                      // );
                    },
                    child: Text(
                      'Refund',
                      style: TextStyle(color: Colors.red),
                    )),
              ],
            );
          }),
    ];
  }

  @override
  void initState() {
    super.initState();

    initWalkInVariablesAndClasses();
    initializeWalkInHeaders();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(Strings.titleAccounts),
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
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          widgetWalkInPatients(),
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

  Widget widgetWalkInPatients() {
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
    );
  }
}
