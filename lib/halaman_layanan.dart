// lib/halaman_layanan.dart
import 'package:flutter/material.dart';
import 'package:simrs/widgets/custom_app_bar.dart';
import 'package:simrs/widgets/custom_bottom_nav_bar.dart';
import 'package:simrs/beranda.dart';
import 'package:simrs/halaman_pendaftaran.dart';
import 'package:simrs/halaman_pasien.dart';

class HalamanLayanan extends StatefulWidget {
  const HalamanLayanan({super.key});

  @override
  State<HalamanLayanan> createState() => _HalamanLayananState();
}

class _HalamanLayananState extends State<HalamanLayanan> {
  int _selectedIndex = 3; // Sesuaikan dengan indeks item ini di navbar

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Beranda()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HalamanPendaftaran()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HalamanPasien()),
          );
          break;
        case 3:
          // Sudah di halaman ini
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text('Ini Halaman Layanan', style: TextStyle(fontSize: 24)),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
