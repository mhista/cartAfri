import 'package:cartafri/core/constants/constants.dart';
import 'package:flutter/material.dart';

// allows for animating text widget
class TextTweenAnimation extends StatelessWidget {
  const TextTweenAnimation({super.key, required this.text});
  final Text text;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 500),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      builder: (BuildContext context, double _val, Widget? child) {
        return Opacity(
          opacity: _val,
          child:
              Padding(padding: EdgeInsets.only(top: _val * 20), child: child),
        );
      },
      child: text,
    );
  }
}

// Icon animation
class IconAnimation extends StatefulWidget {
  const IconAnimation(
      {super.key,
      required this.iconData,
      required this.startColor,
      required this.endColor});
  final IconData iconData;
  final Color startColor;
  final Color endColor;
  @override
  State<IconAnimation> createState() => _IconAnimationState();
}

class _IconAnimationState extends State<IconAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _colorAnimation;
  bool isfav = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _colorAnimation = ColorTween(begin: widget.startColor, end: widget.endColor)
        .animate(_controller);
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isfav = true;
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isfav = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, _) {
        return IconButton(
          icon: Icon(widget.iconData),
          color: _colorAnimation.value,
          onPressed: () {
            isfav ? _controller.reverse() : _controller.forward();
          },
        );
      },
      animation: _controller,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
