import 'package:flutter/material.dart'; // Import package material design Flutter
import '../models/profile.dart'; // Import model data profil
import 'edit_profile.dart'; // Import halaman edit profil

// Widget Stateful untuk halaman detail profil
class DetailProfile extends StatefulWidget {
  final Profile profile; // Data profil yang akan ditampilkan

  const DetailProfile({super.key, required this.profile});

  @override
  State<DetailProfile> createState() => _DetailProfileState();
}

class _DetailProfileState extends State<DetailProfile> {
  @override
  Widget build(BuildContext context) {
    // Gaya teks yang konsisten untuk detail informasi
    const textStyle = TextStyle(fontSize: 24, color: Colors.teal);

    // Gunakan widget.profile untuk Mengakses Data
    // Daftar informasi yang akan ditampilkan
    final textItems = [
      'Nama : ${widget.profile.name}',
      'NIM  : ${widget.profile.nim}',
      'Kelas  : ${widget.profile.kelas}',
      'SD : ${widget.profile.sd}',
      'SMP  : ${widget.profile.smp}',
      'SMK  : ${widget.profile.smk}',
      'Kampus : ${widget.profile.kampus}',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profil'), // Judul AppBar
        backgroundColor: Colors.teal, // Warna latar AppBar
        actions: [
          // 1️⃣ Membuat icon edit di sebelah kanan AppBar
          IconButton(
            icon: const Icon(Icons.edit), // Ikon pensil edit
            tooltip: 'Edit Profil', // Tooltip saat tombol ditekan lama
            onPressed: () async {
              // Navigasi ke halaman EditProfile, dan tunggu hasilnya

              // 2️⃣ mengirim Profile sebagai parameter ke EditProfile.
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfile(profile: widget.profile),
                ),
              );
              // 6️⃣ Setelah kembali dari EditProfile, refresh tampilan
              setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Scroll agar bisa diakses jika konten melebihi layar
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Posisi konten kiri
          children: [
            Stack(
              clipBehavior: Clip.none, // Izinkan overflow gambar profil
              alignment: Alignment.center, // Pusatkan konten dalam Stack
              children: [
                // Gambar latar belakang
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        widget.profile.background,
                      ), // Gambar background
                      fit: BoxFit.cover, // Gambar ditutupi ke seluruh area
                    ),
                  ),
                ),
                // Gambar profil yang diletakkan di bawah background
                Positioned(
                  bottom: -80,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(widget.profile.image),
                  ),
                ),
                // Ikon kamera di kanan bawah gambar profil (hiasan)
                Positioned(
                  left: 240,
                  bottom: -80,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      color: Colors.teal,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 100), // Jarak antara header dan detail
            ListView.builder(
              shrinkWrap:
                  true, // Gunakan ukuran minimum agar muat di dalam column
              physics:
                  const NeverScrollableScrollPhysics(), // Nonaktifkan scroll karena sudah dalam SingleChildScrollView
              padding: const EdgeInsets.all(8), // Padding luar
              itemCount: textItems.length, // Jumlah baris informasi
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                  ), // Jarak antar kartu
                  elevation: 4, // Bayangan kartu
                  child: Padding(
                    padding: const EdgeInsets.all(16), // Padding isi kartu
                    child: Text(
                      textItems[index],
                      style: textStyle,
                    ), // Tampilkan teks
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
