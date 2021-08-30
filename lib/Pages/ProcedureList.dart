import 'dart:async';

import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/ProcedureRequest.dart';
import 'package:baby_doctor/Models/Responses/ProcedureResponse.dart';
import 'package:baby_doctor/Models/Sample/ProcedureSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/ProcedureService.dart';
import 'package:baby_doctor/ShareArguments/ProcedureArguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

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
  List<ProcedureSample> listProcedures;
  ProcedureService procedureService;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initHeadersOfProcedureTable();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      checkTokenValidityAndGetProcedure();
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
          title: Text(Strings.titleProcedureList),
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
    procedureCurrentPage = 1;
    procedureIsSearch = false;
    procedureIsSource = [];
    procedureIsSearched = [];
    procedureSelecteds = [];
    procedureSelectableKey = "Invoice";
    procedureSortAscending = true;
    procedureIsLoading = true;
    procedureShowSelect = false;
    listProcedures = [];
    showSearchedList = false;

    procedureService = ProcedureService();
  }

  Future<void> checkTokenValidityAndGetProcedure() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        getProceduresFromApiAndLinkToTable();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorToken, context);
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  Future<void> getProceduresFromApiAndLinkToTable() async {
    setState(() => procedureIsLoading = true);
    listProcedures = [];
    procedureIsSource = [];
    try {
      ProcedureResponseList procedureList =
          await procedureService.getProcedures(context.read<TokenProvider>().tokenSample.jwtToken);
      if (procedureList != null) {
        if (procedureList.isSuccess) {
          listProcedures = procedureList.data;
          procedureIsSource.addAll(generateProcedureDataFromApi(listProcedures));
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, procedureList.message, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, Strings.errorNull, context);
      }
      setState(() => procedureIsLoading = false);
    } catch (exception) {
      setState(() => procedureIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generateProcedureDataFromApi(List<ProcedureSample> listOfProcedure) {
    List<Map<String, dynamic>> tempsProcedure = [];
    for (ProcedureSample procedureSample in listOfProcedure) {
      tempsProcedure.add({
        "id": procedureSample.id,
        "name": procedureSample.name,
        "executant": procedureSample.executant,
        "charges": procedureSample.charges,
        "executantShare": procedureSample.executantShare,
        "Action": procedureSample.id,
      });
    }
    return tempsProcedure;
  }

  List<Map<String, dynamic>> generateProcedureSearchData(Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsprocedure = [];
    for (var iterable in iterableList) {
      tempsprocedure.add({
        "id": iterable["id"],
        "name": iterable["name"],
        "Action": iterable["Action"],
      });
    }
    return tempsprocedure;
  }

  void initHeadersOfProcedureTable() {
    procedureHeaders = [
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
          value: "executant",
          show: true,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Executant",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "charges",
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
          value: "executantShare",
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

  FutureOr onGoBack(dynamic value) {
    checkTokenValidityAndGetProcedure();
  }

  void onPressedEditFromTable(id, row) {
    ProcedureRequest procedureRequest = ProcedureRequest(
      id: row['id'],
      name: row['name'],
      executantShare: row['executantShare'],
      executant: row['executant'],
      charges: row['charges'],
    );

    Navigator.pushNamed(
      context,
      Strings.routeEditProcedure,
      arguments: procedureRequest,
    ).then((value) => onGoBack(value));
  }

  void onPressedDeleteFromTable(id, row) {
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text("Cancel", style: TextStyle(color: Shade.alertBoxButtonTextCancel, fontWeight: FontWeight.w900)),
    );

    Widget deleteButton = TextButton(
      child: Text("Delete", style: TextStyle(color: Shade.alertBoxButtonTextDelete, fontWeight: FontWeight.w900)),
      onPressed: () => onCallingDeleteProcedure(id),
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
            row['firstName'],
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

  Future<void> onCallingDeleteProcedure(int id) async {
    Navigator.pop(context);
    globalProgressDialog.showSimpleFontellicoProgressDialog(
        false, Strings.dialogDeleting, SimpleFontelicoProgressDialogType.multilines);
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        ProcedureResponse procedureResponse =
            await procedureService.deleteProcedure(id, context.read<TokenProvider>().tokenSample.jwtToken);
        if (procedureResponse != null) {
          if (procedureResponse.isSuccess) {
            checkTokenValidityAndGetProcedure();
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalSuccess, procedureResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(Shade.snackGlobalFailed, procedureResponse.message, context);
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
    if (!procedureIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 2) {
          var searchList = procedureIsSource.where((element) {
            String searchById = element["id"].toString().toLowerCase();
            String searchByName = element["name"].toString().toLowerCase();

            if (searchById.contains(value.toLowerCase()) ||
                searchByName.contains(value.toLowerCase())) {
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
                      border: InputBorder.none, prefixIcon: Icon(Icons.search_outlined), hintText: 'Search procedure'),
                  onChanged: (value) => onChangedSearchedValue(value),
                )),
              ],
              headers: procedureHeaders,
              source: !showSearchedList ? procedureIsSource : procedureIsSearched,
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
                    procedureIsSource.sort((a, b) => b["$procedureSortColumn"].compareTo(a["$procedureSortColumn"]));
                  } else {
                    procedureIsSource.sort((a, b) => a["$procedureSortColumn"].compareTo(b["$procedureSortColumn"]));
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
                  setState(() => procedureSelecteds.removeAt(procedureSelecteds.indexOf(item)));
                }
              },
              onSelectAll: (value) {
                if (value) {
                  setState(() => procedureSelecteds = procedureIsSource.map((entry) => entry).toList().cast());
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
