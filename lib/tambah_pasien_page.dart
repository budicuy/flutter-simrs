import 'package:flutter/material.dart';

class TambahPasienPage extends StatefulWidget {
  const TambahPasienPage({super.key});

  @override
  State<TambahPasienPage> createState() => _TambahPasienPageState();
}

class _TambahPasienPageState extends State<TambahPasienPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaPasienController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  DateTime? _tanggalLahir;
  String? _jenisKelamin;
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noTeleponController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  String? _agama;
  String? _statusPerkawinan;
  String? _golonganDarah;
  final TextEditingController _alergiController = TextEditingController();

  final List<String> _listJenisKelamin = ['Laki-laki', 'Perempuan'];
  final List<String> _listAgama = [
    'Islam',
    'Kristen',
    'Katolik',
    'Hindu',
    'Buddha',
    'Konghucu',
  ];
  final List<String> _listStatusPerkawinan = [
    'Belum Menikah',
    'Menikah',
    'Cerai Hidup',
    'Cerai Mati',
  ];
  final List<String> _listGolonganDarah = ['A', 'B', 'AB', 'O'];

  @override
  void dispose() {
    _namaPasienController.dispose();
    _nikController.dispose();
    _alamatController.dispose();
    _noTeleponController.dispose();
    _pekerjaanController.dispose();
    _alergiController.dispose();
    super.dispose();
  }

  Future<void> _selectTanggalLahir(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tanggalLahir ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _tanggalLahir) {
      setState(() {
        _tanggalLahir = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color biruUtama = Color(0xFF2E9AFE);
    // const Color biruTeks = Color(0xFF0D47A1);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Pasien',
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
              _buildTextFormField(
                controller: _nikController,
                labelText: 'NIK',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'NIK tidak boleh kosong';
                  }
                  if (value.length != 16) {
                    return 'NIK harus 16 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildDateField(
                context: context,
                labelText: 'Tanggal Lahir',
                selectedDate: _tanggalLahir,
                onTap: () => _selectTanggalLahir(context),
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _noTeleponController,
                labelText: 'No. Telepon',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No. Telepon tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _pekerjaanController,
                labelText: 'Pekerjaan',
              ),
              const SizedBox(height: 16),
              _buildDropdownFormField(
                value: _agama,
                labelText: 'Agama',
                items: _listAgama,
                onChanged: (value) {
                  setState(() {
                    _agama = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownFormField(
                value: _statusPerkawinan,
                labelText: 'Status Perkawinan',
                items: _listStatusPerkawinan,
                onChanged: (value) {
                  setState(() {
                    _statusPerkawinan = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildDropdownFormField(
                value: _golonganDarah,
                labelText: 'Golongan Darah',
                items: _listGolonganDarah,
                onChanged: (value) {
                  setState(() {
                    _golonganDarah = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: _alergiController,
                labelText: 'Alergi (jika ada)',
                maxLines: 2,
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
                        // Proses simpan data pasien
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Data pasien disimpan!'),
                          ),
                        );
                        // Tambahkan logika untuk menyimpan data ke database atau state management
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
