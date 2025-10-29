import 'package:flutter/material.dart';

mixin HoverMixin<T extends StatefulWidget> on State<T> {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _marginAnimation;
  late Animation<double> _colorAnimation;

  bool get isHovered => _isHovered;
  AnimationController get animationController => _animationController;
  Animation<double> get marginAnimation => _marginAnimation;
  Animation<double> get colorAnimation => _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this as TickerProvider,
    );
    _marginAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _colorAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void onHoverEnter() {
    setState(() {
      _isHovered = true;
    });
    _animationController.forward();
  }

  void onHoverExit() {
    setState(() {
      _isHovered = false;
    });
    _animationController.reverse();
  }

  Widget buildHoverWrapper({required Widget child}) {
    return MouseRegion(
      onEnter: (_) => onHoverEnter(),
      onExit: (_) => onHoverExit(),
      child: AnimatedBuilder(
        animation: _marginAnimation,
        builder: (context, child) {
          return Container(
            margin: EdgeInsets.only(bottom: _marginAnimation.value),
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}
