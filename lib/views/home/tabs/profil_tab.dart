import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth_controller.dart';
import '../../login/login_view.dart';

class ProfilTab extends StatelessWidget {
  const ProfilTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xffEFF6FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: 48,
                color: Color(0xff2563EB),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              authController.fullName.isNotEmpty 
                  ? authController.fullName 
                  : 'Pengguna Gantian',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff0F172A),
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '+62 ${authController.phoneNumber}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xff64748B),
                fontFamily: 'Plus Jakarta Sans',
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<AuthController>().clearAuthData();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginView()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout, color: Color(0xffEF4444)),
                label: const Text(
                  'Keluar dari Akun',
                  style: TextStyle(
                    color: Color(0xffEF4444),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xffFCA5A5), width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}