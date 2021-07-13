import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Services.dart';
import 'package:baby_doctor/Service/Service.dart';
import 'package:baby_doctor/ShareArguments/ServiceArguments.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ServiceList extends StatefulWidget {
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  final formKey = GlobalKey<FormState>();

  int serviceTotal;
  int serviceCurrentPerPage;
  int serviceCurrentPage;
  bool serviceIsSearch;
  String serviceSelectableKey;
  String serviceSortColumn;
  bool serviceSortAscending;
  bool serviceIsLoading;
  bool serviceShowSelect;
  bool showSearchedList;
  SimpleFontelicoProgressDialog sfpd;
  List<DatatableHeader> serviceHeaders;
  List<int> servicePerPage;
  List<Map<String, dynamic>> serviceIsSource;
  List<Map<String, dynamic>> serviceIsSearched;
  List<Map<String, dynamic>> serviceSelecteds;
  List<ServiceData> listservices;

  Service service;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initHeadersOfServiceTable();
    getServicesFromApiAndLinkToTable();
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
                          children: <Widget>[widgetServicePatients()],
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

  void initVariablesAndClasses() {
    serviceHeaders = [];
    servicePerPage = [5, 10, 15, 100];
    serviceTotal = 100;
    serviceCurrentPerPage;
    serviceCurrentPage = 1;
    serviceIsSearch = false;
    serviceIsSource = [];
    serviceIsSearched = [];
    serviceSelecteds = [];
    serviceSelectableKey = "Invoice";
    serviceSortColumn;
    serviceSortAscending = true;
    serviceIsLoading = true;
    serviceShowSelect = false;
    listservices = [];
    showSearchedList = false;

    service = Service();
  }

  void getServicesFromApiAndLinkToTable() async {
    setState(() => serviceIsLoading = true);
    listservices = [];
    serviceIsSource = [];
    ServiceResponse serviceResponse = await service.getServices();
    listservices = serviceResponse.data;
    serviceIsSource.addAll(generateServiceDataFromApi(listservices));
    setState(() => serviceIsLoading = false);
  }

  List<Map<String, dynamic>> generateServiceDataFromApi(
      List<ServiceData> listOfServices) {
    List<Map<String, dynamic>> tempsService = [];
    for (ServiceData services in listOfServices) {
      tempsService.add({
        "Id": services.id,
        "ServiceName": services.name,
        "ServiceDescription": services.description,
        "Action": services.id,
      });
    }
    return tempsService;
  }

  List<Map<String, dynamic>> generateServiceSearchData(
      Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsService = [];
    for (var iterable in iterableList) {
      tempsService.add({
        "Id": iterable["Id"],
        "ServiceName": iterable["ServiceName"],
        "ServiceDescription": iterable["ServiceDescription"],
        "Action": iterable["Action"],
      });
    }
    return tempsService;
  }

  void initHeadersOfServiceTable() {
    serviceHeaders = [
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
          value: "ServiceName",
          show: true,
          flex: 2,
          sortable: false,
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
          sortable: false,
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
    Navigator.pushNamed(context, Strings.routeEditService,
        arguments: ServiceArguments(
            id: Id,
            name: row['ServiceName'],
            description: row['ServiceDescription']));

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
        service.DeleteServices(Id).then((response) async {
          if (response == true) {
            await sfpd.hide();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalSuccess,
                content: Row(
                  children: [
                    Text('Success: Deleted Service '),
                    Text(
                      row['ServiceName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )));
            getServicesFromApiAndLinkToTable();
          } else {
            await sfpd.hide();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalFailed,
                content: Row(
                  children: [
                    Text('Error: Try Again: Failed to delete Service '),
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

  void onChangedSearchedValue(value) {
    if (!serviceIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 2) {
          var searchList = serviceIsSource.where((element) {
            String searchById = element["Id"].toString().toLowerCase();
            String searchByName =
                element["ServiceName"].toString().toLowerCase();
            String searchByDescription =
                element["ServiceDescription"].toString().toLowerCase();

            if (searchById.contains(value.toLowerCase()) ||
                searchByName.contains(value.toLowerCase()) ||
                searchByDescription.contains(value.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          });
          serviceIsSearched = [];
          serviceIsSearched.addAll(generateServiceSearchData(searchList));
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

  Widget widgetServicePatients() {
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
                          hintText: 'Search Service'),
                      onChanged: (value) => onChangedSearchedValue(value),
                    )),
                  ],
                  headers: serviceHeaders,
                  source:
                      !showSearchedList ? serviceIsSource : serviceIsSearched,
                  selecteds: serviceSelecteds,
                  showSelect: serviceShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      serviceSortColumn = value;
                      serviceSortAscending = !serviceSortAscending;
                      if (serviceSortAscending) {
                        serviceIsSource.sort((a, b) => b["$serviceSortColumn"]
                            .compareTo(a["$serviceSortColumn"]));
                      } else {
                        serviceIsSource.sort((a, b) => a["$serviceSortColumn"]
                            .compareTo(b["$serviceSortColumn"]));
                      }
                    });
                  },
                  sortAscending: serviceSortAscending,
                  sortColumn: serviceSortColumn,
                  isLoading: serviceIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => serviceSelecteds.add(item));
                    } else {
                      setState(() => serviceSelecteds
                          .removeAt(serviceSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => serviceSelecteds = serviceIsSource
                          .map((entry) => entry)
                          .toList()
                          .cast());
                    } else {
                      setState(() => serviceSelecteds.clear());
                    }
                  },
                ),
              ),
            ),
          ]),
    );
  }
}
