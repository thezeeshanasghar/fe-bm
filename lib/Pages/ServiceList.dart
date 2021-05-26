import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Services.dart';
import 'package:baby_doctor/Service/Service.dart';
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
  bool showSearchedList;
  String serviceListSelectableKey = "Invoice";
  String serviceListSortColumn;
  bool serviceListSortAscending = true;
  bool serviceListIsLoading = true;
  bool serviceListShowSelect = false;
  List<Services> listServices;
  Service service;

  @override
  void initState() {
    super.initState();
    // serviceList
    initVariablesAndClasses();
    initializeserviceListHeaders();
    getServicesFromApiAndLinkToTable();
  }

  void initVariablesAndClasses() {
    serviceListHeaders = [];
    serviceListPerPage = [5, 10, 15, 100];
    serviceListTotal = 100;
    serviceListCurrentPerPage;
    serviceListCurrentPage = 1;
    serviceListIsSearch = false;
    serviceListIsSource = [];
    serviceListSelecteds = [];
    serviceListSelectableKey = "Invoice";
    serviceListSortColumn;
    serviceListSortAscending = true;
    serviceListIsLoading = true;
    serviceListShowSelect = false;
    listServices = [];
    showSearchedList = false;
    showSearchedList = false;

    service = Service();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getServicesFromApiAndLinkToTable() async {
    setState(() => serviceListIsLoading = true);
    listServices = [];
    serviceListIsSource = [];
    listServices = await service.getServices();
    serviceListIsSource.addAll(generateServiceDataFromApi(listServices));
    setState(() => serviceListIsLoading = false);
  }

  List<Map<String, dynamic>> generateServiceDataFromApi(
      List<Services> listOfServices) {
    List<Map<String, dynamic>> tempservices = [];
    for (Services services in listOfServices) {
      tempservices.add({
        "Id": services.id,
        "ServiceName": services.name,
        "ServiceDescription": services.description,
        "Action": services.id,
      });
    }
    return tempservices;
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

  initializeserviceListHeaders() {
    serviceListHeaders = [
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
                      print(Id);
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
        service.DeleteServices(Id).then((response) {
          if (response == true) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalSuccess,
                content: Row(
                  children: [
                    Text('Success: Deleted service '),
                    Text(
                      row['ServiceName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )));
            getServicesFromApiAndLinkToTable();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalFailed,
                content: Row(
                  children: [
                    Text('Error: Try Again: Failed to delete service '),
                    Text(
                      row['ServiceName'],
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
            row['ServiceName'] + ' ?',
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

  void onPressedEditFromTable(Id, row) {
    print(Id);
    Navigator.pushNamed(context, Strings.routeEditService,arguments:{'Id': Id});
  }
}
