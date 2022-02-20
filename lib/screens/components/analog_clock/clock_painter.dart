import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  final BuildContext context;
  final DateTime dateTime;
  final Curve curve;
  final TextStyle textStyle;

  ClockPainter(
    this.context,
    this.dateTime, {
    TextStyle? textStyle,
    this.curve = Curves.linear,
    this.hourNumbers = const [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
    ],
  }) : textStyle = textStyle ??
            TextStyle(
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            );

  final hourLength = .25;
  final minuteLength = .35;
  final secondLength = .40;

  final hourWidth = 12.0;
  final minuteWidth = 8.0;

  final TextPainter _hourTextPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
  );

  final List<String> hourNumbers;

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    Offset center = Offset(centerX, centerY);

    // Minute Calculation
    double minX = centerX +
        size.width * minuteLength * cos((dateTime.minute * 6) * pi / 180);
    double minY = centerY +
        size.width * minuteLength * sin((dateTime.minute * 6) * pi / 180);

    //Minute Line
    canvas.drawLine(
      center,
      Offset(minX, minY),
      Paint()
        ..shader = ui.Gradient.linear(
          center,
          Offset(minX, minY),
          [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = minuteWidth,
    );

    // Hour Calculation
    // dateTime.hour * 30 because 360/12 = 30
    // dateTime.minute * 0.5 each minute we want to turn our hour line a little
    double hourX = centerX +
        size.width *
            hourLength *
            cos((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);
    double hourY = centerY +
        size.width *
            hourLength *
            sin((dateTime.hour * 30 + dateTime.minute * 0.5) * pi / 180);

    // hour Line
    canvas.drawLine(
      center,
      Offset(hourX, hourY),
      Paint()
        ..shader = ui.Gradient.linear(
          center,
          Offset(hourX, hourY),
          [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = hourWidth,
    );

    // Second Calculation
    // size.width * 0.4 define our line height
    // dateTime.second * 6 because 360 / 60 = 6
    double secondX = centerX +
        size.width * secondLength * cos((dateTime.second * 6) * pi / 180);
    double secondY = centerY +
        size.width * secondLength * sin((dateTime.second * 6) * pi / 180);

    double secondPrevX = centerX +
        size.width * secondLength * cos(((dateTime.second - 1) * 6) * pi / 180);
    double secondPrevY = centerY +
        size.width * secondLength * sin(((dateTime.second - 1) * 6) * pi / 180);

    // Second Line
    canvas.drawLine(center, Offset(secondX, secondY),
        Paint()..color = Theme.of(context).primaryColor);

    var opacity = curve.transform(1 - dateTime.millisecond / 1000);
    // ensure no opacity is negative
    opacity = opacity > 0 ? opacity : 0;

    final dashPainter = Paint()
      ..shader = ui.Gradient.linear(
        Offset(secondX, secondY),
        Offset(secondPrevX, secondPrevY),
        [
          Theme.of(context).colorScheme.primary.withOpacity(opacity),
          Theme.of(context).colorScheme.onPrimary.withOpacity(opacity),
        ],
      )
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(center.dx, center.dy);
    path.lineTo(secondPrevX, secondPrevY);
    path.lineTo(secondX, secondY);
    path.close();

    canvas.drawPath(path, dashPainter);

    _paintHourText(canvas, centerX - textStyle.fontSize! - 4, center);

// center Dots
    Paint dotPainter = Paint()
      ..color = Theme.of(context).primaryIconTheme.color!;
    canvas.drawCircle(center, 24, dotPainter);
    canvas.drawCircle(
        center, 23, Paint()..color = Theme.of(context).backgroundColor);
    canvas.drawCircle(center, 10, dotPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  /// draw number（1 - 12）
  void _paintHourText(Canvas canvas, double radius, Offset offset) {
    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    for (var i = 0; i < 12; i++) {
      canvas.save();
      canvas.rotate(pi / 2);

      double _angle = i * 30.0;
      double hourNumberX = cos(_getRadians(_angle)) * radius;
      double hourNumberY = sin(_getRadians(_angle)) * radius;
      canvas.translate(hourNumberX, hourNumberY);
      int intHour = i + 3;
      if (intHour > 12) intHour = intHour - 12;

      String hourText = hourNumbers[intHour - 1];
      _hourTextPainter.text = TextSpan(
        text: hourText,
        style: textStyle,
      );
      _hourTextPainter.layout();
      _hourTextPainter.paint(
        canvas,
        Offset(-_hourTextPainter.width / 2, -_hourTextPainter.height / 2),
      );

      canvas.restore();
    }
    canvas.restore();

    // var paint1 = Paint()
    //   ..color = const Color(0xff995588)
    //   ..style = PaintingStyle.fill;
    // canvas.drawRect(offset & const Size(100, 100), paint1);
  }

  double _getRadians(double angle) {
    return angle * pi / 180;
  }
}
