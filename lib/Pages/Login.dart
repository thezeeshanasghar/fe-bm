import 'package:baby_doctor/Design/Dimens.dart';
import 'package:baby_doctor/Design/Shade.dart';
import 'package:baby_doctor/Design/Strings.dart';
import 'package:baby_doctor/Models/Requests/AuthenticateRequest.dart';
import 'package:baby_doctor/Models/Requests/ServiceRequest.dart';
import 'package:baby_doctor/Models/Responses/AuthenticateResponse.dart';
import 'package:baby_doctor/Models/Responses/ServiceResponse.dart';
import 'package:baby_doctor/Providers/LoginCredentialsProvider.dart';
import 'package:baby_doctor/Providers/TokenProvider.dart';
import 'package:baby_doctor/Service/AuthenticationService.dart';
import 'package:baby_doctor/Service/Service.dart';
import 'package:baby_doctor/ShareArguments/GlobalArgs.dart';
import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  AuthenticationService authenticationService;
  SimpleFontelicoProgressDialog simpleFontelicoProgressDialog;

  String UserName;
  String Password;

  @override
  void initState() {
    super.initState();
    initVariablesAndClasses();
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
        title: Text(Strings.titleLogin),
        backgroundColor: Shade.globalAppBarColor,
        automaticallyImplyLeading: false,
      ),
      body: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(minHeight: viewportConstraints.minHeight, minWidth: viewportConstraints.minWidth),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(Dimens.globalPaddingLeft, Dimens.globalPaddingTop,
                        Dimens.globalPaddingRight, Dimens.globalPaddingBottom),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          widgetUserName(),
                          widgetPassword(),
                          widgetSubmit(),
                        ],
                      ),
                    )),
              ),
            );
          },
        ),
      ),
    );
  }

  void initVariablesAndClasses() {
    authenticationService = AuthenticationService();
  }

  Widget widgetUserName() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
            child: TextFormField(
              autofocus: false,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.supervised_user_circle), border: OutlineInputBorder(), labelText: 'User Name'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                UserName = value;
              },
            )),
      ],
    );
  }

  Widget widgetPassword() {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottomWithoutMaxLength),
            child: TextFormField(
              autofocus: false,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline_rounded), border: OutlineInputBorder(), labelText: 'Password'),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'This field cannot be empty';
                }
                return null;
              },
              onSaved: (String value) {
                Password = value;
              },
            )),
      ],
    );
  }

  Widget widgetSubmit() {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.globalInputFieldleft, Dimens.globalInputFieldTop,
                Dimens.globalInputFieldRight, Dimens.globalInputFieldBottom),
            child: ElevatedButton(
              autofocus: false,
              style: ElevatedButton.styleFrom(
                primary: Shade.submitButtonColor,
                minimumSize: Size(double.infinity, 45),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              child: Text('Submit'),
              onPressed: () => onPressedSubmitButton(),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> onPressedSubmitButton() async {
    // if (!formKey.currentState.validate()) {
    //   return;
    // }
    // formKey.currentState.save();

    AuthenticationService authenticationService = AuthenticationService();
    AuthenticateResponse authenticateResponse = await authenticationService
        .authenticateLogin(AuthenticateLoginRequest(UserName: 'ahmed@gmail.com', Password: 'ahmed'));
    if (authenticateResponse != null) {
      if (authenticateResponse.isSuccess) {
        context.read<TokenProvider>().setToken(authenticateResponse.token);
        context
            .read<LoginCredentialsProvider>()
            .setLoginCredentials(AuthenticateLoginRequest(UserName: 'basit@gmail.com', Password: 'basit'));
        Navigator.pop(context);
        Navigator.pushNamed(context, Strings.routeHomePage);
      } else {
        print(authenticateResponse.message);
      }
    } else {
      showMessageUsingSnackBar(Shade.snackGlobalFailed, 'Error: failed to call server');
    }
  }

  void showMessageUsingSnackBar(Color snackColor, String snackText) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: snackColor,
        content: Row(
          children: [
            Expanded(
              child: Text(
                snackText,
                style: TextStyle(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        )));
  }
}
