import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth_controller.dart';
import '../../login/login_view.dart';

class ProfilTab extends StatelessWidget {
  const ProfilTab({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = context.watch<AuthController>();

    String formatPhoneNumber(String rawNumber) {
      if (rawNumber.length > 4) {
        final prefix = rawNumber.substring(0, 3);
        final suffix = rawNumber.substring(rawNumber.length - 4);
        return '+62 $prefix •••• $suffix';
      }
      return '+62 $rawNumber';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: Colors.white,
          alignment: Alignment.centerLeft,
          child: const Text(
            'Profil',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff0F172A),
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 24),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xffE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Color(0xffDBEAFE),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 32,
                        color: Color(0xff2563EB),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authController.fullName.isNotEmpty
                                ? authController.fullName
                                : 'User',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff0F172A),
                              height: 1.25,
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatPhoneNumber(authController.phoneNumber),
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff64748B),
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: Color(0xff004AC6),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Bandung, Jawa Barat',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff434655),
                                  fontFamily: 'Plus Jakarta Sans',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xffE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildSettingItem(
                      icon: Icons.notifications_none_outlined,
                      title: 'Notifikasi Antrean',
                      onTap: () {},
                    ),
                    const Divider(height: 1, thickness: 1, color: Color(0xffF1F5F9), indent: 20, endIndent: 20),
                    _buildSettingItem(
                      icon: Icons.info_outline,
                      title: 'Tentang Gantian',
                      onTap: () {},
                    ),
                    const Divider(height: 1, thickness: 1, color: Color(0xffF1F5F9), indent: 20, endIndent: 20),
                    _buildSettingItem(
                      icon: Icons.shield_outlined,
                      title: 'Kebijakan Privasi',
                      onTap: () {},
                    ),
                    const Divider(height: 1, thickness: 1, color: Color(0xffF1F5F9), indent: 20, endIndent: 20),
                    _buildSettingItem(
                      icon: Icons.description_outlined,
                      title: 'Syarat & Ketentuan',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: () {
                    context.read<AuthController>().clearAuthData();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginView()),
                      (route) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xffE2E8F0)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 1.0,
                    shadowColor: Colors.black.withOpacity(0.05),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout, color: Color(0xffDC2626), size: 18),
                      SizedBox(width: 12),
                      Text(
                        'Keluar',
                        style: TextStyle(
                          color: Color(0xffDC2626),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Opacity(
                opacity: 0.40,
                child: Column(
                  children: [
                    Text(
                      'Gantian',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xff004AC6),
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Versi 1.0.0',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff94A3B8),
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 56,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: const Color(0xff64748B), size: 20),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff131B2E),
                      fontFamily: 'Plus Jakarta Sans',
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.chevron_right,
                color: Color(0xffC3C6D7),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}