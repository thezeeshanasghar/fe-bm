import 'dart:async';
import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Responses/ExpenseResponse.dart';
import 'package:baby_doctor/Models/Sample/ExpenseSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/ExpenseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class ExpenseList extends StatefulWidget {
  @override
  _ExpenseListState createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  final formKey = GlobalKey<FormState>();

  int expenseTotal;
  int expenseCurrentPerPage;
  int expenseCurrentPage;
  bool expenseIsSearch;
  String expenseSelectableKey;
  String expenseSortColumn;
  bool expenseSortAscending;
  bool expenseIsLoading;
  bool expenseShowSelect;
  bool showSearchedList;
  List<DatatableHeader> expenseHeaders;
  List<int> expensePerPage;
  List<Map<String, dynamic>> expenseIsSource;
  List<Map<String, dynamic>> expenseIsSearched;
  List<Map<String, dynamic>> expenseSelecteds;
  List<ExpenseSample> listExpenses;
  ExpenseService expenseService;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initHeadersOfExpenseTable();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      checkTokenValidityAndGetExpense();
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
          title: Text(Strings.titleExpenseList),
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
                          children: <Widget>[widgetExpensePatients()],
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
            Navigator.pushNamed(context, Strings.routeAddDoctor);
          },
          child: const Icon(Icons.add),
          backgroundColor: Shade.fabGlobalButtonColor,
        ));
  }

  void initVariablesAndClasses() {
    expenseHeaders = [];
    expensePerPage = [5, 10, 15, 100];
    expenseTotal = 100;
    expenseCurrentPage = 1;
    expenseIsSearch = false;
    expenseIsSource = [];
    expenseIsSearched = [];
    expenseSelecteds = [];
    expenseSelectableKey = "Invoice";
    expenseSortAscending = true;
    expenseIsLoading = true;
    expenseShowSelect = false;
    listExpenses = [];
    showSearchedList = false;

    expenseService = ExpenseService();
  }

  Future<void> checkTokenValidityAndGetExpense() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        getExpensesFromApiAndLinkToTable();
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  Future<void> getExpensesFromApiAndLinkToTable() async {
    setState(() => expenseIsLoading = true);
    listExpenses = [];
    expenseIsSource = [];
    try {
      ExpenseResponseList ExpenseList = await expenseService
          .getExpenses(context.read<TokenProvider>().tokenSample.jwtToken);
      if (ExpenseList != null) {
        if (ExpenseList.isSuccess) {
          listExpenses = ExpenseList.data;
          expenseIsSource.addAll(generateExpenseDataFromApi(listExpenses));
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              Shade.snackGlobalFailed, ExpenseList.message, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorNull, context);
      }
      setState(() => expenseIsLoading = false);
    } catch (exception) {
      setState(() => expenseIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generateExpenseDataFromApi(
      List<ExpenseSample> listOfExpense) {
    List<Map<String, dynamic>> tempsExpense = [];
    for (ExpenseSample expenseSample in listOfExpense) {
      tempsExpense.add({
        "id": expenseSample.id,
        "Name": expenseSample.employeeName,
        "BillType": expenseSample.billType,
        "PaymentType": expenseSample.paymentType,
        "EmployeeOrVender": expenseSample.employeeOrVender,
        "VoucherNo": expenseSample.voucherNo,
        "TotalBill": expenseSample.totalBill,
        "TransactionDetail": expenseSample.transactionDetail,
        "Action": expenseSample.id,
      });
    }
    return tempsExpense;
  }

  void initHeadersOfExpenseTable() {
    expenseHeaders = [
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
          value: "BillType",
          show: true,
          flex: 1,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Bill Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "PaymentType",
          show: true,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Payment Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "EmployeeOrVender",
          show: true,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Employee Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "VoucherNo",
          show: false,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Voucher No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "TotalBill",
          show: true,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Total Bill",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "TransactionDetail",
          show: false,
          sortable: false,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Transaction Detail",
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
                  // onPressed: () => onPressedEditFromTable(id, row),
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
    checkTokenValidityAndGetExpense();
  }

  // void onPressedEditFromTable(id, row) {
  //   ExpenseRequest expenseRequest = ExpenseRequest(
  //     id: row['id'],
  //     name: row['name'],
  //     executantShare: row['executantShare'],
  //     executant: row['executant'],
  //     consent: row['consent'],
  //     charges: row['charges'],
  //   );
  //
  //   Navigator.pushNamed(
  //     context,
  //     Strings.routeEditExpense,
  //     arguments: ExpenseRequest,
  //   ).then((value) => onGoBack(value));
  // }

  void onPressedDeleteFromTable(id, row) {
    print(id);
    Widget cancelButton = TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Text(Strings.alertDialogButtonCancel,
          style: TextStyle(
              color: Shade.alertBoxButtonTextCancel,
              fontWeight: FontWeight.w900)),
    );

    Widget deleteButton = TextButton(
      child: Text(Strings.alertDialogButtonDelete,
          style: TextStyle(
              color: Shade.alertBoxButtonTextDelete,
              fontWeight: FontWeight.w900)),
      onPressed: () => onCallingDeleteExpense(id),
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
            row['BillType'] + ' ?',
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

  Future<void> onCallingDeleteExpense(int id) async {
    Navigator.pop(context);
    globalProgressDialog.showSimpleFontellicoProgressDialog(false,
        Strings.dialogDeleting, SimpleFontelicoProgressDialogType.multilines);

    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        ExpenseResponse serviceResponse = await expenseService.deleteExpense(
            id, context.read<TokenProvider>().tokenSample.jwtToken);
        if (serviceResponse != null) {
          if (serviceResponse.isSuccess) {
            checkTokenValidityAndGetExpense();
            GlobalSnackbar.showMessageUsingSnackBar(
                Shade.snackGlobalSuccess, serviceResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(
                Shade.snackGlobalFailed, serviceResponse.message, context);
            globalProgressDialog.hideSimpleFontellicoProgressDialog();
          }
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              Shade.snackGlobalFailed, Strings.errorNull, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
      globalProgressDialog.hideSimpleFontellicoProgressDialog();
    }
  }

  Future<void> onChangedSearchedValue(String search) async {
    if (!expenseIsLoading) {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        if (search.isEmpty) {
          getExpensesFromApiAndLinkToTable();
          return;
        }
        ExpenseResponseList expenseResponse =
            await expenseService.getExpenseBySearch(
                context.read<TokenProvider>().tokenSample.jwtToken, search);
        if (expenseResponse != null) {
          if (expenseResponse.isSuccess) {
            expenseIsSource = [];
            listExpenses = [];
            listExpenses = expenseResponse.data;
            expenseIsSource.addAll(generateExpenseDataFromApi(listExpenses));
            setState(() {
              showSearchedList = false;
            });
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(
                Shade.snackGlobalFailed, expenseResponse.message, context);
          }
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              Shade.snackGlobalFailed, Strings.errorNull, context);
          globalProgressDialog.hideSimpleFontellicoProgressDialog();
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
        setState(() {
          showSearchedList = false;
        });
      }
    }
  }

  Widget widgetExpensePatients() {
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
                    widgetSearch(),
                  ],
                  headers: expenseHeaders,
                  source:
                      !showSearchedList ? expenseIsSource : expenseIsSearched,
                  selecteds: expenseSelecteds,
                  showSelect: expenseShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      expenseSortColumn = value;
                      expenseSortAscending = !expenseSortAscending;
                      if (expenseSortAscending) {
                        expenseIsSource.sort((a, b) => b["$expenseSortColumn"]
                            .compareTo(a["$expenseSortColumn"]));
                      } else {
                        expenseIsSource.sort((a, b) => a["$expenseSortColumn"]
                            .compareTo(b["$expenseSortColumn"]));
                      }
                    });
                  },
                  sortAscending: expenseSortAscending,
                  sortColumn: expenseSortColumn,
                  isLoading: expenseIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => expenseSelecteds.add(item));
                    } else {
                      setState(() => expenseSelecteds
                          .removeAt(expenseSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => expenseSelecteds = expenseIsSource
                          .map((entry) => entry)
                          .toList()
                          .cast());
                    } else {
                      setState(() => expenseSelecteds.clear());
                    }
                  },
                ),
              ),
            ),
          ]),
    );
  }

  Widget widgetSearch() {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey[300]),
        ),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          cursorColor: Colors.grey[600],
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search_outlined,
                color: Colors.grey[600],
              ),
              labelStyle: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
              ),
              focusColor: Colors.grey[600],
              hintText: 'Search'),
          onChanged: (value) => onChangedSearchedValue(value),
        ),
      ),
    ));
  }
}
