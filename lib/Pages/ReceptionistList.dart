import 'dart:math';

import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

class ReceptionistList extends StatefulWidget {
  @override
  _ReceptionistListState createState() => _ReceptionistListState();
}

class _ReceptionistListState extends State<ReceptionistList> {
  final formKey = GlobalKey<FormState>();

  // receptionistList Data
  List<DatatableHeader> receptionistListHeaders = [];
  List<int> receptionistListPerPage = [5, 10, 15, 100];
  int receptionistListTotal = 100;
  int receptionistListCurrentPerPage;
  int receptionistListCurrentPage = 1;
  bool receptionistListIsSearch = false;
  List<Map<String, dynamic>> receptionistListIsSource = [];
  List<Map<String, dynamic>> receptionistListSelecteds = [];
  String receptionistListSelectableKey = "Invoice";
  String receptionistListSortColumn;
  bool receptionistListSortAscending = true;
  bool receptionistListIsLoading = true;
  bool receptionistListShowSelect = false;

  @override
  void initState() {
    super.initState();
    // receptionistList
    initializereceptionistListHeaders();
    receptionistListInitData();
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
                          children: <Widget>[widgetreceptionistListPatients()],
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
            Navigator.pushNamed(context, Strings.routeAddReceptionist);
          },
          child: const Icon(Icons.add),
          backgroundColor: Shade.fabGlobalButtonColor,
        ));
  }

  Widget widgetreceptionistListPatients() {
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
                  title: !receptionistListIsSearch
                      ? Row(
                          children: [
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Icon(Icons.person_outline_outlined),
                            // ),
                            // Text(
                            //   'Click on search icon to search',
                            //   style: TextStyle(fontWeight: FontWeight.normal),
                            // ),
                          ],
                        )
                      : null,
                  actions: [
                    if (receptionistListIsSearch)
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    receptionistListIsSearch = false;
                                  });
                                }),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.search), onPressed: () {})),
                      )),
                    if (!receptionistListIsSearch)
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              receptionistListIsSearch = true;
                            });
                          })
                  ],
                  headers: receptionistListHeaders,
                  source: receptionistListIsSource,
                  selecteds: receptionistListSelecteds,
                  showSelect: receptionistListShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      receptionistListSortColumn = value;
                      receptionistListSortAscending =
                          !receptionistListSortAscending;
                      if (receptionistListSortAscending) {
                        receptionistListIsSource.sort((a, b) =>
                            b["$receptionistListSortColumn"]
                                .compareTo(a["$receptionistListSortColumn"]));
                      } else {
                        receptionistListIsSource.sort((a, b) =>
                            a["$receptionistListSortColumn"]
                                .compareTo(b["$receptionistListSortColumn"]));
                      }
                    });
                  },
                  sortAscending: receptionistListSortAscending,
                  sortColumn: receptionistListSortColumn,
                  isLoading: receptionistListIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => receptionistListSelecteds.add(item));
                    } else {
                      setState(() => receptionistListSelecteds
                          .removeAt(receptionistListSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => receptionistListSelecteds =
                          receptionistListIsSource
                              .map((entry) => entry)
                              .toList()
                              .cast());
                    } else {
                      setState(() => receptionistListSelecteds.clear());
                    }
                  },
                  footers: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Rows per page:"),
                    ),
                    if (receptionistListPerPage != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton(
                            value: receptionistListCurrentPerPage,
                            items: receptionistListPerPage
                                .map((e) => DropdownMenuItem(
                                      child: Text("$e"),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                receptionistListCurrentPerPage = value;
                              });
                            }),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                          "$receptionistListCurrentPage - $receptionistListCurrentPerPage of $receptionistListTotal"),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          receptionistListCurrentPage =
                              receptionistListCurrentPage >= 2
                                  ? receptionistListCurrentPage - 1
                                  : 1;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        setState(() {
                          receptionistListCurrentPage++;
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

  // receptionistList
  List<Map<String, dynamic>> receptionistListGenerateData({int n: 100}) {
    final List sourcereceptionistList = List.filled(n, Random.secure());
    List<Map<String, dynamic>> tempsreceptionistList = [];
    var i = receptionistListIsSource.length;
    print(i);
    for (var data in sourcereceptionistList) {
      tempsreceptionistList.add({
        "FirstName": "FirstName $i",
        "LastName": "LastName $i",
        "Gender": "Gender $i",
        "DOB": "DOB $i",
        "CNIC": "CNIC $i",
        "ContactNumber": "ContactNumber $i",
        "Email": "Email $i",
        "Address": "Address $i",
        "FloorNo": "FloorNo $i",
        "JoiningDate": "JoiningDate $i",
        "Action": [i, 100],
      });
      i++;
    }
    return tempsreceptionistList;
  }

  receptionistListInitData() async {
    setState(() => receptionistListIsLoading = true);
    Future.delayed(Duration(seconds: 0)).then((value) {
      receptionistListIsSource.addAll(receptionistListGenerateData(n: 100));
      setState(() => receptionistListIsLoading = false);
    });
  }

  initializereceptionistListHeaders() {
    receptionistListHeaders = [
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
          value: "Email",
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
          value: "FloorNo",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Floor No",
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
