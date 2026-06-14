import 'package:flutter/material.dart';

class OtpHeader extends StatelessWidget {
  final String phoneNumber;

  const OtpHeader({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48.5, left: 24.0, right: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 30),
          
          const Text(
            'Verifikasi Nomor HP',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: Color(0xff0F172A),
            ),
          ),
          const SizedBox(height: 15),
          
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xff64748B),
                fontFamily: 'Plus Jakarta Sans',
                height: 1.5,
              ),
              children: [
                const TextSpan(text: 'Masukkan 6 digit kode verifikasi yang\nkami kirim ke '),
                TextSpan(
                  text: '+62 $phoneNumber',
                  style: const TextStyle(
                    color: Color(0xff0F172A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}