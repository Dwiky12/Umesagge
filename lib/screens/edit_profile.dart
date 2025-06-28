// ✅ Edit Profile yang memperbarui data profil secara langsung
import 'package:flutter/material.dart';
import '../models/profile.dart';

class EditProfile extends StatefulWidget {
  final Profile profile; // menerima profil yang ingin diedit
  const EditProfile({super.key, required this.profile});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Controller diisi berdasarkan data awal dari profil
  //
  late final TextEditingController _nameController;
  late final TextEditingController _nimController;
  late final TextEditingController _kelasController;
  late final TextEditingController _sdController;
  late final TextEditingController _smpController;
  late final TextEditingController _smkController;
  late final TextEditingController _kampusController;

  // Inisialisasi controller dengan data profil yang ada
  // 3️⃣ semua data seperti name, nim, kelas, dll. diambil dari widget.profile dan dimasukkan ke dalam controller.
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _nimController = TextEditingController(text: widget.profile.nim);
    _kelasController = TextEditingController(text: widget.profile.kelas);
    _sdController = TextEditingController(text: widget.profile.sd);
    _smpController = TextEditingController(text: widget.profile.smp);
    _smkController = TextEditingController(text: widget.profile.smk);
    _kampusController = TextEditingController(text: widget.profile.kampus);
  }

  @override
  void dispose() {
    // Bersihkan controller saat widget dihancurkan
    _nameController.dispose();
    _nimController.dispose();
    _kelasController.dispose();
    _sdController.dispose();
    _smpController.dispose();
    _smkController.dispose();
    _kampusController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    // Perbarui data profil yang diedit
    // 5️⃣ Saat tombol simpan ditekan, data dari controller disimpan ke widget.profile. Tidak perlu return karena objeknya sama
    setState(() {
      widget.profile.name = _nameController.text;
      widget.profile.nim = _nimController.text;
      widget.profile.kelas = _kelasController.text;
      widget.profile.sd = _sdController.text;
      widget.profile.smp = _smpController.text;
      widget.profile.smk = _smkController.text;
      widget.profile.kampus = _kampusController.text;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Profil berhasil diperbarui')));
    Navigator.pop(context); // kembali ke halaman sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // 4️⃣ Saat pengguna mengetik sesuatu di TextField, datanya tersimpan di controller, bukan langsung di profile.
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama'),
            ),
            TextField(
              controller: _nimController,
              decoration: const InputDecoration(labelText: 'NIM'),
            ),
            TextField(
              controller: _kelasController,
              decoration: const InputDecoration(labelText: 'Kelas'),
            ),
            TextField(
              controller: _sdController,
              decoration: const InputDecoration(labelText: 'SD'),
            ),
            TextField(
              controller: _smpController,
              decoration: const InputDecoration(labelText: 'SMP'),
            ),
            TextField(
              controller: _smkController,
              decoration: const InputDecoration(labelText: 'SMK'),
            ),
            TextField(
              controller: _kampusController,
              decoration: const InputDecoration(labelText: 'Kampus'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _saveProfile,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
