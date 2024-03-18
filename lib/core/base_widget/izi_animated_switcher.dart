import 'package:flutter/material.dart';

class IZIAnimatedSwitch extends StatelessWidget {
  const IZIAnimatedSwitch({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget childWidget, Animation<double> animationWidget) {
        return ScaleTransition(scale: animationWidget, child: childWidget);
      },
      child: child,
    );
  }
}
