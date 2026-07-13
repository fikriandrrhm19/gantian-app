import 'package:flutter/material.dart';
import '../../models/merchant_model.dart';
import '../scan_qr/scan_qr_view.dart';

class MerchantDetailView extends StatelessWidget {
  final MerchantModel merchant;

  const MerchantDetailView({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    final bool isClosed = merchant.status.toLowerCase() == 'tutup';
    final bool isPaused = merchant.status.toLowerCase() == 'jeda';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Container buatan untuk mewarnai area status bar menjadi putih murni
            Container(
              height: MediaQuery.of(context).padding.top,
              color: Colors.white,
            ),
            // Isi utama halaman detail bisnis
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffEFF6FF),
                      Color(0xffFFFFFF),
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(bottom: BorderSide(color: Color(0xffF1F5F9), width: 1.0)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: const BoxDecoration(shape: BoxShape.circle),
                                  child: const Icon(Icons.arrow_back, color: Color(0xff0F172A), size: 24),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Detail Bisnis',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff0F172A), fontFamily: 'Plus Jakarta Sans'),
                              ),
                            ],
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(shape: BoxShape.circle),
                            child: const Icon(Icons.share_outlined, color: Color(0xff0F172A), size: 24),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      merchant.name,
                                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xff0F172A), fontFamily: 'Plus Jakarta Sans', height: 1.25),
                                    ),
                                    const SizedBox(height: 4),
                                    RichText(
                                      text: TextSpan(
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff475569), fontFamily: 'Plus Jakarta Sans'),
                                        children: [
                                          TextSpan(text: '${merchant.type} '),
                                          const TextSpan(text: '•', style: TextStyle(color: Color(0xffE2E8F0))),
                                          TextSpan(text: ' ${merchant.type}, Bandung'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.near_me_outlined, size: 16, color: Color(0xff2563EB)),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${merchant.distance} km dari lokasi Anda',
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff475569), fontFamily: 'Plus Jakarta Sans'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: isClosed
                                      ? const Color(0xffE2E8F0)
                                      : (isPaused ? const Color(0xffFFFBEB) : const Color(0xffF0FDF4)),
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isClosed
                                          ? Icons.cancel
                                          : (isPaused ? Icons.pause_circle : Icons.check_circle),
                                      size: 11.67,
                                      color: isClosed
                                          ? const Color(0xff475569)
                                          : (isPaused ? const Color(0xffB45309) : const Color(0xff15803D)),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      merchant.status.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w800,
                                        letterSpacing: 0.25,
                                        color: isClosed
                                            ? const Color(0xff475569)
                                            : (isPaused ? const Color(0xffB45309) : const Color(0xff15803D)),
                                        fontFamily: 'Plus Jakarta Sans',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: const Color(0xffF1F5F9)),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xff0F172A).withOpacity(0.02),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                                BoxShadow(
                                  color: const Color(0xff0F172A).withOpacity(0.04),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'MELAYANI',
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5, color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans'),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        merchant.currentQueue,
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff2563EB), fontFamily: 'Plus Jakarta Sans'),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(width: 1, height: 28, color: const Color(0xffF1F5F9)),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'MENUNGGU',
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5, color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans'),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${merchant.waitingUsers} orang',
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff0F172A), fontFamily: 'Plus Jakarta Sans'),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(width: 1, height: 28, color: const Color(0xffF1F5F9)),
                                Expanded(
                                  child: Column(
                                    children: [
                                      const Text(
                                        'ESTIMASI',
                                        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5, color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans'),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        merchant.estimatedTime,
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isPaused ? const Color(0xffCBD5E1) : const Color(0xff0F172A), fontFamily: 'Plus Jakarta Sans'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: isClosed || isPaused
                                        ? null
                                        : const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
                                          ),
                                    color: isClosed || isPaused ? const Color(0xffE2E8F0) : null,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: isClosed || isPaused
                                        ? []
                                        : [
                                            BoxShadow(
                                              color: const Color(0xffBFDBFE).withOpacity(0.5),
                                              blurRadius: 6,
                                              offset: const Offset(0, 4),
                                            ),
                                            BoxShadow(
                                              color: const Color(0xffBFDBFE).withOpacity(0.5),
                                              blurRadius: 15,
                                              offset: const Offset(0, 10),
                                            ),
                                          ],
                                  ),
                                  child: ElevatedButton.icon(
                                    onPressed: isClosed || isPaused ? null : () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const ScanQrView()),
                                      );
                                    },
                                    icon: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 24),
                                    label: const Text('Scan QR di Lokasi', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Plus Jakarta Sans')),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.navigation_outlined, color: Color(0xff0F172A), size: 24),
                                  label: const Text('Lihat Rute', style: TextStyle(color: Color(0xff0F172A), fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Plus Jakarta Sans')),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xffE2E8F0), width: 2.0),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: const Color(0xffF1F5F9)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(color: const Color(0xffEFF6FF), borderRadius: BorderRadius.circular(12)),
                                      child: const Icon(Icons.schedule, color: Color(0xff2563EB), size: 20),
                                    ),
                                    const SizedBox(width: 16),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('JAM OPERASIONAL', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans')),
                                        SizedBox(height: 2),
                                        Text('Senin–Sabtu, 08.00–17.00', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff0F172A), fontFamily: 'Plus Jakarta Sans')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: const Color(0xffF1F5F9)),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(color: const Color(0xffEFF6FF), borderRadius: BorderRadius.circular(12)),
                                      child: const Icon(Icons.location_on_outlined, color: Color(0xff2563EB), size: 20),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text('ALAMAT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1, color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans')),
                                          const SizedBox(height: 2),
                                          Text('Jl. Ir. H. Djuanda No. 120, ${merchant.type}, Bandung', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xff0F172A), fontFamily: 'Plus Jakarta Sans')),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Terakhir diperbarui 2 menit lalu', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans')),
                              const SizedBox(width: 8),
                              const Text('•', style: TextStyle(color: Color(0xffE2E8F0))),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () {},
                                child: const Row(
                                  children: [
                                    Icon(Icons.refresh, color: Color(0xff2563EB), size: 16),
                                    SizedBox(width: 4),
                                    Text('Perbarui Status', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff2563EB), fontFamily: 'Plus Jakarta Sans')),
                                  ],
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
            ),
          ],
        ),
      ),
    );
  }
}