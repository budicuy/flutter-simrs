// lib/beranda.dart
import 'package:flutter/material.dart';
import 'package:simrs/widgets/custom_app_bar.dart';
import 'package:simrs/widgets/custom_bottom_nav_bar.dart';
import 'package:simrs/halaman_pendaftaran.dart';
import 'package:simrs/halaman_pasien.dart';
import 'package:simrs/halaman_layanan.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  final List<Map<String, dynamic>> _statistikData = [
    {
      'judul': 'Pendaftaran',
      'jumlah': 50,
      'ikon': Icons.description,
      'warnaIkon': const Color(0xFFF9A825),
    },
    {
      'judul': 'Pasien',
      'jumlah': 150,
      'ikon': Icons.person,
      'warnaIkon': const Color(0xFF81D4FA),
    },
    {
      'judul': 'Poli',
      'jumlah': 30,
      'ikon': Icons.local_hospital,
      'warnaIkon': const Color(0xFFEF9A9A),
    },
    {
      'judul': 'Dokter',
      'jumlah': 30,
      'ikon': Icons.people,
      'warnaIkon': const Color(0xFF4DB6AC),
    },
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        if (ModalRoute.of(context)?.settings.name != '/') {
          // Cek mounted sebelum menggunakan context setelah async gap
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Beranda()),
          );
        }
        break;
      case 1:
        // Cek mounted sebelum menggunakan context setelah async gap
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HalamanPendaftaran()),
        );
        break;
      case 2:
        // Cek mounted sebelum menggunakan context setelah async gap
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HalamanPasien()),
        );
        break;
      case 3:
        // Cek mounted sebelum menggunakan context setelah async gap
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HalamanLayanan()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color biruGelapHeader = Color(0xFF0D47A1);

    final DateTime now = DateTime.now();
    final String formattedDate =
        '${_getDayName(now.weekday)}, ${now.day} ${_getMonthName(now.month)} ${now.year}';

    return Scaffold(
      backgroundColor:
          Colors.grey[100], // Sesuaikan dengan warna yang kamu inginkan
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Beranda',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: biruGelapHeader,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Selamat datang, Admin!',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      // Perbaikan: Ganti withOpacity
                      color: const Color(0xFF000000).withAlpha(
                        (0.2 * 255).round(),
                      ), // 0x33000000, 20% opacity of black
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'Data Hari Ini : $formattedDate',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: _statistikData.length,
                itemBuilder: (context, index) {
                  final data = _statistikData[index];
                  return _buildStatistikCard(
                    context,
                    data['judul'],
                    data['jumlah'],
                    data['ikon'],
                    data['warnaIkon'],
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildStatistikCard(
    BuildContext context,
    String title,
    int count,
    IconData icon,
    Color iconBackgroundColor,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          // Cek mounted sebelum menggunakan context setelah async gap
          if (!mounted) return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Anda menekan $title')));
        },
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: iconBackgroundColor,
                    child: Icon(icon, color: Colors.white, size: 28),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey, size: 30),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Senin';
      case 2:
        return 'Selasa';
      case 3:
        return 'Rabu';
      case 4:
        return 'Kamis';
      case 5:
        return 'Jumat';
      case 6:
        return 'Sabtu';
      case 7:
        return 'Minggu';
      default:
        return '';
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Januari';
      case 2:
        return 'Februari';
      case 3:
        return 'Maret';
      case 4:
        return 'April';
      case 5:
        return 'Mei';
      case 6:
        return 'Juni';
      case 7:
        return 'Juli';
      case 8:
        return 'Agustus';
      case 9:
        return 'September';
      case 10:
        return 'Oktober';
      case 11:
        return 'November';
      case 12:
        return 'Desember';
      default:
        return '';
    }
  }
}
