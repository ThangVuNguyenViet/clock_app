import 'package:clock_app/providers/clock_type_provider.dart';
import 'package:clock_app/screens/components/analog_clock/analog_clock.dart';
import 'package:clock_app/screens/components/digital_clock/digital_clock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ClockTypeModel>(builder: (context, model, child) {
      return SafeArea(
        child: model.clockType == ClockType.analog
            ? const AnalogClock()
            : DigitalClock(
                hourMinuteDigitTextStyle: TextStyle(
                  fontSize: 120,
                  color: Theme.of(context).colorScheme.primary,
                ),
                secondDigitTextStyle: TextStyle(
                  fontSize: 60,
                  color: Theme.of(context).textTheme.bodyText1?.color,
                ),
              ),
      );
    });
  }
}
