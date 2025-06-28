import 'package:flutter/material.dart'; // Paket UI Material Design
import 'models/profile_data.dart'; // Import data profil dari model

// Kelas ChatPage menggunakan StatelessWidget karena tidak memiliki perubahan state
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar pesan chat, mengambil nama dari data profiles
    final List<Map<String, String>> chats = [
      {'name': profiles[4].name, 'message': 'Dit...tolongin dit'},
      {'name': profiles[1].name, 'message': 'Denis tutup mata kamu'},
      {'name': profiles[2].name, 'message': 'Yang sabar ya boss'},
      {'name': profiles[3].name, 'message': 'Weladalah kamu toh Yo'},
      {'name': profiles[0].name, 'message': 'Denis Deniss'},
    ];

    // Menggunakan ListView.builder untuk menampilkan daftar chat secara dinamis
    return ListView.builder(
      itemCount: chats.length, // Jumlah item berdasarkan banyaknya chat
      itemBuilder: (context, index) {
        final chat = chats[index]; // Ambil data chat per index

        // Cari data profil berdasarkan nama
        final profile = profiles.firstWhere(
          (p) => p.name == chat['name'], // Bandingkan nama
          orElse:
              () =>
                  profiles[0], // Jika tidak ditemukan, fallback ke profil pertama
        );

        // Widget card untuk menampilkan satu pesan chat
        return Card(
          margin: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ), // Margin antar card
          elevation: 4, // Bayangan pada card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Sudut membulat
          ),
          child: ListTile(
            // Avatar pengguna dari data profil
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://picsum.photos/200?random=${profile.id}', // Gambar profil dari URL
              ), // Gambar profil
            ),
            // Nama pengguna
            title: Text(
              chat['name']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            // Pesan singkat
            subtitle: Text(
              chat['message']!,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            ),
            // Icon panah di sebelah kanan
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.teal,
              size: 16,
            ),
            // Aksi ketika item chat ditekan
            onTap: () {
              // Menampilkan snackbar dengan nama pengguna
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Membuka chat dengan ${chat['name']}'),
                  backgroundColor: Colors.teal,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
