// lib/halaman_pendaftaran.dart
import 'package:flutter/material.dart';
import 'package:simrs/widgets/custom_app_bar.dart';
import 'package:simrs/widgets/custom_bottom_nav_bar.dart';

// Import halaman-halaman lain untuk navigasi BottomNavBar
import 'package:simrs/beranda.dart';
import 'package:simrs/halaman_pasien.dart';
import 'package:simrs/halaman_layanan.dart';

class HalamanPendaftaran extends StatefulWidget {
  const HalamanPendaftaran({super.key});

  @override
  State<HalamanPendaftaran> createState() => _HalamanPendaftaranState();
}

class _HalamanPendaftaranState extends State<HalamanPendaftaran> {
  int _selectedIndex =
      1; // Sesuaikan dengan indeks item ini di navbar (Pendaftaran adalah index 1)

  // Data dummy untuk tabel pendaftaran hari ini
  final List<Map<String, dynamic>> _dataPendaftaranHariIni = [
    {
      'no': 1,
      'no_regis': '001',
      'nama_pasien': 'Andi Pratama',
      'status': 'Menunggu',
    },
    {'no': 2, 'no_regis': '002', 'nama_pasien': 'Putri', 'status': 'Selesai'},
    // Tambahkan data lainnya sesuai kebutuhan
  ];

  // Data dummy untuk tabel pendaftaran riwayat (Contoh saja)
  final List<Map<String, dynamic>> _dataPendaftaranRiwayat = [
    {
      'no': 1,
      'no_regis': 'R001',
      'nama_pasien': 'Budi Santoso',
      'status': 'Selesai',
    },
    {
      'no': 2,
      'no_regis': 'R002',
      'nama_pasien': 'Citra Dewi',
      'status': 'Batal',
    },
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
          // Sudah di halaman ini
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HalamanPasien()),
          );
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
      appBar: const CustomAppBar(), // Menggunakan AppBar kustom
      body: DefaultTabController(
        // Menggunakan DefaultTabController untuk tab
        length: 2, // Ada 2 tab: Hari ini & Riwayat
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Pendaftaran',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: biruTeks,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Aksi ketika tombol "Tambah" diklik
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Tombol Tambah diklik!')),
                      );
                      // Contoh: Navigator.push(context, MaterialPageRoute(builder: (context) => const FormPendaftaranBaru()));
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
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // TabBar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey[200], // Latar belakang tab
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                indicator: BoxDecoration(
                  color: biruUtama, // Warna indikator tab yang aktif
                  borderRadius: BorderRadius.circular(10),
                ),
                labelColor: Colors.white, // Warna teks tab aktif
                unselectedLabelColor:
                    Colors.black54, // Warna teks tab tidak aktif
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(text: 'Hari ini'),
                  Tab(text: 'Riwayat'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Search Bar dan Filter
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
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
                          hintText: 'Cari berdasarkan No. Regis',
                          hintStyle: const TextStyle(color: Colors.grey),
                          prefixIcon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none, // Hapus border default
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
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
                      onPressed: () {
                        // Aksi ketika tombol filter diklik
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Tombol Filter diklik!'),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // TabBarView untuk menampilkan konten tab
            Expanded(
              child: TabBarView(
                children: [
                  _buildPendaftaranList(
                    _dataPendaftaranHariIni,
                  ), // Konten "Hari ini"
                  _buildPendaftaranList(
                    _dataPendaftaranRiwayat,
                  ), // Konten "Riwayat"
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

  // Widget pembantu untuk membangun daftar pendaftaran (tabel)
  Widget _buildPendaftaranList(List<Map<String, dynamic>> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical, // Scroll vertikal
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Scroll horizontal jika tabel lebar
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DataTable(
            columnSpacing: 16, // Jarak antar kolom
            dataRowMinHeight: 48,
            dataRowMaxHeight: 56,
            headingRowHeight: 56,
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
                label: Text(
                  'No',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'No. Regis',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Nama Pasien',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
            rows: data
                .map(
                  (item) => DataRow(
                    cells: [
                      DataCell(Text(item['no'].toString())),
                      DataCell(Text(item['no_regis'])),
                      DataCell(Text(item['nama_pasien'])),
                      DataCell(
                        Row(
                          children: [
                            _buildStatusChip(item['status']),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.grey,
                            ), // Ikon panah bawah
                          ],
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

  // Widget pembantu untuk menampilkan chip status
  Widget _buildStatusChip(String status) {
    Color textColor;
    Color backgroundColor;

    switch (status) {
      case 'Menunggu':
        textColor = const Color(0xFFF9A825); // Kuning
        backgroundColor = const Color(0xFFFFF8E1); // Kuning muda
        break;
      case 'Selesai':
        textColor = const Color(0xFF4CAF50); // Hijau
        backgroundColor = const Color(0xFFE8F5E9); // Hijau muda
        break;
      case 'Batal':
        textColor = const Color(0xFFEF5350); // Merah
        backgroundColor = const Color(0xFFFFEBEE); // Merah muda
        break;
      default:
        textColor = Colors.grey;
        backgroundColor = Colors.grey[200]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(status, style: TextStyle(color: textColor, fontSize: 12)),
    );
  }
}
