import 'package:baby_doctor/Models/Sample/TokenSample.dart';
import 'package:flutter/foundation.dart';

class TokenProvider with ChangeNotifier {
  TokenSample sample = TokenSample();

  TokenSample get tokenSample => sample;

  void setToken(TokenSample sample) {
    this.sample = sample;
    notifyListeners();
  }
}
