import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:flutter/material.dart';

class ReceptionistList extends StatefulWidget {
  @override
  _ReceptionistListState createState() => _ReceptionistListState();
}

class _ReceptionistListState extends State<ReceptionistList> {
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
      backgroundColor: Shade.globalBackgroundColor,
      appBar: AppBar(
        title: Text("Receptionist List"),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[],
                      ),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
