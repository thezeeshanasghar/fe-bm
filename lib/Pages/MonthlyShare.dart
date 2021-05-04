import 'package:flutter/material.dart';

class MonthlyShare extends StatefulWidget {
  @override
  _MonthlyShareState createState() => _MonthlyShareState();
}

class _MonthlyShareState extends State<MonthlyShare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Monthly Share"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: MonthlyShareForm(),
    );
  }
}

class MonthlyShareForm extends StatefulWidget {
  @override
  _MonthlyShareFormState createState() => _MonthlyShareFormState();
}

class _MonthlyShareFormState extends State<MonthlyShareForm> {
  final formKey = GlobalKey<FormState>();
  DateTime StartDate;
  final startDateController = TextEditingController();
  DateTime EndDate;
  final endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            widgetStartDate(),
            widgetEndDate(),
            DataTable(
              columns: [
                DataColumn(
                    label: Expanded(
                  child: Text('Date',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                )),
                DataColumn(
                    label: Expanded(
                  child: Text('Total Price',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                )),
                DataColumn(
                    label: Expanded(
                  child: Text('Your Share',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                )),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text("April 24, 2021"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("April 25, 2021"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("April 26, 2021"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("April 27, 2021"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("April 28, 2021"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("April 31, 2021"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(
                      Text("",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan[600],
                          )),
                      onTap: () {}),
                  DataCell(
                      Text(
                        "Rs. 2400",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan[600],
                        ),
                      ),
                      onTap: () {}),
                  DataCell(
                      Text(
                        "Rs. 480",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan[600],
                        ),
                      ),
                      onTap: () {}),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget widgetStartDate() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: startDateController,
            decoration: InputDecoration(
              icon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'Start Date',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              StartDate = DateTime.parse(value);
            },
            onTap: () {
              pickStartDate();
            },
          ),
        ),
      ],
    );
  }

  Widget widgetEndDate() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: TextFormField(
            controller: endDateController,
            decoration: InputDecoration(
              icon: Icon(Icons.date_range),
              border: OutlineInputBorder(),
              labelText: 'End Date',
            ),
            validator: (String value) {
              if (value == null || value.isEmpty) {
                return 'This field cannot be empty';
              }
            },
            onSaved: (String value) {
              EndDate = DateTime.parse(value);
            },
            onTap: () {
              pickEndDate();
            },
          ),
        ),
      ],
    );
  }

  pickStartDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        StartDate = date;
        startDateController.text = StartDate.toString();
      });
    }
  }

  pickEndDate() async {
    DateTime date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 1),
        lastDate: DateTime(DateTime.now().year + 1));
    if (date != null) {
      setState(() {
        EndDate = date;
        endDateController.text = EndDate.toString();
      });
    }
  }
}
