import 'package:cartafri/core/utils/constants/constants.dart';
import 'package:cartafri/screens/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      required this.endColor,
      this.selectedIconData});
  final IconData iconData;
  final Color startColor;
  final IconData? selectedIconData;
  final Color endColor;
  @override
  State<IconAnimation> createState() => _IconAnimationState();
}

class _IconAnimationState extends State<IconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _colorAnimation;
  late Animation<double> _sizeAnimation;
  bool isfav = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween(begin: 24.0, end: 44.0), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween(begin: 44.0, end: 24.0), weight: 50)
    ]).animate(_controller);

    _colorAnimation = ColorTween(begin: widget.startColor, end: widget.endColor)
        .animate(_controller);
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
          iconSize: _sizeAnimation.value,
          icon: Icon(widget.iconData),
          selectedIcon: Icon(widget.selectedIconData),
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

// Page Transition
class PageTransition extends PageRouteBuilder {
  final Widget page;
  PageTransition(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionDuration: const Duration(milliseconds: 1200),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return Align(
                  alignment: Alignment.bottomCenter,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: 0,
                    child: page,
                  ));
            });
}

class PageTransition2 extends PageRouteBuilder {
  final Widget route;
  PageTransition2({required this.route})
      : super(
            pageBuilder: (context, animation, anotherAnimation) => route,
            transitionDuration: const Duration(milliseconds: 500),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              // can also create tween here
              return ScaleTransition(scale: animation, child: child);
            });
}
