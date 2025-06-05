// lib/widgets/custom_bottom_nav_bar.dart
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    const Color biruUtama = Color(0xFF2E9AFE);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      selectedItemColor: biruUtama, // Warna ikon terpilih
      unselectedItemColor: Colors.grey, // Warna ikon tidak terpilih
      showUnselectedLabels:
          true, // Tampilkan label untuk item yang tidak terpilih
      type: BottomNavigationBarType
          .fixed, // Agar item tidak bergerak saat dipilih
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard), // Mirip ikon grid
          label: 'Beranda',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.description), // Mirip ikon pendaftaran
          label: 'Pendaftaran',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Pasien'),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month), // Mirip ikon kalender
          label: 'Layanan',
        ),
      ],
    );
  }
}
