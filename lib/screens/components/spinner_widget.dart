import 'package:flutter/material.dart';

class SpinnerWidget extends StatefulWidget {
  const SpinnerWidget({
    Key? key,
    required this.child,
    this.animationStyle,
    this.withShader = true,
  }) : super(key: key);

  final Widget child;
  final Curve? animationStyle;
  final bool withShader;

  @override
  _SpinnerWidgetState createState() => _SpinnerWidgetState();
}

class _SpinnerWidgetState extends State<SpinnerWidget>
    with SingleTickerProviderStateMixin {
  late Widget topChild = Container();
  late Widget bottomChild = Container();

  late AnimationController _spinTextAnimationController;
  late Animation<double> _spinAnimation;

  @override
  void initState() {
    super.initState();
    bottomChild = widget.child;
    _spinTextAnimationController = AnimationController(
        duration: const Duration(milliseconds: 750), vsync: this)
      ..addListener(() => setState(() {}))
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            bottomChild = topChild;
            topChild = Container();
            _spinTextAnimationController.value = 0.0;
          });
        }
      });

    _spinAnimation = CurvedAnimation(
        parent: _spinTextAnimationController,
        curve: widget.animationStyle ?? Curves.decelerate);
  }

  @override
  void dispose() {
    _spinTextAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SpinnerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.child.key != oldWidget.child.key) {
      //Need to spin new value
      topChild = widget.child;
      _spinTextAnimationController.forward();
    } else if (widget.child != oldWidget.child) {
      bottomChild = widget.child;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [
              widget.withShader ? Colors.transparent : Colors.white,
              Colors.white,
              Colors.white,
              widget.withShader ? Colors.transparent : Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [.05, .3, .7, .95],
          ).createShader(bounds);
        },
        child: Stack(
          children: <Widget>[
            FractionalTranslation(
              translation: Offset(0.0, _spinAnimation.value - 1),
              child: topChild,
            ),
            FractionalTranslation(
              translation: Offset(0.0, _spinAnimation.value),
              child: bottomChild,
            ),
          ],
        ),
      ),
    );
  }
}

class RectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0.0, 0.0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
