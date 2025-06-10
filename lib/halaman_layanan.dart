// lib/halaman_layanan.dart
import 'package:flutter/material.dart';
import 'package:simrs/widgets/custom_app_bar.dart';
import 'package:simrs/widgets/custom_bottom_nav_bar.dart';

// Import halaman lain untuk navigasi BottomNavBar
import 'package:simrs/beranda.dart';
import 'package:simrs/halaman_pendaftaran.dart';
import 'package:simrs/halaman_pasien.dart';

class HalamanLayanan extends StatefulWidget {
  const HalamanLayanan({super.key});

  @override
  State<HalamanLayanan> createState() => _HalamanLayananState();
}

class _HalamanLayananState extends State<HalamanLayanan> {
  int _selectedIndex = 3; // Indeks untuk halaman Layanan di BottomNavBar

  // Data dummy untuk tabel Poli
  final List<Map<String, dynamic>> _dataPoli = [
    {
      'no': 1,
      'id_poli': 'p01',
      'nama_poli': 'Umum',
      'dokter_bertugas': 'dr. Bella',
    },
    {
      'no': 2,
      'id_poli': 'p02',
      'nama_poli': 'Mata',
      'dokter_bertugas': 'dr. Indah Permata',
    },
    {
      'no': 3,
      'id_poli': 'p03',
      'nama_poli': 'Gigi',
      'dokter_bertugas': 'dr. Andi Wijaya',
    },
    // Tambahkan data poli lainnya
  ];

  // Data dummy untuk tabel Dokter (akan kita isi nanti sesuai kebutuhan, ini contoh)
  final List<Map<String, dynamic>> _dataDokter = [
    {
      'no': 1,
      'nama_dokter': 'dr. Bella',
      'spesialisasi': 'Umum',
      'jadwal': 'Senin-Jumat',
    },
    {
      'no': 2,
      'nama_dokter': 'dr. Indah Permata',
      'spesialisasi': 'Mata',
      'jadwal': 'Selasa, Kamis',
    },
    // Tambahkan data dokter lainnya
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
    const Color biruUtama = Color(0xFF2E9AFE);
    const Color biruTeks = Color(0xFF0D47A1);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const CustomAppBar(),
      body: DefaultTabController(
        // Menggunakan DefaultTabController untuk tab
        length: 2, // Ada 2 tab: Poli & Dokter
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Text(
                'Layanan',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: biruTeks,
                ),
              ),
            ),
            // TabBar (Poli & Dokter)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: biruUtama,
                  borderRadius: BorderRadius.circular(8),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black54,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: 'Poli'),
                  Tab(text: 'Dokter'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Konten Search Bar dan Filter akan disesuaikan per tab
            Expanded(
              child: TabBarView(
                children: [
                  // Tab Poli
                  _buildPoliTabContent(_dataPoli),
                  // Tab Dokter (saat ini menggunakan struktur yang sama, bisa dimodifikasi nanti)
                  _buildDokterTabContent(_dataDokter),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  // --- Widget Khusus untuk Konten Tab Poli ---
  Widget _buildPoliTabContent(List<Map<String, dynamic>> data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
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
                      hintText: 'Cari berdasarkan ID Poli / Nama Poli',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tombol Filter Poli diklik!'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ), // Spasi antara search bar dan tombol Hari Ini
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Align(
            alignment: Alignment.centerLeft, // Rata kiri sesuai gambar
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Tombol Hari Ini diklik!')),
                );
              },
              icon: const Icon(Icons.calendar_today, size: 20),
              label: const Text('Hari Ini', style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Latar belakang putih
                foregroundColor: Colors.black87, // Teks hitam
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: Colors.grey.shade300,
                  ), // Border abu-abu
                ),
                elevation: 2, // Sedikit bayangan
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: _buildLayananDataTable(
            data: data,
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
                    'ID Poli',
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
                    'Nama Poli',
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
                    'Dokter Bertugas',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
            rowBuilder: (item) => DataRow(
              cells: [
                DataCell(Center(child: Text(item['no'].toString()))),
                DataCell(Center(child: Text(item['id_poli']))),
                DataCell(Center(child: Text(item['nama_poli']))),
                DataCell(Center(child: Text(item['dokter_bertugas']))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Widget Khusus untuk Konten Tab Dokter ---
  Widget _buildDokterTabContent(List<Map<String, dynamic>> data) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
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
                      hintText: 'Cari berdasarkan Nama Dokter / Spesialisasi',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tombol Filter Dokter diklik!'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: _buildLayananDataTable(
            data: data,
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
                    'Nama Dokter',
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
                    'Spesialisasi',
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
                    'Jadwal',
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
              ), // Tambah kolom Aksi untuk Dokter
            ],
            rowBuilder: (item) => DataRow(
              cells: [
                DataCell(Center(child: Text(item['no'].toString()))),
                DataCell(Center(child: Text(item['nama_dokter']))),
                DataCell(Center(child: Text(item['spesialisasi']))),
                DataCell(Center(child: Text(item['jadwal']))),
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
                              'Melihat detail dokter ${item['nama_dokter']}',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Widget Pembantu Umum untuk DataTable di Layanan ---
  Widget _buildLayananDataTable({
    required List<Map<String, dynamic>> data,
    required List<DataColumn> columns,
    required DataRow Function(Map<String, dynamic>) rowBuilder,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth:
                MediaQuery.of(context).size.width -
                32, // Lebar layar dikurangi padding halaman utama
          ),
          child: DataTable(
            columnSpacing: 0, // Tidak ada jarak antar kolom
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
            columns: columns,
            rows: data.map((item) => rowBuilder(item)).toList(),
          ),
        ),
      ),
    );
  }
}
