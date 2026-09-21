// Buku Kenangan SMK IHYAUL ULUM
// Aplikasi untuk menyimpan kenangan sekolah

import 'package:flutter/material.dart';
import 'screens/home.dart';

void main() {
  runApp(const BukuKenanganApp());
}

class BukuKenanganApp extends StatelessWidget {
  const BukuKenanganApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Kenangan SMK IHYAUL ULUM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}