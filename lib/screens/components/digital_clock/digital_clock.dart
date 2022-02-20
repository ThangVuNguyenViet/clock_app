import 'dart:async';

import 'package:clock_app/helpers/clock_helper.dart';
import 'package:clock_app/screens/components/change_theme_icon_button.dart';
import 'package:flutter/material.dart';

import '../spinner_widget.dart';
import 'clock_model.dart';

class DigitalClock extends StatefulWidget {
  const DigitalClock({
    Key? key,
    this.is24HourTimeFormat,
    this.showSecondsDigit,
    this.hourMinuteDigitDecoration,
    this.secondDigitDecoration,
    this.digitAnimationStyle,
    this.hourMinuteDigitTextStyle,
    this.secondDigitTextStyle,
    this.amPmDigitTextStyle,
  }) : super(key: key);

  final bool? is24HourTimeFormat;
  final bool? showSecondsDigit;
  final BoxDecoration? hourMinuteDigitDecoration;
  final BoxDecoration? secondDigitDecoration;
  final Curve? digitAnimationStyle;
  final TextStyle? hourMinuteDigitTextStyle;
  final TextStyle? secondDigitTextStyle;
  final TextStyle? amPmDigitTextStyle;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late DateTime _dateTime;
  late DigitalClockModel _clockModel;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _clockModel = DigitalClockModel();
    _clockModel.is24HourFormat = widget.is24HourTimeFormat ?? true;

    _dateTime = DateTime.now();
    _clockModel.hour = _dateTime.hour;
    _clockModel.minute = _dateTime.minute;
    _clockModel.second = _dateTime.second;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _dateTime = DateTime.now();
      _clockModel.hour = _dateTime.hour;
      _clockModel.minute = _dateTime.minute;
      _clockModel.second = _dateTime.second;

      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      const paddingVertical = 16.0;
      const paddingHorizontal = 16.0;

      return Container(
        height: constraint.maxWidth - paddingVertical * 2,
        padding: const EdgeInsets.symmetric(vertical: paddingVertical),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: paddingHorizontal),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.secondaryContainer,
              width: 4,
            ),
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _hour,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: SpinnerWidget(
                    child: Text(
                      ':',
                      key: const ValueKey(':'),
                      style: widget.hourMinuteDigitTextStyle,
                    ),
                  ),
                ),
                _minute,
                Stack(
                  children: [
                    FractionalTranslation(
                      translation: const Offset(0.0, 1.0),
                      child: _second,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0, right: 8.0),
                      child: ChangeThemeIconButton(),
                    ),
                  ],
                ),
                _amPm,
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget get _hour => SpinnerWidget(
        child: Text(
          _clockModel.is24HourTimeFormat
              ? hTOhh_24hTrue(_clockModel.hour)
              : hTOhh_24hFalse(_clockModel.hour)[0],
          key: ValueKey(_clockModel.is24HourTimeFormat
              ? hTOhh_24hTrue(_clockModel.hour)
              : hTOhh_24hFalse(_clockModel.hour)[0]),
          style: widget.hourMinuteDigitTextStyle,
        ),
        animationStyle: widget.digitAnimationStyle,
      );

  Widget get _minute => SpinnerWidget(
        child: Text(
          mTOmm(_clockModel.minute),
          key: ValueKey(mTOmm(_clockModel.minute)),
          style: widget.hourMinuteDigitTextStyle,
        ),
        animationStyle: widget.digitAnimationStyle,
      );

  Widget get _second => widget.showSecondsDigit != false
      ? SpinnerWidget(
          child: Text(
            sTOss(_clockModel.second),
            key: ValueKey(sTOss(_clockModel.second)),
            style: widget.secondDigitTextStyle ??
                TextStyle(
                  color: widget.secondDigitTextStyle != null
                      ? widget.secondDigitTextStyle!.color!
                      : Theme.of(context).colorScheme.secondary,
                ),
          ),
          animationStyle: widget.digitAnimationStyle,
        )
      : const Text('');

  Widget get _amPm => _clockModel.is24HourTimeFormat
      ? const Text('')
      : Container(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          margin: EdgeInsets.only(
              bottom: widget.hourMinuteDigitTextStyle != null
                  ? widget.hourMinuteDigitTextStyle!.fontSize! / 2
                  : 15),
          child: Text(
            ' ' + hTOhh_24hFalse(_clockModel.hour)[1],
            style: widget.amPmDigitTextStyle ??
                TextStyle(
                    color: widget.hourMinuteDigitTextStyle != null
                        ? widget.hourMinuteDigitTextStyle!.color!
                        : Theme.of(context).colorScheme.primary),
          ),
        );
}
