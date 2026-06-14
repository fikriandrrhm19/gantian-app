import 'package:flutter/material.dart';

class AntreanTab extends StatelessWidget {
  const AntreanTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Placeholder Antrean Saya\n(Status Antrean yang Aktif)',
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