import 'package:flutter/material.dart';
import '../../../models/merchant_model.dart';
import '../../merchant_detail/merchant_detail_view.dart';

class MerchantCard extends StatelessWidget {
  final MerchantModel merchant;

  const MerchantCard({super.key, required this.merchant});

  @override
  Widget build(BuildContext context) {
    final bool isClosed = merchant.status.toLowerCase() == 'tutup';
    final bool isPaused = merchant.status.toLowerCase() == 'jeda';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isClosed ? const Color(0xffF8FAFC) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xffF1F5F9), width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isClosed ? const Color(0xff475569) : const Color(0xff0F172A),
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      '${merchant.type} • ${merchant.distance} km',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: isClosed ? const Color(0xff94A3B8) : const Color(0xff475569),
                        fontFamily: 'Plus Jakarta Sans',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isClosed
                      ? const Color(0xffE2E8F0)
                      : (isPaused ? const Color(0xffFFFBEB) : const Color(0xffF0FDF4)),
                  borderRadius: BorderRadius.circular(9999),
                  border: isClosed 
                      ? null 
                      : Border.all(
                          color: isPaused 
                              ? const Color(0xffFEF3C7).withOpacity(0.5) 
                              : const Color(0xffDCFCE7).withOpacity(0.5),
                          width: 1.0,
                        ),
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
          if (!isClosed) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xffF8FAFC),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'MELAYANI',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.45, color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans'),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          merchant.currentQueue,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Color(0xff2563EB), fontFamily: 'Plus Jakarta Sans'),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 20, color: const Color(0xffE2E8F0)),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'MENUNGGU',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.45, color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans'),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${merchant.waitingUsers} orang',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff0F172A), fontFamily: 'Plus Jakarta Sans'),
                        ),
                      ],
                    ),
                  ),
                  Container(width: 1, height: 20, color: const Color(0xffE2E8F0)),
                  Expanded(
                    child: Column(
                      children: [
                        const Text(
                          'ESTIMASI',
                          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.45, color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans'),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          merchant.estimatedTime,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isPaused ? const Color(0xffCBD5E1) : const Color(0xff0F172A),
                            fontFamily: 'Plus Jakarta Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: TextButton(
                onPressed: isPaused
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MerchantDetailView(merchant: merchant),
                          ),
                        );
                      },
                style: TextButton.styleFrom(
                  backgroundColor: isPaused ? const Color(0xffF8FAFC) : const Color(0xff2563EB).withOpacity(0.05),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  'Lihat Detail',
                  style: TextStyle(
                    fontSize: 12, 
                    fontWeight: FontWeight.bold, 
                    color: isPaused ? const Color(0xff64748B) : const Color(0xff2563EB),
                    fontFamily: 'Plus Jakarta Sans',
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}