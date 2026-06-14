import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.chevron_left, color: Color(0xff64748B), size: 24),
          SizedBox(width: 4),
          Text(
            'Kembali',
            style: TextStyle(
              color: Color(0xff64748B),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ],
      ),
    );
  }
}