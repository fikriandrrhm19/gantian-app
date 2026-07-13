import 'package:flutter/material.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 24.0, top: 40.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: const TextSpan(
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xff64748B),
            fontFamily: 'Plus Jakarta Sans',
            height: 1.5,
          ),
          children: [
            TextSpan(text: 'Dengan melanjutkan, Anda menyetujui '),
            TextSpan(
              text: 'Syarat & Ketentuan',
              style: TextStyle(
                color: Color(0xff2563EB),
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(text: ' dan '),
            TextSpan(
              text: 'Kebijakan Privasi',
              style: TextStyle(
                color: Color(0xff2563EB),
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}