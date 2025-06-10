// lib/halaman_pendaftaran.dart
import 'package:flutter/material.dart';
import 'package:simrs/widgets/custom_app_bar.dart';
import 'package:simrs/widgets/custom_bottom_nav_bar.dart';
import 'package:simrs/beranda.dart';
import 'package:simrs/halaman_pasien.dart';
import 'package:simrs/halaman_layanan.dart';
import 'package:simrs/tambah_pendaftaran_page.dart'; // Import halaman tambah pendaftaran

class HalamanPendaftaran extends StatefulWidget {
  const HalamanPendaftaran({super.key});

  @override
  State<HalamanPendaftaran> createState() => _HalamanPendaftaranState();
}

class _HalamanPendaftaranState extends State<HalamanPendaftaran> {
  int _selectedIndex = 1;

  // Data dummy dikembalikan ke sini
  final List<Map<String, dynamic>> _dataPendaftaranHariIni = [
    {
      'no': 1,
      'no_regis': '001',
      'nama_pasien': 'Andi Pratama',
      'status': 'Menunggu',
    },
    {'no': 2, 'no_regis': '002', 'nama_pasien': 'Putri', 'status': 'Selesai'},
  ];

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
      'status': 'selesai',
    },
  ];

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      switch (index) {
        case 0:
          // Cek mounted sebelum menggunakan context setelah async gap
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Beranda()),
          );
          break;
        case 1:
          // Tetap di halaman Pendaftaran
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
  }

  @override
  Widget build(BuildContext context) {
    const Color biruUtama = Color(0xFF2E9AFE);
    const Color biruTeks = Color(0xFF0D47A1);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const CustomAppBar(),
      body: DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Added
          children: [
            Padding(
              // Modified
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
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
                      // Cek mounted sebelum menggunakan context setelah async gap
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TambahPendaftaranPage(),
                        ),
                      );
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
            ),
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
                  Tab(text: 'Hari ini'),
                  Tab(text: 'Riwayat'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                children: [
                  _buildPendaftaranTabContent(
                    _dataPendaftaranHariIni,
                    'Cari berdasarkan No. Regis',
                  ), // Modified
                  _buildPendaftaranTabContent(
                    _dataPendaftaranRiwayat,
                    'Cari berdasarkan No. Regis Riwayat',
                  ), // Modified
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

  // New widget for tab content
  Widget _buildPendaftaranTabContent(
    List<Map<String, dynamic>> data,
    String searchHint,
  ) {
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
                      hintText: searchHint,
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
                    // Cek mounted sebelum menggunakan context setelah async gap
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tombol Filter diklik!')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(child: _buildPendaftaranList(data)),
      ],
    );
  }

  // _buildPendaftaranList dikembalikan ke sini
  Widget _buildPendaftaranList(List<Map<String, dynamic>> data) {
    return _buildLayananDataTable(
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
              'No. Regis',
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
              'Status',
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
          DataCell(Center(child: Text(item['no_regis']))),
          DataCell(Center(child: Text(item['nama_pasien']))),
          DataCell(
            Center(
              child: PopupMenuButton<String>(
                onSelected: (String newStatus) {
                  setState(() {
                    // Update status di data source yang sesuai
                    // Kita perlu cara untuk mengetahui apakah item ini dari _dataPendaftaranHariIni atau _dataPendaftaranRiwayat
                    // Untuk saat ini, kita akan mencoba update di kedua list jika ada,
                    // atau idealnya, pastikan 'item' adalah referensi langsung ke objek di dalam list.
                    // Jika 'data' yang dioper ke _buildPendaftaranList adalah salah satu dari _dataPendaftaranHariIni atau _dataPendaftaranRiwayat,
                    // maka 'item' akan menjadi referensi ke map di dalam list tersebut.
                    item['status'] = newStatus;
                  });
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Menunggu',
                    child: Text('Menunggu'),
                  ),
                  const PopupMenuItem<String>(
                    value: 'Selesai',
                    child: Text('Selesai'),
                  ),
                  // Anda bisa menambahkan 'Batal' jika diperlukan juga
                  // const PopupMenuItem<String>(
                  //   value: 'Batal',
                  //   child: Text('Batal'),
                  // ),
                ],
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildStatusChip(item['status']),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.grey,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // _buildStatusChip dikembalikan ke sini
  Widget _buildStatusChip(String status) {
    Color textColor;
    Color backgroundColor;

    switch (status) {
      case 'Menunggu':
        textColor = const Color(0xFFF9A825);
        backgroundColor = const Color(0xFFFFF8E1);
        break;
      case 'Selesai':
        textColor = const Color(0xFF4CAF50);
        backgroundColor = const Color(0xFFE8F5E9);
        break;
      case 'Batal':
        textColor = const Color(0xFFEF5350);
        backgroundColor = const Color(0xFFFFEBEE);
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
