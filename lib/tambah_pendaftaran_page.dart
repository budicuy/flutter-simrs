import 'package:flutter/material.dart';

class TambahPendaftaranPage extends StatefulWidget {
  const TambahPendaftaranPage({super.key});

  @override
  State<TambahPendaftaranPage> createState() => _TambahPendaftaranPageState();
}

class _TambahPendaftaranPageState extends State<TambahPendaftaranPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noRekamMedisController = TextEditingController();
  final TextEditingController _namaPasienController = TextEditingController();
  DateTime? _tanggalLahir;
  String? _jenisKelamin;
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  String? _jenisLayanan; // Bisa jadi dropdown atau text field biasa
  String? _dokter; // Bisa jadi dropdown atau text field biasa
  DateTime _tanggalPendaftaran = DateTime.now();
  final TextEditingController _keluhanController = TextEditingController();

  final List<String> _listJenisKelamin = ['Laki-laki', 'Perempuan'];
  // Contoh list layanan dan dokter, idealnya ini dari data dinamis
  final List<String> _listJenisLayanan = ['Umum', 'Gigi', 'Mata', 'Anak'];
  final List<String> _listDokter = ['dr. Budi', 'dr. Ani', 'dr. Citra'];

  @override
  void dispose() {
    _noRekamMedisController.dispose();
    _namaPasienController.dispose();
    _alamatController.dispose();
    _noTeleponController.dispose();
    _keluhanController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isTanggalLahir) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isTanggalLahir
          ? (_tanggalLahir ?? DateTime.now())
          : _tanggalPendaftaran,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isTanggalLahir) {
          _tanggalLahir = picked;
        } else {
          _tanggalPendaftaran = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color biruUtama = Color(0xFF2E9AFE);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Pendaftaran',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: biruUtama,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextFormField(
                controller: _noRekamMedisController,
                labelText: 'No. Rekam Medis',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No. Rekam Medis tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _namaPasienController,
                labelText: 'Nama Pasien',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama Pasien tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDateField(
                context: context,
                labelText: 'Tanggal Lahir',
                selectedDate: _tanggalLahir,
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 16),
              _buildDropdownFormField(
                value: _jenisKelamin,
                labelText: 'Jenis Kelamin',
                items: _listJenisKelamin,
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Jenis Kelamin harus dipilih' : null,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _alamatController,
                labelText: 'Alamat',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _noTeleponController,
                labelText: 'No. Telepon',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              _buildDropdownFormField(
                value: _jenisLayanan,
                labelText: 'Jenis Layanan',
                items: _listJenisLayanan,
                onChanged: (value) {
                  setState(() {
                    _jenisLayanan = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Jenis Layanan harus dipilih' : null,
              ),
              const SizedBox(height: 16),
              _buildDropdownFormField(
                value: _dokter,
                labelText: 'Dokter',
                items:
                    _listDokter, // Anda mungkin perlu memfilter dokter berdasarkan layanan
                onChanged: (value) {
                  setState(() {
                    _dokter = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Dokter harus dipilih' : null,
              ),
              const SizedBox(height: 16),
              _buildDateField(
                context: context,
                labelText: 'Tanggal Pendaftaran',
                selectedDate: _tanggalPendaftaran,
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _keluhanController,
                labelText: 'Keluhan',
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Batal',
                      style: TextStyle(color: biruUtama),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Proses simpan data
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data pendaftaran disimpan!'),
                          ),
                        );
                        // Anda bisa tambahkan logika untuk menyimpan data ke database atau state management
                        // Kemudian kembali ke halaman sebelumnya atau halaman detail
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: biruUtama,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    );
  }

  Widget _buildDropdownFormField({
    required String? value,
    required String labelText,
    required List<String> items,
    required void Function(String?)? onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildDateField({
    required BuildContext context,
    required String labelText,
    required DateTime? selectedDate,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        child: Text(
          selectedDate == null
              ? 'Pilih tanggal'
              : "${selectedDate.toLocal()}".split(' ')[0], // Format YYYY-MM-DD
        ),
      ),
    );
  }
}
