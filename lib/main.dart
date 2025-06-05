// lib/main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simrs/layar_login.dart';
import 'package:simrs/beranda.dart';

// Pastikan fungsi main() ini ada dan memanggil runApp()
void main() {
  // Tambahkan WidgetsFlutterBinding.ensureInitialized(); di sini jika belum ada
  // Ini penting terutama jika ada operasi async di awal (misal shared_preferences)
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool? isLoggedIn = prefs.getBool('isLoggedIn');
    setState(() {
      _isLoggedIn = isLoggedIn ?? false;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Rumah Sakit Islam',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: _isLoggedIn ? const Beranda() : const LayarLogin(),
      );
    }
  }
}
