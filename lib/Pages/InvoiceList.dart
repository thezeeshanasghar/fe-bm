import 'dart:async';
import 'package:baby_doctor/Common/GlobalProgressDialog.dart';
import 'package:baby_doctor/Common/GlobalRefreshToken.dart';
import 'package:baby_doctor/Common/GlobalSnakbar.dart';
import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/QPadding.dart';
import 'package:baby_doctor/Design/QTextStyle.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/InvoiceSearchRequest.dart';
import 'package:baby_doctor/Models/Responses/InvoiceResponse.dart';
import 'package:baby_doctor/Models/Sample/InvoiceSample.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/InvoiceService.dart';
import 'package:baby_doctor/constants/QEnum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class InvoiceList extends StatefulWidget {
  @override
  _InvoiceListState createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  final formKey = GlobalKey<FormState>();

  int invoiceTotal;
  int invoiceCurrentPerPage;
  int invoiceCurrentPage;
  bool invoiceIsSearch;
  String invoiceSelectableKey;
  String invoiceSortColumn;
  String search = '';
  bool invoiceSortAscending;
  bool invoiceIsLoading;
  bool invoiceShowSelect;
  bool showSearchedList;
  List<DatatableHeader> invoiceHeaders;
  List<int> invoicePerPage;
  List<Map<String, dynamic>> invoiceIsSource;

  List<Map<String, dynamic>> invoiceIsSearched;
  List<Map<String, dynamic>> InvoiceSelecteds;
  List<InvoiceSample> listInvoice;
  InvoiceService invoiceService;
  bool hasChangeDependencies = false;
  GlobalProgressDialog globalProgressDialog;
  final _tecFromDate = TextEditingController();
  final _tecToDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tecFromDate.text = DateTime.now().toString().substring(0, 10);
    _tecToDate.text =
        DateTime.now().add(Duration(days: 1)).toString().substring(0, 10);
    initVariablesAndClasses();
    initHeadersOfInvoiceTable();
  }

  @override
  void didChangeDependencies() {
    if (!hasChangeDependencies) {
      globalProgressDialog = GlobalProgressDialog(context);
      checkTokenValidityAndGetInvoice();
      hasChangeDependencies = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tecToDate.dispose();
    _tecFromDate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Shade.globalBackgroundColor,
        appBar: AppBar(
          title: Text(Strings.titleInvoiceList),
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
                          children: <Widget>[widgetInvoicePatients()],
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
    invoiceHeaders = [];
    invoicePerPage = [5, 10, 15, 100];
    invoiceTotal = 100;
    invoiceCurrentPage = 1;
    invoiceIsSearch = false;
    invoiceIsSource = [];
    invoiceIsSearched = [];
    InvoiceSelecteds = [];
    invoiceSelectableKey = "Invoice";
    invoiceSortAscending = true;
    invoiceIsLoading = true;
    invoiceShowSelect = false;
    listInvoice = [];
    showSearchedList = false;

    invoiceService = InvoiceService();
  }

  Future<void> checkTokenValidityAndGetInvoice() async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        getInvoiceFromApiAndLinkToTable(search);
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
      }
    } catch (exception) {
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  Future<void> getInvoiceFromApiAndLinkToTable(String search) async {
    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        InvoiceResponseList invoiceList =
            await invoiceService.postInvoiceBySearch(
                InvoiceSearchRequest(
                  search: search,
                  fromDate: _tecFromDate.text,
                  toDate: _tecToDate.text,
                ),
                context.read<TokenProvider>().tokenSample.jwtToken);
        if (invoiceList != null) {
          if (invoiceList.isSuccess) {
            listInvoice = [];
            invoiceIsSource = [];
            listInvoice = invoiceList.data;
            invoiceIsSource.addAll(generateInvoiceDataFromApi(listInvoice));
          } else {
            GlobalSnackbar.showMessageUsingSnackBar(
                Shade.snackGlobalFailed, invoiceList.message, context);
          }
        } else {
          GlobalSnackbar.showMessageUsingSnackBar(
              Shade.snackGlobalFailed, Strings.errorNull, context);
        }
      } else {
        GlobalSnackbar.showMessageUsingSnackBar(
            Shade.snackGlobalFailed, Strings.errorToken, context);
        globalProgressDialog.hideSimpleFontellicoProgressDialog();
      }
      setState(() => invoiceIsLoading = false);
    } catch (exception) {
      setState(() => invoiceIsLoading = false);
      GlobalSnackbar.showMessageUsingSnackBar(
          Shade.snackGlobalFailed, exception.toString(), context);
    }
  }

  List<Map<String, dynamic>> generateInvoiceDataFromApi(
      List<InvoiceSample> listOfInvoice) {
    List<Map<String, dynamic>> tempsInvoice = [];
    for (InvoiceSample invoice in listOfInvoice) {
      tempsInvoice.add({
        "id": invoice.id,
        "appointmentId": invoice.appointmentId,
        "patientId": invoice.patientId,
        "doctorId": invoice.doctorId,
        "receptionistId": invoice.receptionistId,
        "date": invoice.date.substring(0, 10),
        "checkupType": invoice.checkupType,
        "checkupFee": invoice.checkupFee,
        "paymentType": invoice.paymentType,
        "disposibles": invoice.disposibles,
        "grossAmount": invoice.grossAmount,
        "doctorSpecialityType": invoice.doctorSample.specialityType,
        "doctorFirstName": invoice.doctorSample.user.firstName,
        "doctorLastName": invoice.doctorSample.user.lastName,
        "doctorContact": invoice.doctorSample.user.contact,
        "receiptId": invoice.receiptSample.id,
        "receiptPmid": invoice.receiptSample.pmid,
        "receiptDiscount": invoice.receiptSample.discount,
        "receiptTotalAmount": invoice.receiptSample.totalAmount,
        "receiptPendingAmount": invoice.receiptSample.pendingAmount,
        "receiptPaidAmount": invoice.receiptSample.paidAmount,
        "patientFirstName": invoice.patientSample.user.firstName,
        "patientLastName": invoice.patientSample.user.lastName,
        "patientContact": invoice.patientSample.user.contact,
        "patientEmergencyContact": invoice.patientSample.user.emergencyContact,
      });
      return tempsInvoice;
    }
  }

  void initHeadersOfInvoiceTable() {
    invoiceHeaders = [
      DatatableHeader(
          value: "id",
          show: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Id",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "appointmentId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "appointmentId",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Patient Id",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Doctor Id",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receptionistId",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receptionistId",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "date",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "Date",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "checkupType",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "checkupType",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "checkupFee",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "checkupFee",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "paymentType",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "paymentType",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "disposibles",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "disposibles",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "grossAmount",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "grossAmount",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorSpecialityType",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "doctorSpecialityType",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorFirstName",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "doctorFirstName",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorLastName",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "doctorLastName",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "doctorContact",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "doctorContact",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptId",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptId",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptPmid",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptPmid",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptDiscount",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptDiscount",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptTotalAmount",
          show: true,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptTotalAmount",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptPendingAmount",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptPendingAmount",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "receiptPaidAmount",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "receiptPaidAmount",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientFirstName",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "patientFirstName",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientLastName",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "patientLastName",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientContact",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "patientContact",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "patientEmergencyContact",
          show: false,
          flex: 1,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: QPadding.tableHeaders,
              child: Center(
                child: Text(
                  "patientEmergencyContact",
                  style: QTextStyle.tableHeaders,
                ),
              ),
            );
          }),
    ];
  }

  FutureOr onGoBack(dynamic value) {
    checkTokenValidityAndGetInvoice();
  }

  Future<void> onCallingDeleteInvoice(int id) async {
    Navigator.pop(context);
    globalProgressDialog.showSimpleFontellicoProgressDialog(false,
        Strings.dialogDeleting, SimpleFontelicoProgressDialogType.multilines);

    try {
      bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
      if (hasToken) {
        InvoiceResponse serviceResponse = await invoiceService.deleteInvoice(
            id, context.read<TokenProvider>().tokenSample.jwtToken);
        if (serviceResponse != null) {
          if (serviceResponse.isSuccess) {
            checkTokenValidityAndGetInvoice();
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

  // Future<void> onChangedSearchedValue(String search) async {
  //   if (!invoiceIsLoading) {
  //     bool hasToken = await GlobalRefreshToken.hasValidTokenToSend(context);
  //     if (hasToken) {
  //       InvoiceResponseList invoiceResponse =
  //           await invoiceService.PostInvoiceBySearch(
  //               InvoiceSearchRequest(
  //                 search: search,
  //                 fromDate: _tecFromDate.text,
  //                 toDate: _tecToDate.text,
  //               ),
  //               context.read<TokenProvider>().tokenSample.jwtToken);
  //       if (invoiceResponse != null) {
  //         if (invoiceResponse.isSuccess) {
  //           invoiceIsSource = [];
  //           listInvoice = [];
  //           listInvoice = invoiceResponse.data;
  //           invoiceIsSource.addAll(generateInvoiceDataFromApi(listInvoice));
  //           setState(() {
  //             showSearchedList = false;
  //           });
  //         } else {
  //           GlobalSnackbar.showMessageUsingSnackBar(
  //               Shade.snackGlobalFailed, invoiceResponse.message, context);
  //         }
  //       } else {
  //         GlobalSnackbar.showMessageUsingSnackBar(
  //             Shade.snackGlobalFailed, Strings.errorNull, context);
  //         globalProgressDialog.hideSimpleFontellicoProgressDialog();
  //       }
  //     } else {
  //       GlobalSnackbar.showMessageUsingSnackBar(
  //           Shade.snackGlobalFailed, Strings.errorToken, context);
  //       globalProgressDialog.hideSimpleFontellicoProgressDialog();
  //       setState(() {
  //         showSearchedList = false;
  //       });
  //     }
  //   }
  // }

  Widget widgetInvoicePatients() {
    return Card(
      elevation: 1,
      shadowColor: Colors.black,
      clipBehavior: Clip.none,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            widgetSelectDate(),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(0),
              constraints: BoxConstraints(
                maxHeight: 500,
              ),
              child: ResponsiveDatatable(
                actions: [
                  widgetSearch(),
                ],
                headers: invoiceHeaders,
                source: !showSearchedList ? invoiceIsSource : invoiceIsSearched,
                selecteds: InvoiceSelecteds,
                showSelect: invoiceShowSelect,
                autoHeight: false,
                onTabRow: (data) {
                  print(data);
                },
                onSort: (value) {
                  setState(() {
                    invoiceSortColumn = value;
                    invoiceSortAscending = !invoiceSortAscending;
                    if (invoiceSortAscending) {
                      invoiceIsSource.sort((a, b) => b["$invoiceSortColumn"]
                          .compareTo(a["$invoiceSortColumn"]));
                    } else {
                      invoiceIsSource.sort((a, b) => a["$invoiceSortColumn"]
                          .compareTo(b["$invoiceSortColumn"]));
                    }
                  });
                },
                sortAscending: invoiceSortAscending,
                sortColumn: invoiceSortColumn,
                isLoading: invoiceIsLoading,
                onSelect: (value, item) {
                  print("$value  $item ");
                  if (value) {
                    setState(() => InvoiceSelecteds.add(item));
                  } else {
                    setState(() => InvoiceSelecteds.removeAt(
                        InvoiceSelecteds.indexOf(item)));
                  }
                },
                onSelectAll: (value) {
                  if (value) {
                    setState(() => InvoiceSelecteds =
                        invoiceIsSource.map((entry) => entry).toList().cast());
                  } else {
                    setState(() => InvoiceSelecteds.clear());
                  }
                },
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
          onChanged: (value) => getInvoiceFromApiAndLinkToTable(value),
        ),
      ),
    ));
  }

  Widget widgetSelectDate() {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Container(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      cursorColor: Colors.grey[600],
                      readOnly: true,
                      controller: _tecFromDate,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]),
                        ),
                        focusColor: Colors.grey[600],
                        labelText: 'From Date',
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.date_range_outlined,
                                color: Colors.grey[600],
                              ),
                              onPressed: () => _pickDate(
                                  context: context,
                                  dateType: searchDateType.fromDate,
                                  firstDate: DateTime(DateTime.now().month - 1),
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime.now(),
                                  tecDate: _tecFromDate),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.clear_outlined,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () {
                                  _tecFromDate.text = '';
                                }),
                          ],
                        ),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[600],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        )),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: Container(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: TextFormField(
                      cursorColor: Colors.grey[600],
                      readOnly: true,
                      controller: _tecToDate,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]),
                        ),
                        focusColor: Colors.grey[600],
                        labelText: 'To Date',
                        suffixIcon: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.date_range_outlined,
                                color: Colors.grey[600],
                              ),
                              onPressed: () => _pickDate(
                                  context: context,
                                  dateType: searchDateType.fromDate,
                                  firstDate: DateTime(DateTime.now().month - 1),
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime.now(),
                                  tecDate: _tecToDate),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.clear_outlined,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () {
                                  _tecToDate.text = '';
                                }),
                          ],
                        ),
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.grey[600],
                        ),
                      ),
                    )),
              ),
            ),
          ],
        )),
      ],
    );
  }

  Future<void> _pickDate({
    @required initialDate,
    @required firstDate,
    @required lastDate,
    @required dateType,
    @required context,
    @required TextEditingController tecDate,
  }) async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (date != null) {
      if (dateType == searchDateType.fromDate) {
        tecDate.text = date.toString().substring(0, 10);
        _tecFromDate.text = tecDate.text;
      } else if (dateType == searchDateType.toDate) {
        tecDate.text = date.toString().substring(0, 10);
        _tecToDate.text = tecDate.text;
      }
    }
  }
}
