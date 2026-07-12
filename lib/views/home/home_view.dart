import 'package:flutter/material.dart';
import '../../components/gradient_background.dart';
import 'tabs/beranda_tab.dart';
import 'tabs/antrean_tab.dart';
import 'tabs/profil_tab.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _tabs = const [
    BerandaTab(),
    AntreanTab(),
    ProfilTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: _tabs[_currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xffF1F5F9), width: 1.0),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xff2563EB),
          unselectedItemColor: const Color(0xff94A3B8),
          selectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            fontFamily: 'Plus Jakarta Sans',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontFamily: 'Plus Jakarta Sans',
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home), 
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              activeIcon: Icon(Icons.list_alt),
              label: 'Antrean Saya',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.perm_identity),
              activeIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}