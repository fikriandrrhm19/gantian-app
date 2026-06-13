import 'package:flutter/material.dart';

class FloatingIcon extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;

  const FloatingIcon({
    super.key,
    required this.iconData,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Icon(iconData, color: iconColor, size: 24),
    );
  }
}