import 'package:flutter/material.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:image_picker/image_picker.dart';

class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Add Invoice"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: ServiceForm(),
    );
  }
}

class ServiceForm extends StatefulWidget {
  @override
  _ServiceFormState createState() => _ServiceFormState();

}

class _ServiceFormState extends State<ServiceForm> {
  @override
  final InvoiceFormKey = GlobalKey<FormState>();
  final DateFromController = TextEditingController();
  final DateToController = TextEditingController();
  DateTime DateFrom;
  DateTime DateTo;
  String InvoiceType;
  int UserId;
  double Charges;
  DateTime AppointmentDate;
  String FirstName;
  String LastName;
  String Doctor;
  String AppointmentType;

  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.minHeight,
              ),
              child: Form(
                key: InvoiceFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[

                    Column(
                      children: [
                        widgetDateFrom(),
                        widgetDateTo(),
                        widgetInvoiceType(),
                        widgetUserId(),
                        widgetAmount(),
                        widgetFirstName(),
                        widgetLastName(),
                        widgetDoctor(),
                        widgetAppointmentType(),
                        widgetSubmit()
                      ],

                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget widgetDateFrom() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: DateFromController,
            decoration: InputDecoration(
              icon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Date From',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              DateFrom = DateTime.parse(value);
            },
            onTap: () {
              pickDateFrom();
            },
          ),
        ),
      ],
    );
  }
  pickDateFrom() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        DateFrom = date;
        DateFromController.text = DateFrom.toString();
      });
    }
  }
  Widget widgetInvoiceType(){
    return Column(
        children: [
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    child:DropdownButton<String>(
      focusColor:Colors.white,
      icon: Icon(Icons.list_alt_outlined),
      value: InvoiceType,
      //elevation: 5,
      style: TextStyle(color: Colors.white),
      iconEnabledColor:Colors.black,
    isExpanded:true,

      items: <String>[
        'Payment',
        'Refund'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value,style:TextStyle(color:Colors.black)),
        );
      }).toList(),
      hint:Text(
        "Please choose a Invoice Type",
        style: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
      onChanged: (String value) {
        setState(() {
          InvoiceType = value;
        });
      },
    )
    )]
    );
  }
  Widget widgetDateTo() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: DateToController,
            decoration: InputDecoration(
              icon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Date To',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              DateTo = DateTime.parse(value);
            },
            onTap: () {
              pickDateTo();
            },
          ),
        ),
      ],
    );
  }
  pickDateTo() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        DateFrom = date;
        DateToController.text = DateFrom.toString();
      });
    }
  }
  Widget widgetUserId() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 4,
            decoration: InputDecoration(
                icon: Icon(Icons.verified_user),
                border: OutlineInputBorder(),
                labelText: 'User Id'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              UserId = int.parse(value);
            },
          ),
        ),
      ],
    );
  }
  Widget widgetAmount() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 4,
            decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                border: OutlineInputBorder(),
                labelText: 'Amount'),
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
  Widget widgetFirstName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 4,
            decoration: InputDecoration(
                icon: Icon(Icons.verified_user),
                border: OutlineInputBorder(),
                labelText: 'First Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              FirstName = value;
            },
          ),
        ),
      ],
    );
  }
  Widget widgetLastName() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            autofocus: false,
            maxLength: 4,
            decoration: InputDecoration(
                icon: Icon(Icons.verified_user),
                border: OutlineInputBorder(),
                labelText: 'Last Name'),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
              return null;
            },
            onSaved: (String value) {
              LastName = value;
            },
          ),
        ),
      ],
    );
  }
  Widget widgetDoctor(){
    return Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child:DropdownButton<String>(
                focusColor:Colors.white,
                icon: Icon(Icons.list_alt_outlined),
                value: Doctor,
                //elevation: 5,
                style: TextStyle(color: Colors.white),
                iconEnabledColor:Colors.black,
                isExpanded:true,

                items: <String>[
                  'Abdul Basit',
                  'Anees'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style:TextStyle(color:Colors.black)),
                  );
                }).toList(),
                hint:Text(
                  "Please choose a Doctor",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                onChanged: (String value) {
                  setState(() {
                    Doctor = value;
                  });
                },
              )
          )]
    );
  }
  Widget widgetAppointmentType(){
    return Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child:DropdownButton<String>(
                focusColor:Colors.white,
                icon: Icon(Icons.list_alt_outlined),
                value: AppointmentType,
                //elevation: 5,
                style: TextStyle(color: Colors.white),
                iconEnabledColor:Colors.black,
                isExpanded:true,

                items: <String>[
                  'Consultation'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,style:TextStyle(color:Colors.black)),
                  );
                }).toList(),
                hint:Text(
                  "Please choose a Appointment Type",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                onChanged: (String value) {
                  setState(() {
                    AppointmentType = value;
                  });
                },
              )
          )]
    );
  }
  Widget widgetSubmit() {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                textStyle: TextStyle(fontSize: 20),
              ),
              child: Text('Submit'),
              onPressed: () {
                if (!InvoiceFormKey.currentState.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content:
                      Text('Error: Some input fields are not filled.')));
                  return;
                }
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Successfull')));
                InvoiceFormKey.currentState.save();
              },
            ),
          ),
        ),
      ],
    );
  }

}
