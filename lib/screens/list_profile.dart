import 'package:flutter/material.dart'; // Paket UI Material
import '../models/profile.dart'; // Model Profile (struktur data profil)
import '../models/profile_data.dart'; // Data list profil yang digunakan aplikasi
import 'detail_profile.dart'; // Import halaman detail profil

// Widget utama untuk menampilkan daftar profil
class ListProfile extends StatefulWidget {
  ListProfile({super.key});

  @override
  State<ListProfile> createState() => _ListProfileState();
}

// State dari ListProfile yang menyimpan dan mengelola perubahan data
class _ListProfileState extends State<ListProfile> {
  // Fungsi untuk menampilkan dialog tambah profil
  void _showAddProfileDialog() {
    final nameController = TextEditingController(); // Controller input nama
    final nimController = TextEditingController(); // Controller input NIM

    // Menampilkan dialog input data profil baru
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Tambah Profil'), // Judul dialog
            content: SingleChildScrollView(
              // Agar scrollable jika tinggi
              child: Column(
                mainAxisSize: MainAxisSize.min, // Ukuran minimum sesuai konten
                children: [
                  TextField(
                    controller: nameController, // Input nama
                    decoration: const InputDecoration(labelText: 'Nama'),
                  ),
                  TextField(
                    controller: nimController, // Input NIM
                    decoration: const InputDecoration(labelText: 'NIM'),
                  ),
                ],
              ),
            ),
            actions: [
              // Tombol batal (menutup dialog)
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
              // Tombol tambah (menyimpan profil baru)
              ElevatedButton(
                onPressed: () {
                  // Validasi input nama tidak kosong
                  if (nameController.text.trim().isNotEmpty) {
                    setState(() {
                      profiles.add(
                        Profile(
                          id: profiles.length + 1,
                          name: nameController.text.trim(),
                          nim: nimController.text.trim(),
                          kelas: '-', // Default
                          sd: '-', // Default
                          smp: '-', // Default
                          smk: '-', // Default
                          kampus: '-', // Default
                          image: 'assets/images/images.png', // Gambar default
                          background:
                              'assets/images/nature.webp', // Background default
                        ),
                      );
                    });
                    Navigator.pop(context); // Tutup dialog
                    // Tampilkan notifikasi berhasil
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Profil ${nameController.text} ditambahkan',
                        ),
                      ),
                    );
                  }
                },
                child: const Text('Tambah'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Body berisi daftar profil yang ditampilkan dengan ListView
      body: ListView.builder(
        itemCount: profiles.length, // Jumlah item berdasarkan daftar profil
        itemBuilder: (context, index) {
          final profile = profiles[index]; // Ambil data profil
          return Card(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ), // Spasi antar card
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(profile.image), // Foto profil
              ),
              title: Text(profile.name), // Nama
              subtitle: Text('NIM: ${profile.nim}'), // NIM
              // Ketika profil ditekan, navigasi ke halaman detail
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailProfile(profile: profile),
                  ),
                );
              },
              // Tombol hapus profil
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                tooltip: 'Hapus Profil',
                onPressed: () {
                  setState(() {
                    profiles.removeAt(index); // Hapus profil dari list
                  });
                  // Notifikasi bahwa profil dihapus
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Profil ${profile.name} dihapus')),
                  );
                },
              ),
            ),
          );
        },
      ),
      // Tombol mengambang untuk menambah profil
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddProfileDialog, // Panggil fungsi tambah profil
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
        tooltip: 'Tambah Profil',
      ),
    );
  }
}
