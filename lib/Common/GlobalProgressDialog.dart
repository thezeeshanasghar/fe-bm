import 'package:flutter/cupertino.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class GlobalProgressDialog {
  SimpleFontelicoProgressDialog simpleFontelicoProgressDialog;
  BuildContext context;

  GlobalProgressDialog(BuildContext context) {
    this.context = context;
  }

  void showSimpleFontellicoProgressDialog(
      bool hasBarrierDimisable, String message, SimpleFontelicoProgressDialogType type) {
    simpleFontelicoProgressDialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: hasBarrierDimisable);
    simpleFontelicoProgressDialog.show(message: message, type: type, width: MediaQuery.of(context).size.width - 50);
  }

  void hideSimpleFontellicoProgressDialog() async {
    simpleFontelicoProgressDialog.hide();
  }
}
