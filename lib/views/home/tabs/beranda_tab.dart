import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/auth_controller.dart';
import '../../../controllers/merchant_controller.dart';
import '../../../models/merchant_model.dart';
import '../widgets/merchant_card.dart';
import '../../scan_qr/scan_qr_view.dart';

class BerandaTab extends StatefulWidget {
  const BerandaTab({super.key});

  @override
  State<BerandaTab> createState() => _BerandaTabState();
}

class _BerandaTabState extends State<BerandaTab> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  List<String> _selectedCategories = [];
  bool _isPullRefreshing = false;
  
  late AnimationController _shimmerController;

  final List<String> _categories = [
    "Barbershop",
    "Bengkel",
    "Warung",
    "Apotek",
    "Servis HP",
    "Salon"
  ];

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    final merchantCtx = context.read<MerchantController>();
    if (merchantCtx.merchants.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        merchantCtx.fetchMerchants();
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isPullRefreshing = true;
    });

    await context.read<MerchantController>().fetchMerchants();

    if (mounted) {
      setState(() {
        _isPullRefreshing = false;
      });
    }
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 48,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xffE2E8F0),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Filter Kategori',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff0F172A),
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      ),
                      if (_selectedCategories.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            setModalState(() {
                              _selectedCategories.clear();
                            });
                            setState(() {});
                          },
                          child: const Text(
                            'Bersihkan',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffDC2626),
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _categories.map((category) {
                      final bool isSelected = _selectedCategories.contains(category);
                      return FilterChip(
                        label: Text(category),
                        selected: isSelected,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : const Color(0xff475569),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                        selectedColor: const Color(0xff2563EB),
                        backgroundColor: const Color(0xffF1F5F9),
                        checkmarkColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide.none,
                        ),
                        onSelected: (bool selected) {
                          setModalState(() {
                            if (selected) {
                              _selectedCategories.add(category);
                            } else {
                              _selectedCategories.remove(category);
                            }
                          });
                          setState(() {});
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Terapkan Filter',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Plus Jakarta Sans',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildShimmerCard() {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return Opacity(
          opacity: 0.3 + (_shimmerController.value * 0.5),
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            height: 160,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xffF1F5F9), width: 1.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 140, height: 16, decoration: BoxDecoration(color: const Color(0xffE2E8F0), borderRadius: BorderRadius.circular(4))),
                        const SizedBox(height: 6),
                        Container(width: 90, height: 12, decoration: BoxDecoration(color: const Color(0xffE2E8F0), borderRadius: BorderRadius.circular(4))),
                      ],
                    ),
                    Container(width: 60, height: 20, decoration: BoxDecoration(color: const Color(0xffE2E8F0), borderRadius: BorderRadius.circular(999))),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthController>();
    final merchantProvider = context.watch<MerchantController>();

    final List<MerchantModel> filteredMerchants = merchantProvider.merchants.where((merchant) {
      final bool matchesSearch = merchant.name.toLowerCase().contains(_searchQuery.toLowerCase());
      
      final bool matchesCategory = _selectedCategories.isEmpty || 
          _selectedCategories.any((cat) => merchant.type.toLowerCase().contains(cat.toLowerCase()));

      return matchesSearch && matchesCategory;
    }).toList();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: const BoxDecoration(
                  color: Colors.white,
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
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  color: const Color(0xff2563EB),
                  backgroundColor: Colors.white,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
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
                              child: Row(
                                children: [
                                  const Icon(Icons.search, color: Color(0xff94A3B8), size: 15),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: _searchController,
                                      textInputAction: TextInputAction.search,
                                      onChanged: (value) {
                                        setState(() {
                                          _searchQuery = value;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        hintText: 'Cari bisnis...',
                                        hintStyle: TextStyle(color: Color(0xff94A3B8), fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Plus Jakarta Sans'),
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                  if (_searchQuery.isNotEmpty)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _searchController.clear();
                                          _searchQuery = "";
                                        });
                                      },
                                      child: const Icon(Icons.clear, color: Color(0xff94A3B8), size: 18),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: _showFilterSheet,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: _selectedCategories.isNotEmpty ? const Color(0xffDBEAFE) : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _selectedCategories.isNotEmpty ? const Color(0xff2563EB) : const Color(0xffE2E8F0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.tune, 
                                color: _selectedCategories.isNotEmpty ? const Color(0xff2563EB) : const Color(0xff475569), 
                                size: 18
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Bisnis Terdekat', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xff0F172A), fontFamily: 'Plus Jakarta Sans', height: 1.5)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = "";
                                _selectedCategories.clear();
                              });
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              child: Text('Lihat Semua', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xff2563EB), fontFamily: 'Plus Jakarta Sans', height: 1.33)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (merchantProvider.isLoading && !_isPullRefreshing)
                        const Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: Center(child: CircularProgressIndicator(color: Color(0xff2563EB))),
                        )
                      else if (merchantProvider.errorMessage.isNotEmpty)
                        Center(child: Text(merchantProvider.errorMessage, style: const TextStyle(color: Color(0xffBA1A1A), fontWeight: FontWeight.w500)))
                      else if (_isPullRefreshing) ...[
                        _buildShimmerCard(),
                        _buildShimmerCard(),
                      ] else if (filteredMerchants.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 40.0),
                          child: Center(
                            child: Text(
                              'Bisnis tidak ditemukan',
                              style: TextStyle(color: Color(0xff94A3B8), fontFamily: 'Plus Jakarta Sans'),
                            ),
                          ),
                        )
                      else
                        ...filteredMerchants.map((merchant) => MerchantCard(merchant: merchant)),
                    ],
                  ),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ScanQrView()),
                    );
                  },
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
      ),
    );
  }
}