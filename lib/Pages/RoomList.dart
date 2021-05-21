import 'dart:math';

import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  final formKey = GlobalKey<FormState>();

  // roomList Data
  List<DatatableHeader> roomListHeaders = [];
  List<int> roomListPerPage = [5, 10, 15, 100];
  int roomListTotal = 100;
  int roomListCurrentPerPage;
  int roomListCurrentPage = 1;
  bool roomListIsSearch = false;
  List<Map<String, dynamic>> roomListIsSource = [];
  List<Map<String, dynamic>> roomListSelecteds = [];
  String roomListSelectableKey = "Invoice";
  String roomListSortColumn;
  bool roomListSortAscending = true;
  bool roomListIsLoading = true;
  bool roomListShowSelect = false;

  @override
  void initState() {
    super.initState();
    // roomList
    initializeroomListHeaders();
    roomListInitData();
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
          title: Text(Strings.titleRoomList),
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
                          children: <Widget>[widgetroomListPatients()],
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
            Navigator.pushNamed(context, Strings.routeAddRoom);
          },
          child: const Icon(Icons.add),
          backgroundColor: Shade.fabGlobalButtonColor,
        ));
  }

  Widget widgetroomListPatients() {
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
                  title: !roomListIsSearch
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
                    if (roomListIsSearch)
                      Expanded(
                          child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: IconButton(
                                icon: Icon(Icons.cancel),
                                onPressed: () {
                                  setState(() {
                                    roomListIsSearch = false;
                                  });
                                }),
                            suffixIcon: IconButton(
                                icon: Icon(Icons.search), onPressed: () {})),
                      )),
                    if (!roomListIsSearch)
                      IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              roomListIsSearch = true;
                            });
                          })
                  ],
                  headers: roomListHeaders,
                  source: roomListIsSource,
                  selecteds: roomListSelecteds,
                  showSelect: roomListShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      roomListSortColumn = value;
                      roomListSortAscending = !roomListSortAscending;
                      if (roomListSortAscending) {
                        roomListIsSource.sort((a, b) => b["$roomListSortColumn"]
                            .compareTo(a["$roomListSortColumn"]));
                      } else {
                        roomListIsSource.sort((a, b) => a["$roomListSortColumn"]
                            .compareTo(b["$roomListSortColumn"]));
                      }
                    });
                  },
                  sortAscending: roomListSortAscending,
                  sortColumn: roomListSortColumn,
                  isLoading: roomListIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => roomListSelecteds.add(item));
                    } else {
                      setState(() => roomListSelecteds
                          .removeAt(roomListSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => roomListSelecteds = roomListIsSource
                          .map((entry) => entry)
                          .toList()
                          .cast());
                    } else {
                      setState(() => roomListSelecteds.clear());
                    }
                  },
                  footers: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Rows per page:"),
                    ),
                    if (roomListPerPage != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: DropdownButton(
                            value: roomListCurrentPerPage,
                            items: roomListPerPage
                                .map((e) => DropdownMenuItem(
                                      child: Text("$e"),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                roomListCurrentPerPage = value;
                              });
                            }),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                          "$roomListCurrentPage - $roomListCurrentPerPage of $roomListTotal"),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16,
                      ),
                      onPressed: () {
                        setState(() {
                          roomListCurrentPage = roomListCurrentPage >= 2
                              ? roomListCurrentPage - 1
                              : 1;
                        });
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, size: 16),
                      onPressed: () {
                        setState(() {
                          roomListCurrentPage++;
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

  // roomList
  List<Map<String, dynamic>> roomListGenerateData({int n: 100}) {
    final List sourceroomList = List.filled(n, Random.secure());
    List<Map<String, dynamic>> tempsroomList = [];
    var i = roomListIsSource.length;
    print(i);
    for (var data in sourceroomList) {
      tempsroomList.add({
        "RoomNo": "RoomNo $i",
        "RoomType": "RoomType $i",
        "RoomCapacity": "RoomCapacity $i",
        "RoomCharges": "RoomCharges $i",
        "Action": [i, 100],
      });
      i++;
    }
    return tempsroomList;
  }

  roomListInitData() async {
    setState(() => roomListIsLoading = true);
    Future.delayed(Duration(seconds: 0)).then((value) {
      roomListIsSource.addAll(roomListGenerateData(n: 100));
      setState(() => roomListIsLoading = false);
    });
  }

  initializeroomListHeaders() {
    roomListHeaders = [
      DatatableHeader(
          value: "RoomNo",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Room No",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "RoomType",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Room Type",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "RoomCapacity",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Room Capacity",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          }),
      DatatableHeader(
          value: "RoomCharges",
          show: true,
          sortable: true,
          textAlign: TextAlign.center,
          headerBuilder: (value) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Room Charges",
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
