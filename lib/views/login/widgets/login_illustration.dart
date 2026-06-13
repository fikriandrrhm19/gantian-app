import 'package:flutter/material.dart';
import '../../../components/floating_icon.dart';

class LoginIllustration extends StatelessWidget {
  const LoginIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 360,
        width: 390,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // --- MAIN PHONE MOCKUP ---
            Container(
              width: 160,
              height: 288,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: const Color(0xffE2E7FF), width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 50,
                    offset: const Offset(0, 25),
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48,
                    height: 6,
                    decoration: BoxDecoration(
                      color: const Color(0xffE2E7FF),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                  Column(
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'sans-serif',
                          ),
                          children: [
                            TextSpan(text: 'Gantian', style: TextStyle(color: Color(0xff0F172A))),
                            TextSpan(text: '.', style: TextStyle(color: Color(0xff2563EB))),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: index == 4 ? const Color(0xff2563EB) : const Color(0xffCBD5E1),
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: 96,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xffE2E8F0),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xffE8EEF9).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
            ),
            // --- FLOATING ICONS COORD ---
            Positioned(
              top: 115,
              left: 38,
              child: FloatingIcon(iconData: Icons.store, iconColor: const Color(0xff0057C2)),
            ),
            Positioned(
              top: 77,
              right: 52,
              child: FloatingIcon(iconData: Icons.qr_code_scanner, iconColor: const Color(0xff2563EB)),
            ),
            Positioned(
              top: 246,
              left: 52,
              child: FloatingIcon(iconData: Icons.confirmation_number, iconColor: const Color(0xff943700)),
            ),
            Positioned(
              top: 214,
              right: 46,
              child: FloatingIcon(iconData: Icons.notifications, iconColor: const Color(0xff131B2E)),
            ),
          ],
        ),
      ),
    );
  }
}