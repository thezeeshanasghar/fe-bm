import 'package:flutter/material.dart';

class Invoice extends StatefulWidget {
  @override
  _InvoiceState createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide; // get the shortest side of device
    final bool useMobileLayout = shortestSide < 650.0; // check for tablet
    final Orientation orientation = MediaQuery.of(context).orientation; // get the orientation

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Add Invoice"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body:gridviewForPhone()
    );
  }
}

gridviewForPhone() {
  return Padding(
    padding: EdgeInsets.all(5.0),
    child: GridView.count(
      crossAxisCount: 1,
      childAspectRatio: 1.0,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      children: [
        ServiceForm()
      ],
    ),
  );
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
  final DateController = TextEditingController();
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
  DateTime Date;
  Widget build(BuildContext context) {
    return
      Container(
          child: LayoutBuilder(
             builder: (BuildContext context, BoxConstraints viewportConstraints)
    {
     return Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.30, child: widgetDateFrom()),
              SizedBox(width: MediaQuery.of(context).size.width * 0.30, child: widgetDateTo()),
              SizedBox(width: MediaQuery.of(context).size.width * 0.30, child: widgetInvoiceType()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.47, child: widgetUserId()),
              SizedBox(width: MediaQuery.of(context).size.width * 0.47, child: widgetAmount()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.47, child: widgetFirstName()),
              SizedBox(width: MediaQuery.of(context).size.width * 0.47, child: widgetLastName()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.97, child: widgetDate()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.47, child: widgetDoctor()),
              SizedBox(width: MediaQuery.of(context).size.width * 0.47, child: widgetAppointmentType()),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: MediaQuery.of(context).size.width * 0.97, child: widgetSubmit()),
            ],
          )
        ],


      );
    }
    ));
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
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey[300])),
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: InvoiceType,
                      elevation: 16,
                      underline: Container(
                        height: 0,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          InvoiceType = newValue;
                        });
                      },
                      items: <String>[
                        'Select Type',
                        'Payment',
                        'Return'
                      ].map<DropdownMenuItem<String>>(
                              (String value) {
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
          ),
        ));
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
        DateTo = date;
        DateToController.text = DateFrom.toString();
      });
    }
  }
  Widget widgetDate(){
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: DateController,
            decoration: InputDecoration(
              icon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Date',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              Date = DateTime.parse(value);
            },
            onTap: () {
              pickDate();
            },
          ),
        ),
      ],
    );
  }
  pickDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        Date = date;
        DateController.text = DateFrom.toString();
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
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    'Doctor',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey[300])),
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: Doctor,
                      elevation: 16,
                      underline: Container(
                        height: 0,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          Doctor = newValue;
                        });
                      },
                      items: <String>[
                        'Select Doctor',
                        'Dr. Salman',
                        'Dr. Faisal',
                        'Dr. Nawaz',
                        'Dr. Sadia'
                      ].map<DropdownMenuItem<String>>(
                              (String value) {
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
          ),
        ));
  }
  Widget widgetAppointmentType(){
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  Text(
                    'Appintment Type',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey[300])),
                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: AppointmentType,
                      elevation: 16,
                      underline: Container(
                        height: 0,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          AppointmentType = newValue;
                        });
                      },
                      items: <String>[
                        'Select Appointment',
                        'Consultation',

                      ].map<DropdownMenuItem<String>>(
                              (String value) {
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
          ),
        ));
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
