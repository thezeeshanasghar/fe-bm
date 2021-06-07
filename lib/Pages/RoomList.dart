import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Room.dart';
import 'package:baby_doctor/Service/RoomService.dart';
import 'package:flutter/material.dart';
import 'package:responsive_table/DatatableHeader.dart';
import 'package:responsive_table/ResponsiveDatatable.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class RoomList extends StatefulWidget {
  @override
  _RoomListState createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  final formKey = GlobalKey<FormState>();

  int roomTotal;
  int roomCurrentPerPage;
  int roomCurrentPage;
  bool roomIsSearch;
  String roomSelectableKey;
  String roomSortColumn;
  bool roomSortAscending;
  bool roomIsLoading;
  bool roomShowSelect;
  bool showSearchedList;

  List<DatatableHeader> roomHeaders;
  List<int> roomPerPage;
  List<Map<String, dynamic>> roomIsSource;
  List<Map<String, dynamic>> roomIsSearched;
  List<Map<String, dynamic>> roomSelecteds;
  List<Room> listrooms;

  RoomService roomService;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
    initHeadersOfRoomTable();
    getroomsFromApiAndLinkToTable();
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
                          children: <Widget>[widgetroomPatients()],
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

  void initVariablesAndClasses() {
    roomHeaders = [];
    roomPerPage = [5, 10, 15, 100];
    roomTotal = 100;
    roomCurrentPerPage;
    roomCurrentPage = 1;
    roomIsSearch = false;
    roomIsSource = [];
    roomIsSearched = [];
    roomSelecteds = [];
    roomSelectableKey = "Invoice";
    roomSortColumn;
    roomSortAscending = true;
    roomIsLoading = true;
    roomShowSelect = false;
    listrooms = [];
    showSearchedList = false;

    roomService = RoomService();
  }

  void getroomsFromApiAndLinkToTable() async {
    setState(() => roomIsLoading = true);
    listrooms = [];
    roomIsSource = [];
    listrooms = await roomService.getRooms();
    roomIsSource.addAll(generateRoomDataFromApi(listrooms));
    setState(() => roomIsLoading = false);
  }

  List<Map<String, dynamic>> generateRoomDataFromApi(
      List<Room> listOfRooms) {
    List<Map<String, dynamic>> tempsroom = [];
    for (Room rooms in listOfRooms) {
      tempsroom.add({
        "Id": rooms.id,
        "RoomNo": rooms.RoomNo,
        "RoomType": rooms.RoomType,
        "RoomCapacity": rooms.RoomCapacity,
        "RoomCharges": rooms.RoomCharges,
        "Action": rooms.id,
      });
    }
    return tempsroom;
  }

  List<Map<String, dynamic>> generateRoomSearchData(
      Iterable<Map<String, dynamic>> iterableList) {
    List<Map<String, dynamic>> tempsroom = [];
    for (var iterable in iterableList) {
      tempsroom.add({
        "Id": iterable["Id"],
        "RoomNo": iterable["RoomNo"],
        "RoomType": iterable["RoomType"],
        "RoomCapacity": iterable["RoomCapacity"],
        "RoomCharges": iterable["RoomCharges"],
        "Action": iterable["Action"],
      });
    }
    return tempsroom;
  }

  void initHeadersOfRoomTable() {
    roomHeaders = [
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
          value: "RoomNo",
          show: true,
          flex: 2,
          sortable: false,
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
          sortable: false,
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
          sortable: false,
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
          sortable: false,
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
    print(Id);
    Navigator.pushNamed(context, Strings.routeEditRoom,arguments:{'Id': Id});
    print(Id);
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
        roomService.Deleteroom(Id).then((response) {
          if (response == true) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalSuccess,
                content: Row(
                  children: [
                    Text('Success: Deleted room '),
                    Text(
                      row['RoomNo'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )));
            getroomsFromApiAndLinkToTable();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Shade.snackGlobalFailed,
                content: Row(
                  children: [
                    Text('Error: Try Again: Failed to delete Room '),
                    Text(
                      row['RoomNo'],
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
            row['RoomNo'] + ' ?',
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
    if (!roomIsLoading) {
      if (value.isNotEmpty) {
        if (value.length >= 2) {
          var searchList = roomIsSource.where((element) {
            String searchById = element["Id"].toString().toLowerCase();
            String searchByRoomNo = element["RoomNo"].toString().toLowerCase();
            String searchByRoomType =
            element["RoomType"].toString().toLowerCase();
            String searchByCharges =
            element["RoomCharges"].toString().toLowerCase();
            String searchByCapacity =
            element["RoomCapacity"].toString().toLowerCase();
            if (searchById.contains(value.toLowerCase()) ||
                searchByRoomNo.contains(value.toLowerCase()) ||
                searchByRoomType.contains(value.toLowerCase()) ||
                searchByCharges.contains(value.toLowerCase()) ||
                searchByCapacity.contains(value.toLowerCase())) {
              return true;
            } else {
              return false;
            }
          });
          roomIsSearched = [];
          roomIsSearched.addAll(generateRoomSearchData(searchList));
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

  Widget widgetroomPatients() {
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
                              hintText: 'Search room'),
                          onChanged: (value) => onChangedSearchedValue(value),
                        )),
                  ],
                  headers: roomHeaders,
                  source: !showSearchedList
                      ? roomIsSource
                      : roomIsSearched,
                  selecteds: roomSelecteds,
                  showSelect: roomShowSelect,
                  autoHeight: false,
                  onTabRow: (data) {
                    print(data);
                  },
                  onSort: (value) {
                    setState(() {
                      roomSortColumn = value;
                      roomSortAscending = !roomSortAscending;
                      if (roomSortAscending) {
                        roomIsSource.sort((a, b) =>
                            b["$roomSortColumn"]
                                .compareTo(a["$roomSortColumn"]));
                      } else {
                        roomIsSource.sort((a, b) =>
                            a["$roomSortColumn"]
                                .compareTo(b["$roomSortColumn"]));
                      }
                    });
                  },
                  sortAscending: roomSortAscending,
                  sortColumn: roomSortColumn,
                  isLoading: roomIsLoading,
                  onSelect: (value, item) {
                    print("$value  $item ");
                    if (value) {
                      setState(() => roomSelecteds.add(item));
                    } else {
                      setState(() => roomSelecteds
                          .removeAt(roomSelecteds.indexOf(item)));
                    }
                  },
                  onSelectAll: (value) {
                    if (value) {
                      setState(() => roomSelecteds = roomIsSource
                          .map((entry) => entry)
                          .toList()
                          .cast());
                    } else {
                      setState(() => roomSelecteds.clear());
                    }
                  },
                ),
              ),
            ),
          ]),
    );
  }
}
