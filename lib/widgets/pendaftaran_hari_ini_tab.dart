// lib/pendaftaran_hari_ini_tab.dart
import 'package:flutter/material.dart';

class PendaftaranHariIniTab extends StatefulWidget {
  const PendaftaranHariIniTab({super.key});

  @override
  State<PendaftaranHariIniTab> createState() => _PendaftaranHariIniTabState();
}

class _PendaftaranHariIniTabState extends State<PendaftaranHariIniTab> {
  // Data dummy khusus untuk tab Hari Ini
  final List<Map<String, dynamic>> _dataPendaftaranHariIni = [
    {
      'no': 1,
      'no_regis': '001',
      'nama_pasien': 'Andi Pratama',
      'status': 'Menunggu',
    },
    {'no': 2, 'no_regis': '002', 'nama_pasien': 'Putri', 'status': 'Selesai'},
    // Data lainnya untuk Hari Ini
  ];

  @override
  Widget build(BuildContext context) {
    return _buildPendaftaranList(_dataPendaftaranHariIni);
  }

  // Widget pembantu untuk membangun daftar pendaftaran (tabel)
  // Ini adalah kode _buildPendaftaranList yang sudah disesuaikan dan dirapikan
  Widget _buildPendaftaranList(List<Map<String, dynamic>> data) {
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
            columnSpacing: 24, // Jarak antar kolom
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
            rows: data
                .map(
                  (item) => DataRow(
                    cells: [
                      DataCell(Center(child: Text(item['no'].toString()))),
                      DataCell(Center(child: Text(item['no_regis']))),
                      DataCell(Center(child: Text(item['nama_pasien']))),
                      DataCell(
                        Center(
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
}
