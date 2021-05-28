import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Service/RoomService.dart';
import 'package:flutter/material.dart';

import 'package:baby_doctor/Models/Room.dart';

class EditRoom extends StatefulWidget {

  @override
  _EditRoomState createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  @override
  final formKey = GlobalKey<FormState>();
  String Id;
  String  RoomNo;
  String  RoomType;
  int  RoomCapacity;
  double  RoomCharges;
  bool isLoading = false;
  bool loadingButtonProgressIndicator = false;
  RoomService roomservice;
  TextEditingController _roomnocontroller;
  TextEditingController _roomtypecontroller;
  TextEditingController _roomcapacitycontroller;
  TextEditingController _roomchargescontroller;

  dynamic arguments;
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleEditRoom),
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
                  padding: EdgeInsets.fromLTRB(
                      Dimens.globalPaddingLeft,
                      Dimens.globalPaddingTop,
                      Dimens.globalPaddingRight,
                      Dimens.globalPaddingBottom),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        if (!isLoading) widgetRoomNo(),
                        if (!isLoading) widgetRoomType(),
                        if (!isLoading)  widgetRoomCapacity(),
                        if (!isLoading) widgetRoomCharges(),
                        if (!isLoading) widgetSubmit(),
                        if (isLoading) widgetCircularProgress(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    arguments = ModalRoute.of(context).settings.arguments as Map;
    roomservice = RoomService();
    print( arguments["Id"]);
    if (arguments != null) {
      roomservice.getRoomById(arguments["Id"]).then((value) {
        setState(() {
          _roomnocontroller = new TextEditingController(text: value["roomNo"]);
         RoomType=value["roomType"];
          _roomcapacitycontroller =  new TextEditingController(text: value["roomCapacity"].toString());
          _roomchargescontroller =   new TextEditingController(text: value["roomCharges"].toString());
          isLoading = false;
        });

      });
    }
  }
  Widget widgetRoomNo() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 30,
            controller: _roomnocontroller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.fact_check),
                border: OutlineInputBorder(),
                labelText: 'Room No'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              RoomNo = value;
            },
          ),
        ),
      ],
    );
  }

  Widget widgetRoomType() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottomWithoutMaxLength),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: RoomType,
                elevation: 16,
                underline: Container(
                  height: 0,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    RoomType = newValue;
                  });
                },
                items: <String>[
                  'Choose Room Type',
                  'Room Type 1',
                  'Room Type 2',
                  'Other',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget widgetRoomCharges() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 5,
            controller: _roomcapacitycontroller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(),
                labelText: 'Room Charges'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              if (double.tryParse(value) <= 0) {
                return 'Input Error: cannot enter negative digits';
              }
              return null;
            },
            onSaved: (String value) {
              RoomCharges = double.parse(value);
            },
          ),
        ),
      ],
    );
  }
  Widget widgetRoomCapacity() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
              Dimens.globalInputFieldleft,
              Dimens.globalInputFieldTop,
              Dimens.globalInputFieldRight,
              Dimens.globalInputFieldBottom),
          child: TextFormField(
            autofocus: false,
            maxLength: 5,
            controller: _roomchargescontroller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(),
                labelText: 'Room Capacity'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              if (double.tryParse(value) <= 0) {
                return 'Input Error: cannot enter negative digits';
              }
              return null;
            },
            onSaved: (String value) {
              RoomCapacity = int.parse(value);
            },
          ),
        ),
      ],
    );
  }
  Widget widgetSubmit() {
    return Column(
      children: [
        loadingButtonProgressIndicator == false
            ? Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                Dimens.globalInputFieldleft,
                Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight,
                Dimens.globalInputFieldBottom),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                primary: Shade.submitButtonColor,
                minimumSize: Size(double.infinity, 45),
                padding:
                EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              child: Text(Strings.submitGlobal),
              onPressed: () {
                onPressedSubmitButton();
              },
            ),
          ),
        )
            : Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
  Widget widgetCircularProgress() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                width: 10,
              ),
              Text('Please wait...'),
            ],
          ),
        ],
      ),
    );
  }

  onPressedSubmitButton() async {
    if (!formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Text('Error: Some input fields are not filled')));
      return;
    }
    setState(() {
      loadingButtonProgressIndicator = true;
    });
    formKey.currentState.save();

    Room obj = new Room(
      id:arguments["Id"],
      RoomNo:  RoomNo,
      RoomType:  RoomType,
      RoomCapacity:  RoomCapacity,
      RoomCharges:  RoomCharges,
    );
    var response = await roomservice.UpdateRoom(obj);
    print(response);
    if (response == true) {
      setState(() {
        loadingButtonProgressIndicator = false;

      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalSuccess,
          content: Row(
            children: [

              Text('Success:Room Updated'),
              Text(
                RoomNo,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
      formKey.currentState.reset();
      Navigator.pushNamed(context, Strings.routeRoomList,arguments:{'Id': Id});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Shade.snackGlobalFailed,
          content: Row(
            children: [
              Text('Error: Try Again: Failed to edit '),
              Text(
                RoomNo,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          )));
      setState(() {
        loadingButtonProgressIndicator = false;
      });
    }
  }
}
