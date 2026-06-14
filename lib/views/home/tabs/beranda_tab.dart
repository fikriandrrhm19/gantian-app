import 'package:flutter/material.dart';

class BerandaTab extends StatelessWidget {
  const BerandaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Placeholder Beranda\n(Discovery Merchant)',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xff94A3B8),
          fontFamily: 'Plus Jakarta Sans',
        ),
      ),
    );
  }
}