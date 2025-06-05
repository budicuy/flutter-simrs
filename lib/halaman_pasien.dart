// lib/halaman_pasien.dart
import 'package:flutter/material.dart';
import 'package:simrs/widgets/custom_app_bar.dart';
import 'package:simrs/widgets/custom_bottom_nav_bar.dart';
import 'package:simrs/beranda.dart';
import 'package:simrs/halaman_pendaftaran.dart';
import 'package:simrs/halaman_layanan.dart';

class HalamanPasien extends StatefulWidget {
  const HalamanPasien({super.key});

  @override
  State<HalamanPasien> createState() => _HalamanPasienState();
}

class _HalamanPasienState extends State<HalamanPasien> {
  int _selectedIndex = 2; // Sesuaikan dengan indeks item ini di navbar

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
          // Sudah di halaman ini
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HalamanLayanan()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: const Center(
        child: Text('Ini Halaman Pasien', style: TextStyle(fontSize: 24)),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
