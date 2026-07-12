import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/merchant_controller.dart';
import '../widgets/merchant_card.dart';

class BerandaTab extends StatefulWidget {
  const BerandaTab({super.key});

  @override
  State<BerandaTab> createState() => _BerandaTabState();
}

class _BerandaTabState extends State<BerandaTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MerchantController>().fetchMerchants();
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final merchantProvider = context.watch<MerchantController>();

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xffF1F5F9), width: 1.0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(color: Color(0xffDBEAFE), shape: BoxShape.circle),
                        child: const Center(
                          child: Icon(Icons.person, color: Color(0xff2563EB), size: 24),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Halo, ${auth.fullName.isNotEmpty ? auth.fullName : 'User'}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff0F172A), fontFamily: 'Plus Jakarta Sans', height: 1.25),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined, size: 14, color: Color(0xff475569)),
                              const SizedBox(width: 2),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 160),
                                child: const Text(
                                  'Dago, Bandung',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff475569), fontFamily: 'Plus Jakarta Sans', height: 1.5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: const Icon(Icons.notifications_outlined, color: Color(0xff0F172A), size: 24),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  const Text(
                    'Gantian.',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xff2563EB), fontFamily: 'Plus Jakarta Sans', height: 1.33),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xffE2E8F0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.search, color: Color(0xff94A3B8), size: 15),
                              SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Cari bisnis...',
                                    hintStyle: TextStyle(color: Color(0xff94A3B8), fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Plus Jakarta Sans'),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xffE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.tune, color: Color(0xff475569), size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Bisnis Terdekat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff0F172A), fontFamily: 'Plus Jakarta Sans', height: 1.5)),
                      GestureDetector(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Text('Lihat Semua', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff2563EB), fontFamily: 'Plus Jakarta Sans', height: 1.33)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (merchantProvider.isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Center(child: CircularProgressIndicator(color: Color(0xff2563EB))),
                    )
                  else if (merchantProvider.errorMessage.isNotEmpty)
                    Center(child: Text(merchantProvider.errorMessage, style: const TextStyle(color: Color(0xffBA1A1A), fontWeight: FontWeight.w500)))
                  else
                    ...merchantProvider.merchants.map((merchant) => MerchantCard(merchant: merchant)),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff2563EB), Color(0xff1D4ED8)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xffBFDBFE).withOpacity(0.5),
                  blurRadius: 10,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: const Color(0xffBFDBFE).withOpacity(0.5),
                  blurRadius: 25,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(16),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.qr_code_scanner, color: Colors.white, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Scan QR',
                        style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'Plus Jakarta Sans', height: 1.42),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}