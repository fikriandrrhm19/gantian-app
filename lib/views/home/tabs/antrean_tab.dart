import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/merchant_controller.dart';
import '../../../controllers/queue_controller.dart';
import '../../../models/merchant_model.dart';
import '../../../services/notification_service.dart';
import '../../merchant_detail/merchant_detail_view.dart';

class AntreanTab extends StatefulWidget {
  const AntreanTab({super.key});

  @override
  State<AntreanTab> createState() => _AntreanTabState();
}

class _AntreanTabState extends State<AntreanTab> with WidgetsBindingObserver {
  int _selectedTab = 0;
  DateTime? _lastFetchTime;
  Timer? _secondsTimer;
  Timer? _uiRenewTimer;
  Timer? _backgroundNotifyTimer;
  String _timeAgoString = 'Memuat...';
  AppLifecycleState _notificationState = AppLifecycleState.resumed;
  double _turns = 0.0;
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    
    final queueCtx = context.read<QueueController>();
    if (queueCtx.queues.isEmpty) {
      _silentFetchData();
    } else {
      _lastFetchTime = DateTime.now();
      _updateTimeString();
    }
    
    _secondsTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTimeString();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _secondsTimer?.cancel();
    _uiRenewTimer?.cancel();
    _backgroundNotifyTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _notificationState = state;
    });

    if (state == AppLifecycleState.paused) {
      _backgroundNotifyTimer = Timer.periodic(const Duration(minutes: 20), (timer) {
        _triggerBackgroundNotification();
      });
    } else if (state == AppLifecycleState.resumed) {
      _backgroundNotifyTimer?.cancel();
      _silentFetchData();
    }
  }

  void _silentFetchData() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final merchantCtx = context.read<MerchantController>();
      await merchantCtx.fetchMerchants();
      if (mounted) {
        context.read<QueueController>().updateQueuesFromMerchants(merchantCtx);
        setState(() {
          _lastFetchTime = DateTime.now();
          _updateTimeString();
        });
      }
    });
  }

  void _manualRefreshData() async {
    if (_isRefreshing) return;
    
    setState(() {
      _isRefreshing = true;
      _turns += 1.0; 
    });

    final merchantCtx = context.read<MerchantController>();
    await merchantCtx.fetchMerchants();

    if (mounted) {
      context.read<QueueController>().updateQueuesFromMerchants(merchantCtx);
      setState(() {
        _lastFetchTime = DateTime.now();
        _isRefreshing = false;
        _updateTimeString();
      });
    }
  }

  void _triggerBackgroundNotification() async {
    final queueCtx = context.read<QueueController>();
    final merchantCtx = context.read<MerchantController>();

    await merchantCtx.fetchMerchants();
    if (!mounted) return;
    queueCtx.updateQueuesFromMerchants(merchantCtx);

    if (_notificationState == AppLifecycleState.paused && queueCtx.activeQueues.isNotEmpty) {
      final activeQueue = queueCtx.activeQueues.first;
      final associatedMerchant = merchantCtx.merchants.firstWhere(
        (m) => activeQueue.merchantId == m.id,
        orElse: () => MerchantModel(id: '', name: 'Merchant', type: '', status: '', currentQueue: '--', waitingUsers: 0, estimatedTime: '--', distance: 0.0, address: '', queues: []),
      );

      if (associatedMerchant.id.isNotEmpty) {
        await NotificationService.showInstantNotification(
          id: activeQueue.id.hashCode,
          title: 'Pengingat Antrean: ${associatedMerchant.name}',
          body: 'Nomor Anda ${activeQueue.userNumber}. Saat ini melayani ${associatedMerchant.currentQueue}. Sisa antrean: ${activeQueue.peopleAhead} orang.',
        );
      }
    }
  }

  void _updateTimeString() {
    if (_lastFetchTime == null) return;
    final diff = DateTime.now().difference(_lastFetchTime!);
    
    setState(() {
      if (diff.inSeconds < 5) {
        _timeAgoString = 'Terakhir diperbarui baru saja';
      } else if (diff.inSeconds < 60) {
        _timeAgoString = 'Terakhir diperbarui ${diff.inSeconds} detik lalu';
      } else {
        _timeAgoString = 'Terakhir diperbarui ${diff.inMinutes} menit lalu';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final queueProvider = context.watch<QueueController>();
    final merchantProvider = context.watch<MerchantController>();

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
            'Antrean Saya',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff131B2E),
              fontFamily: 'Plus Jakarta Sans',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 8),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: const Color(0xffC3C6D7).withOpacity(0.50)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 0),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: _selectedTab == 0 ? const Color(0xff2563EB) : Colors.transparent,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Aktif',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: _selectedTab == 0 ? FontWeight.bold : FontWeight.w500,
                          color: _selectedTab == 0 ? Colors.white : const Color(0xff434655),
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedTab = 1),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: _selectedTab == 1 ? const Color(0xff2563EB) : Colors.transparent,
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Riwayat',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: _selectedTab == 1 ? FontWeight.bold : FontWeight.w500,
                          color: _selectedTab == 1 ? Colors.white : const Color(0xff434655),
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: _selectedTab == 0
              ? _buildAktifTab(queueProvider, merchantProvider)
              : _buildRiwayatTab(queueProvider, merchantProvider),
        ),
      ],
    );
  }

  Widget _buildAktifTab(QueueController queueCtx, MerchantController merchantCtx) {
    final activeList = queueCtx.activeQueues;
    if (activeList.isEmpty && queueCtx.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xff2563EB)));
    }
    if (activeList.isEmpty) {
      return const Center(
        child: Text(
          'Tidak ada antrean aktif',
          style: TextStyle(color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans'),
        ),
      );
    }

    final queue = activeList.first;
    final merchant = merchantCtx.merchants.firstWhere(
      (m) => queue.merchantId == m.id,
      orElse: () => MerchantModel(id: '', name: 'Unknown Business', type: 'Unknown', status: 'Tutup', currentQueue: '--', waitingUsers: 0, estimatedTime: '--', distance: 0.0, address: '', queues: []),
    );

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xffE5E7EB)),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          merchant.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff131B2E), fontFamily: 'Plus Jakarta Sans'),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 14, color: Color(0xff434655)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                merchant.address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xff434655), fontFamily: 'Plus Jakarta Sans'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xffF0FDF4),
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: const Color(0xffDCFCE7)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, size: 14, color: Color(0xff15803D)),
                        SizedBox(width: 4),
                        Text(
                          'BUKA',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff15803D), letterSpacing: 0.50, fontFamily: 'Plus Jakarta Sans'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    decoration: BoxDecoration(
                      color: const Color(0xffF2F3FF).withOpacity(0.50),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xffC3C6D7).withOpacity(0.30)),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'NOMOR ANTREAN ANDA',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xff434655), letterSpacing: 1.10, fontFamily: 'Plus Jakarta Sans'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          queue.userNumber,
                          style: const TextStyle(fontSize: 64, fontWeight: FontWeight.w800, color: Color(0xff2563EB), height: 1.0, fontFamily: 'Plus Jakarta Sans'),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xffDBEAFE),
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xff2563EB).withOpacity(0.10)),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: _manualRefreshData,
                          child: AnimatedRotation(
                            turns: _turns,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                            child: Icon(
                              Icons.refresh, 
                              color: _isRefreshing ? const Color(0xff94A3B8) : const Color(0xff2563EB), 
                              size: 18
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'Perkiraan dipanggil sekitar pukul ${queue.estimatedCallTime}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff434655), fontFamily: 'Plus Jakarta Sans'),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.only(top: 24),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xffE5E7EB))),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          const Text('MELAYANI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff94A3B8), letterSpacing: 0.50, fontFamily: 'Plus Jakarta Sans')),
                          const SizedBox(height: 8),
                          Text(merchant.currentQueue, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xff2563EB), fontFamily: 'Plus Jakarta Sans')),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 35, color: const Color(0xffE5E7EB)),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('SEBELUM ANDA', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff94A3B8), letterSpacing: 0.50, fontFamily: 'Plus Jakarta Sans')),
                          const SizedBox(height: 8),
                          Text('${queue.peopleAhead} orang', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xff131B2E), fontFamily: 'Plus Jakarta Sans')),
                        ],
                      ),
                    ),
                    Container(width: 1, height: 35, color: const Color(0xffE5E7EB)),
                    Expanded(
                      child: Column(
                        children: [
                          const Text('ESTIMASI', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xff94A3B8), letterSpacing: 0.50, fontFamily: 'Plus Jakarta Sans')),
                          const SizedBox(height: 8),
                          Text(merchant.estimatedTime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xff131B2E), fontFamily: 'Plus Jakarta Sans')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(_timeAgoString, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans')),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Status Notifikasi', style: TextStyle(fontSize: 14, color: Color(0xff434655), fontFamily: 'Plus Jakarta Sans')),
              Row(
                children: [
                  const Text('Aktif', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xff15803D), fontFamily: 'Plus Jakarta Sans')),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right, color: Color(0xff2563EB), size: 20),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MerchantDetailView(merchant: merchant)),
              );
            },
            icon: const Icon(Icons.storefront, color: Color(0xff2563EB)),
            label: const Text('Lihat Detail Bisnis', style: TextStyle(color: Color(0xff2563EB), fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Plus Jakarta Sans')),
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Color(0xff2563EB)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRiwayatTab(QueueController queueCtx, MerchantController merchantCtx) {
    final historyList = queueCtx.historyQueues;
    if (historyList.isEmpty && queueCtx.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Color(0xff2563EB)));
    }
    if (historyList.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada riwayat antrean',
          style: TextStyle(color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans'),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: historyList.length,
      itemBuilder: (context, index) {
        final queue = historyList[index];
        final merchant = merchantCtx.merchants.firstWhere(
          (m) => queue.merchantId == m.id,
          orElse: () => MerchantModel(id: '', name: 'Unknown Business', type: 'Unknown', status: 'Tutup', currentQueue: '--', waitingUsers: 0, estimatedTime: '--', distance: 0.0, address: '', queues: []),
        );

        final bool isSuccess = queue.queueStatus.toLowerCase() == 'selesai';

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xffF1F5F9)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          merchant.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xff131B2E), fontFamily: 'Plus Jakarta Sans'),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 16, color: Color(0xff434655)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                merchant.address,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xff434655), fontFamily: 'Plus Jakarta Sans'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSuccess ? const Color(0xffF0FDF4) : const Color(0xffF1F5F9),
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(color: isSuccess ? const Color(0xffDCFCE7) : const Color(0xffE2E8F0)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isSuccess ? Icons.check_circle : Icons.cancel,
                          size: 14,
                          color: isSuccess ? const Color(0xff15803D) : const Color(0xff475569),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          queue.queueStatus.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: isSuccess ? const Color(0xff15803D) : const Color(0xff475569),
                            letterSpacing: 0.50,
                            fontFamily: 'Plus Jakarta Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.only(top: 16),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Color(0xffF1F5F9))),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NOMOR ANTREAN: ${queue.userNumber}',
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xff434655), letterSpacing: 1.10, fontFamily: 'Plus Jakarta Sans'),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xff434655)),
                            const SizedBox(width: 6),
                            Text(
                              queue.date,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xff434655), fontFamily: 'Plus Jakarta Sans'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xffCBD5E1)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}