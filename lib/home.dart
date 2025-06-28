import 'package:flutter/material.dart'; // Paket Flutter Material untuk UI
import 'package:flutter_application_1/ChatPage.dart'; // Mengimpor halaman Chat
import 'screens/list_profile.dart'; // Mengimpor halaman List Profil
import 'models/profile_data.dart'; // Mengimpor data profil

// Kelas utama Home menggunakan StatefulWidget karena ada perubahan state (navigasi)
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// State dari kelas Home
class _HomeState extends State<Home> {
  int _selectedIndex = 0; // Menyimpan index tab yang sedang aktif

  // Contoh data postingan untuk halaman Beranda
  final List<Map<String, dynamic>> posts = [
    {
      'profileIndex': 0, // Mengambil data profil berdasarkan index
      'image': 'assets/images/nature.webp',
      'post': 'Hari ini cuaca nya sangat cerah, well',
    },
    {
      'profileIndex': 1,
      'image': 'assets/images/adit_bg.jpg',
      'post': 'Hari ini gua bantuin Denis',
    },
    {
      'profileIndex': 3,
      'image': 'assets/images/jarwo_bg.jpg',
      'post': 'Saya sedang belajar Flutter, dawhg',
    },
  ];

  // Fungsi saat item navigasi diklik
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Ubah tab aktif sesuai index yang diklik
    });
  }

  @override
  Widget build(BuildContext context) {
    // Daftar halaman berdasarkan index navigasi bawah
    final List<Widget> _pages = [
      // Halaman 0: Beranda dengan postingan
      ListView.builder(
        itemCount: posts.length, // Jumlah item sesuai banyaknya post
        itemBuilder: (context, index) {
          final post = posts[index]; // Ambil data post
          final profileIndex = post['profileIndex']; // Ambil index profil

          // Validasi apakah index profil valid
          if (profileIndex == null ||
              profileIndex is! int ||
              profileIndex < 0 ||
              profileIndex >= profiles.length) {
            return const ListTile(title: Text('Profil tidak ditemukan'));
          }

          final profile =
              profiles[profileIndex]; // Ambil data profil berdasarkan index

          return Card(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 16,
            ), // Jarak antar card
            elevation: 4, // Efek bayangan
            child: Padding(
              padding: const EdgeInsets.all(16), // Padding dalam card
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Rata kiri
                children: [
                  Row(
                    children: [
                      // Avatar dari data profil
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(profile.image),
                      ),
                      const SizedBox(width: 10), // Jarak antar elemen
                      // Nama pengguna
                      Text(
                        profile.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10), // Spasi setelah row
                  // Teks isi postingan
                  Text(
                    post['post'] ?? '', // Jika null maka string kosong
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10), // Spasi sebelum gambar
                  // Gambar postingan
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      8,
                    ), // Sudut gambar membulat
                    child: Image.asset(
                      post['image'] ?? '', // Jika null maka kosong
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Halaman 1: Chat
      const ChatPage(),

      // Halaman 2: List Profil
      ListProfile(),
    ];

    // Struktur utama UI
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        // Judul bergantung pada tab yang dipilih
        title: Text(
          _selectedIndex == 0
              ? 'Beranda'
              : _selectedIndex == 1
              ? 'Chat'
              : 'List Profil',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: _pages[_selectedIndex], // Menampilkan halaman berdasarkan index
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // Tab Beranda
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          // Tab Chat
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
          // Tab Profil
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Kontak'),
        ],
        currentIndex: _selectedIndex, // Tab yang sedang aktif
        selectedItemColor: Colors.teal, // Warna tab aktif
        onTap: _onItemTapped, // Fungsi saat tab diklik
      ),
    );
  }
}
