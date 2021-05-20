import 'dart:math';

import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  final formKey = GlobalKey<FormState>();

  // serviceList Data
  List<DatatableHeader> serviceListHeaders = [];
  List<int> serviceListPerPage = [5, 10, 15, 100];
  int serviceListTotal = 100;
  int serviceListCurrentPerPage;
  int serviceListCurrentPage = 1;
  bool serviceListIsSearch = false;
  List<Map<String, dynamic>> serviceListIsSource = [];
  List<Map<String, dynamic>> serviceListSelecteds = [];
  String serviceListSelectableKey = "Invoice";
  String serviceListSortColumn;
  bool serviceListSortAscending = true;
  bool serviceListIsLoading = true;
  bool serviceListShowSelect = false;

  @override
  void initState() {
    super.initState();
    // serviceList
    initializeserviceListHeaders();
    serviceListInitData();
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
          title: Text(Strings.titleServiceList),
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
                          children: <Widget>[widgetserviceListPatients()],
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
            Navigator.pushNamed(context, Strings.routeAddService);
          },
          child: const Icon(Icons.add),
          backgroundColor: Shade.fabGlobalButtonColor,
        ));
  }

  Widget widgetserviceListPatients() {
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
                  title: !serviceListIsSearch
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
                    if (serviceListIsSearch)
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    serviceListIsSearch = false;
                                  });
                                }),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.search), onPressed: () {})),
                      )),
                    if (!serviceListIsSearch)
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              serviceListIsSearch = true;
                            });
                          })
                  ],
                  headers: serviceListHeaders,
                  source: serviceListIsSource,
                  selecteds: serviceListSelecteds,
                  showSelect: serviceListShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      serviceListSortColumn = value;
                      serviceListSortAscending = !serviceListSortAscending;
                      if (serviceListSortAscending) {
                        serviceListIsSource.sort((a, b) =>
                            b["$serviceListSortColumn"]
                                .compareTo(a["$serviceListSortColumn"]));
                      } else {
                        serviceListIsSource.sort((a, b) =>
                            a["$serviceListSortColumn"]
                                .compareTo(b["$serviceListSortColumn"]));
                      }
                    });
                  },
                  sortAscending: serviceListSortAscending,
                  sortColumn: serviceListSortColumn,
                  isLoading: serviceListIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => serviceListSelecteds.add(item));
                    } else {
                      setState(() => serviceListSelecteds
                          .removeAt(serviceListSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => serviceListSelecteds = serviceListIsSource
                          .map((entry) => entry)
                          .toList()
                          .cast());
                    } else {
                      setState(() => serviceListSelecteds.clear());
                    }
                  },
                  footers: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Rows per page:"),
                    ),
                    if (serviceListPerPage != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton(
                            value: serviceListCurrentPerPage,
                            items: serviceListPerPage
                                .map((e) => DropdownMenuItem(
                                      child: Text("$e"),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                serviceListCurrentPerPage = value;
                              });
                            }),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                          "$serviceListCurrentPage - $serviceListCurrentPerPage of $serviceListTotal"),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          serviceListCurrentPage = serviceListCurrentPage >= 2
                              ? serviceListCurrentPage - 1
                              : 1;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        setState(() {
                          serviceListCurrentPage++;
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

  // serviceList
  List<Map<String, dynamic>> serviceListGenerateData({int n: 100}) {
    final List sourceserviceList = List.filled(n, Random.secure());
    List<Map<String, dynamic>> tempsserviceList = [];
    var i = serviceListIsSource.length;
    print(i);
    for (var data in sourceserviceList) {
      tempsserviceList.add({
        "ServiceName": "ServiceName $i",
        "ServiceDescription": "ServiceDescription $i",
        "Action": [i, 100],
      });
      i++;
    }
    return tempsserviceList;
  }

  serviceListInitData() async {
    setState(() => serviceListIsLoading = true);
    Future.delayed(Duration(seconds: 0)).then((value) {
      serviceListIsSource.addAll(serviceListGenerateData(n: 100));
      setState(() => serviceListIsLoading = false);
    });
  }

  initializeserviceListHeaders() {
    serviceListHeaders = [
      DatatableHeader(
          value: "ServiceName",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Service Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "ServiceDescription",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Service Description",
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
