import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffEFF6FF),
            Color(0xffF8FBFF),
            Color(0xffFFFFFF),
          ],
          stops: [0.0, 0.5, 1.0],
        ),
      ),
      child: child,
    );
  }
}