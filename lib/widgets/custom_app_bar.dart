// lib/widgets/custom_app_bar.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simrs/layar_login.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    const Color biruUtama = Color(0xFF2E9AFE);

    return AppBar(
      backgroundColor: biruUtama,
      elevation: 0,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Image.asset('assets/logo.png', height: 40),
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
              PopupMenuButton<int>(
                icon: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: biruUtama),
                ),
                offset: const Offset(0, 50),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 8,
                onSelected: (item) async {
                  if (item == 1) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setBool('isLoggedIn', false);

                    // Cek mounted sebelum menggunakan context setelah async gap
                    if (!context.mounted) return; // Menggunakan context.mounted
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LayarLogin(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                    // Cek mounted sebelum menggunakan context setelah async gap
                    if (!context.mounted) return; // Menggunakan context.mounted
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Anda telah keluar.')),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    enabled: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Indira Kalista',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          'Admin Pendaftaran',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<int>(
                    value: 1,
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
            ],
          ),
        ),
      ),
    );
  }
}
