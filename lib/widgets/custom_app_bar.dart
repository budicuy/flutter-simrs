// lib/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Untuk logout
import 'package:simrs/layar_login.dart'; // Untuk kembali ke halaman login setelah logout

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60.0); // Tinggi AppBar kustom

  @override
  Widget build(BuildContext context) {
    const Color biruUtama = Color(0xFF2E9AFE);

    return AppBar(
      backgroundColor: biruUtama,
      elevation: 0, // Hapus bayangan default AppBar
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Image.asset(
                'assets/logo.png', // Pastikan path ini benar!
                height: 40,
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RUMAH SAKIT ISLAM',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'BANJARMASIN',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const VerticalDivider(
                color: Color(
                  0x8AFFFFFF,
                ), // Menggunakan ARGB hex untuk 54% opacity (8A)
                thickness: 1,
                indent: 10,
                endIndent: 10,
                width: 20,
              ),
              // --- PERUBAHAN UTAMA DI SINI: GANTI DENGAN PopupMenuButton ---
              PopupMenuButton<int>(
                icon: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: biruUtama),
                ),
                offset: const Offset(
                  0,
                  50,
                ), // Geser menu sedikit ke bawah agar tidak menutupi ikon
                color: Colors.white, // Latar belakang menu putih
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Sudut melengkung
                ),
                elevation: 8, // Tambah bayangan
                onSelected: (item) async {
                  if (item == 1) {
                    // Logika untuk tombol "Keluar"
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool(
                      'isLoggedIn',
                      false,
                    ); // Set status logout

                    // Kembali ke halaman login
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LayarLogin(),
                      ),
                      (Route<dynamic> route) =>
                          false, // Hapus semua route sebelumnya
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Anda telah keluar.')),
                    );
                  }
                  // Jika ada item lain, bisa ditambahkan logika di sini
                },
                itemBuilder: (context) => [
                  // Item 1: Informasi Pengguna (tanpa value, hanya sebagai header)
                  PopupMenuItem<int>(
                    value: 0, // Nilai dummy, tidak akan diselect
                    enabled: false, // Tidak bisa diklik
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Indira Kalista', // NAMA USER
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Admin Pendaftaran', // JABATAN USER
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(), // Garis pemisah
                  // Item 2: Tombol Keluar
                  const PopupMenuItem<int>(
                    value: 1, // Nilai untuk tombol Keluar
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Keluar', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
              ),
              // --- AKHIR PERUBAHAN ---
            ],
          ),
        ),
      ),
    );
  }
}
