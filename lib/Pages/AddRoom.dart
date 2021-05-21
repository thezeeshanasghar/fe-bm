import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:baby_doctor/Models/Room.dart';
import 'package:baby_doctor/Service/RoomService.dart' as DAL;
class AddRoom extends StatefulWidget {
  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  @override
  final formKey = GlobalKey<FormState>();
  String RoomNo;
  String RoomType='Choose Room Type';
  double RoomCapacity;
  double Charges;
  bool Isloading=false;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text(Strings.titleAddRoom),
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
                        widgetroomNo(),
                        widgetRoomType(),
                        widgetCapacity(),
                        widgetCharges(),
                        widgetSubmit()
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

  Widget widgetroomNo() {
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
            maxLength: 6,
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

  Widget widgetCapacity() {
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
            maxLength: 2,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.fact_check),
                border: OutlineInputBorder(),
                labelText: 'Room Capacity'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              RoomCapacity =double.parse(value);
            },
          ),
        ),
      ],
    );
  }

  Widget widgetCharges() {
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
            maxLength: 4,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(),
                labelText: 'Room Charges(Per Hour)'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              Charges = double.parse(value);
            },
          ),
        ),
      ],
    );
  }

  Widget widgetSubmit() {
    return Column(
      children: [
        Align(
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
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              child: Text('Submit'),
              onPressed: () {

                onClickDataPost();
              },
            ),
          ),
        ),
      ],
    );
  }

  onClickDataPost()  async {
    if (!formKey.currentState.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Some input fields are not filled.')));
      return;
    }
    setState((){Isloading = true;});
    formKey.currentState.save();

    //perform your task after save
    DAL.RoomService service =  new DAL.RoomService();
    Room obj = new Room(
        RoomNo: RoomNo,
        RoomType: RoomType,
        Charges : Charges,
        RoomCapacity: RoomCapacity,
    );
    var response= await service.InsertRoom(obj);
    print(response);
    if(response==true)
    {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Success: Record Added Successfully.')));
      formKey.currentState.reset();
      setState((){Isloading = false;});
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: Operation Unsuccessfull.')));
      setState((){Isloading = false;});
    }
  }
}
