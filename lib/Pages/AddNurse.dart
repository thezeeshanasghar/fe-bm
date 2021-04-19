import 'package:flutter/material.dart';

class AddNurse extends StatefulWidget {
  @override
  _AddNurseState createState() => _AddNurseState();
}

class _AddNurseState extends State<AddNurse> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Add Nurse';
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(appTitle),
        centerTitle: false,
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      body: NurseForm(),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class NurseForm extends StatefulWidget {
  @override
  _NurseFormState createState() => _NurseFormState();
}

class _NurseFormState extends State<NurseForm> {
  List formList() {
    List<Widget> formItems = List.filled(5, Container(), growable: true);
    formItems.add(Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
          )
        ],
      ),
    ));

    formItems.add(Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
        ],
      ),
    ));

    formItems.add(Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
        ],
      ),
    ));

    formItems.add(Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
        ],
      ),
    ));

    formItems.add(Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
        ],
      ),
    ));


    formItems.add(Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
        ],
      ),
    ));


    formItems.add(Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
        ],
      ),
    ));

    formItems.add(Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
        ],
      ),
    ));

    formItems.add(Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
        ],
      ),
    ));

    formItems.add(Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
        ],
      ),
    ));

    formItems.add(Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: 'First Name'),
            ),
          ),
        ],
      ),
    ));

    return formItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [SliverList(delegate: SliverChildListDelegate(formList()))],
    ));
  }
}
