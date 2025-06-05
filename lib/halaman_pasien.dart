// lib/halaman_pasien.dart
import 'package:flutter/material.dart';
import 'package:simrs/widgets/custom_app_bar.dart';
import 'package:simrs/widgets/custom_bottom_nav_bar.dart';

// Import halaman lain untuk navigasi BottomNavBar
import 'package:simrs/beranda.dart';
import 'package:simrs/halaman_pendaftaran.dart';
import 'package:simrs/halaman_layanan.dart';

class HalamanPasien extends StatefulWidget {
  const HalamanPasien({super.key});

  @override
  State<HalamanPasien> createState() => _HalamanPasienState();
}

class _HalamanPasienState extends State<HalamanPasien> {
  int _selectedIndex = 2; // Indeks untuk halaman Pasien di BottomNavBar

  // Data dummy untuk tabel pasien
  final List<Map<String, dynamic>> _dataPasien = [
    {'no': 1, 'rekam_medis': '001', 'nama_pasien': 'Andi Pratama'},
    {'no': 2, 'rekam_medis': '002', 'nama_pasien': 'Putri'},
    // Tambahkan data pasien lainnya di sini
  ];

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
    const Color biruUtama = Color(0xFF2E9AFE);
    const Color biruTeks = Color(0xFF0D47A1);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Data Pasien',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: biruTeks,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Aksi ketika tombol "Tambah" diklik di halaman Pasien
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tombol Tambah Pasien diklik!'),
                      ),
                    );
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => const FormTambahPasien()));
                  },
                  icon: const Icon(Icons.add, size: 24),
                  label: const Text('Tambah', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: biruUtama,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Search Bar dan Filter
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari berdasarkan RM / Nama / NIK',
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 10,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.grey),
                    iconSize: 24,
                    onPressed: () {
                      // Aksi ketika tombol filter diklik di halaman Pasien
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tombol Filter Pasien diklik!'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildPasienList(_dataPasien)),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildPasienList(List<Map<String, dynamic>> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 32,
          ),
          child: DataTable(
            columnSpacing:
                0, // <--- PERUBAHAN DI SINI! Set ke 0 untuk menghilangkan jarak
            dataRowMinHeight: 48,
            dataRowMaxHeight: 56,
            headingRowHeight: 56,
            horizontalMargin: 0, // Tetap 0 agar tidak ada margin di luar
            headingRowColor: MaterialStateProperty.all(Colors.grey.shade50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            columns: const [
              DataColumn(
                label: Center(
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Rekam Medis',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Nama Pasien',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              DataColumn(
                label: Center(
                  child: Text(
                    'Aksi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
            rows: data
                .map(
                  (item) => DataRow(
                    cells: [
                      DataCell(Center(child: Text(item['no'].toString()))),
                      DataCell(Center(child: Text(item['rekam_medis']))),
                      DataCell(Center(child: Text(item['nama_pasien']))),
                      DataCell(
                        Center(
                          child: IconButton(
                            icon: const Icon(
                              Icons.visibility_outlined,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Melihat detail pasien ${item['nama_pasien']}',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
