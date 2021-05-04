import 'package:flutter/material.dart';

class NurseShare extends StatefulWidget {
  @override
  _NurseShareState createState() => _NurseShareState();
}

class _NurseShareState extends State<NurseShare> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Share"),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: NurseShareForm(),
    );
  }
}

class NurseShareForm extends StatefulWidget {
  @override
  _NurseShareFormState createState() => _NurseShareFormState();
}

class _NurseShareFormState extends State<NurseShareForm> {
  final formKey = GlobalKey<FormState>();

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
            DataTable(
              columns: [
                DataColumn(
                    label: Expanded(
                      child: Text('Service',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Medication',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Time',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Share Percentage',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    )),
                DataColumn(
                    label: Expanded(
                      child: Text('Total Price',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
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
                  DataCell(Text("IV Injection"), onTap: () {}),
                  DataCell(Text("Azithromycin"), onTap: () {}),
                  DataCell(Text("10:34 am"), onTap: () {}),
                  DataCell(Text("20%"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("IV Injection"), onTap: () {}),
                  DataCell(Text("Azithromycin"), onTap: () {}),
                  DataCell(Text("10:34 am"), onTap: () {}),
                  DataCell(Text("20%"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("IV Injection"), onTap: () {}),
                  DataCell(Text("Azithromycin"), onTap: () {}),
                  DataCell(Text("10:34 am"), onTap: () {}),
                  DataCell(Text("20%"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("IV Injection"), onTap: () {}),
                  DataCell(Text("Azithromycin"), onTap: () {}),
                  DataCell(Text("10:34 am"), onTap: () {}),
                  DataCell(Text("20%"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("IV Injection"), onTap: () {}),
                  DataCell(Text("Azithromycin"), onTap: () {}),
                  DataCell(Text("10:34 am"), onTap: () {}),
                  DataCell(Text("20%"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text("IV Injection"), onTap: () {}),
                  DataCell(Text("Azithromycin"), onTap: () {}),
                  DataCell(Text("10:34 am"), onTap: () {}),
                  DataCell(Text("20%"), onTap: () {}),
                  DataCell(Text("Rs. 300"), onTap: () {}),
                  DataCell(Text("Rs. 60"), onTap: () {}),
                ]),
                DataRow(cells: [
                  DataCell(Text(""), onTap: () {}),
                  DataCell(Text(""), onTap: () {}),
                  DataCell(Text(""), onTap: () {}),
                  DataCell(
                      Text("April 29, 2021",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan[600],
                          )),
                      onTap: () {}),
                  DataCell(
                      Text(
                        "Rs. 900",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan[600],
                        ),
                      ),
                      onTap: () {}),
                  DataCell(
                      Text(
                        "Rs. 180",
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
}
