import 'package:flutter/material.dart';

enum ClockType { analog, digital }

class ClockTypeModel extends ChangeNotifier {
  var _clockType = ClockType.analog;

  void changeType(ClockType clockType) {
    _clockType = clockType;
    notifyListeners();
  }

  ClockType get clockType => _clockType;
}
