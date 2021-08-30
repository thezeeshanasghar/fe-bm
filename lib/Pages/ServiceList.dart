import 'dart:async';

import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Responses/ServiceResponse.dart';
import 'package:baby_doctor/Models/Sample/ServiceSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/Service.dart';
import 'package:baby_doctor/ShareArguments/ServiceArguments.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:provider/provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

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
  List<DatatableHeader> serviceHeaders;
  List<int> servicePerPage;
  List<Map<String, dynamic>> serviceIsSource;
  List<Map<String, dynamic>> serviceIsSearched;
  List<Map<String, dynamic>> serviceSelected;

  List<ServiceSample> listService;
  Service service;

  GlobalProgressDialog globalProgressDialog;
  bool hasChangeDependencies = false;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initHeadersOfServiceTable();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      checkTokenValidityAndGetService();
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
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
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.minHeight,
                  ),
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(Dimens.globalPaddingLeft, Dimens.globalPaddingTop,
                          Dimens.globalPaddingRight, Dimens.globalPaddingBottom),
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
    serviceCurrentPage = 1;
    serviceIsSearch = false;
    serviceIsSource = [];
    serviceIsSearched = [];
    serviceSelected = [];
    serviceSelectableKey = "Invoice";
    serviceSortAscending = true;
    serviceIsLoading = true;
    serviceShowSelect = false;
    listService = [];
    showSearchedList = false;
    service = Service();
  }

  FutureOr onGoBack(dynamic value) {
    checkTokenValidityAndGetService();
  }

  Future<void> checkTokenValidityAndGetService() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        getServicesFromApiAndLinkToTable();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  Future<void> getServicesFromApiAndLinkToTable() async {
    setState(() => serviceIsLoading = true);
    listService = [];
    serviceIsSource = [];
    try {
      ServiceResponseList serviceResponseList =
          await service.getServices(context.read<TokenProvider>().tokenSample.jwtToken);
      if (serviceResponseList != null) {
        if (serviceResponseList.isSuccess) {
          listService = serviceResponseList.data;
          serviceIsSource.addAll(generateServiceDataFromApi(listService));
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, serviceResponseList.message, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
      }
      setState(() => serviceIsLoading = false);
    } catch (exception) {
      setState(() => serviceIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generateServiceDataFromApi(List<ServiceSample> listOfServices) {
    List<Map<String, dynamic>> tempsService = [];
    for (ServiceSample services in listOfServices) {
      tempsService.add({
        "id": services.id,
        "name": services.name,
        "description": services.description,
        "Action": services.id,
      });
    }
    return tempsService;
  }

  List<Map<String, dynamic>> generateServiceSearchData(Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsService = [];
    for (var iterable in iterableList) {
      tempsService.add({
        "id": iterable["id"],
        "name": iterable["name"],
        "description": iterable["description"],
        "Action": iterable["Action"],
      });
    }
    return tempsService;
  }

  void initHeadersOfServiceTable() {
    serviceHeaders = [
      DatatableHeader(
          value: "id",
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
          value: "name",
          show: true,
          flex: 1,
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
          value: "description",
          show: true,
          flex: 3,
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
          sourceBuilder: (id, row) {
            return Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => onPressedEditFromTable(id, row),
                  child: Text('Edit',
                      style: TextStyle(
                        color: Shade.actionButtonTextEdit,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                    onPressed: () => onPressedDeleteFromTable(id, row),
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

  void onPressedEditFromTable(id, row) {
    Navigator.pushNamed(context, Strings.routeEditService,
            arguments: ServiceArguments(id: row['id'], name: row['name'], description: row['description']))
        .then((value) => onGoBack(value));
  }

  void onPressedDeleteFromTable(id, row) {
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(Strings.alertDialogButtonCancel,
          style: TextStyle(color: Shade.alertBoxButtonTextCancel, fontWeight: FontWeight.w900)),
    );

    Widget deleteButton = TextButton(
      child: Text(Strings.alertDialogButtonDelete,
          style: TextStyle(color: Shade.alertBoxButtonTextDelete, fontWeight: FontWeight.w900)),
      onPressed: () => onCallingDeleteService(id),
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
            row['name'] + ' ?',
            style: TextStyle(fontWeight: FontWeight.w100, color: Colors.red),
          )
        ],
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
      actionsPadding: EdgeInsets.fromLTRB(Dimens.actionsGlobalButtonLeft, Dimens.actionsGlobalButtonTop,
          Dimens.actionsGlobalButtonRight, Dimens.actionsGlobalButtonBottom),
    );

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> onCallingDeleteService(int id) async {
    Navigator.pop(context);
    globalProgressDialog.showSimpleFontellicoProgressDialog(
        false, Strings.dialogDeleting, SimpleFontelicoProgressDialogType.multilines);

    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        ServiceResponse serviceResponse =
            await service.deleteService(id, context.read<TokenProvider>().tokenSample.jwtToken);
        if (serviceResponse != null) {
          if (serviceResponse.isSuccess) {
            checkTokenValidityAndGetService();
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, serviceResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, serviceResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
          }
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }

  void onChangedSearchedValue(value) {
    if (!serviceIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 1) {
          var searchList = serviceIsSource.where((element) {
            String searchById = element["id"].toString().toLowerCase();
            String searchByName = element["name"].toString().toLowerCase();
            String searchByDescription = element["description"].toString().toLowerCase();

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
      } else {
        setState(() {
          showSearchedList = false;
        });
      }
    }
  }

  Widget widgetServicePatients() {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
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
                      border: InputBorder.none, prefixIcon: Icon(Icons.search_outlined), hintText: 'Search Service'),
                  onChanged: (value) => onChangedSearchedValue(value),
                )),
              ],
              headers: serviceHeaders,
              source: !showSearchedList ? serviceIsSource : serviceIsSearched,
              selecteds: serviceSelected,
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
                    serviceIsSource.sort((a, b) => b["$serviceSortColumn"].compareTo(a["$serviceSortColumn"]));
                  } else {
                    serviceIsSource.sort((a, b) => a["$serviceSortColumn"].compareTo(b["$serviceSortColumn"]));
                  }
                });
              },
              sortAscending: serviceSortAscending,
              sortColumn: serviceSortColumn,
              isLoading: serviceIsLoading,
              onSelect: (value, item) {
                print("$value  $item ");
                if (value) {
                  setState(() => serviceSelected.add(item));
                } else {
                  setState(() => serviceSelected.removeAt(serviceSelected.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value) {
                  setState(() => serviceSelected = serviceIsSource.map((entry) => entry).toList().cast());
                } else {
                  setState(() => serviceSelected.clear());
                }
              },
            ),
          ),
        ),
      ]),
    );
  }
}
