import 'package:flutter/material.dart';
import 'home.dart';
// import 'screens/list_profile.dart'; // Jika ingin menampilkan ListProfile

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Application',
      theme: ThemeData(primarySwatch: Colors.teal),
      home:
          const Home(), // Ganti ke ListProfile() jika ingin menampilkan daftar profil
      // home: ListProfile(),
    );
  }
}
