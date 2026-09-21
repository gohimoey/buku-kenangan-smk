// Halaman Perjurusan TKJ/TKR/PBS
import 'package:flutter/material.dart';

class MajorsScreen extends StatelessWidget {
  const MajorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perjurusan')),
      body: ListView(
        children: [
          _buildMajorCard(
            'TKJ',
            'Teknik Komputer Jaringan',
            Icons.computer,
            Colors.blue,
            'Jurusan yang fokus pada desain, instalasi, dan manajemen jaringan komputer serta layanan TI.',
            [
              'Instalasi dan konfigurasi jaringan LAN/MAN/WAN',
              'Adminisitrasi server dan database',
              'Keamanan jaringan dan firewall',
              'Troubleshooting hardware dan software',
              'Cloud computing dan virtualisasi',
              'Sistem operasi Windows dan Linux',
            ],
          ),
          _buildMajorCard(
            'TKR',
            'Teknik Revai',
            Icons.build,
            Colors.red,
            'Jurusan yang mengusahakan kemampuan merancang, memproduksi, dan memelihara produk dengan menggunakan teknologi.',
            [
              'Desain dan pengembangan produk',
              'Manufaktur dan produksi',
              'Kualitas dan standar produk',
              'Teknik pemeliharaan',
              'Pembelajaran mesin dan peralatan',
              'Automatisasi industri',
            ],
          ),
          _buildMajorCard(
            'PBS',
            'Pengembangan Perangkat Lunak Bersertifikat',
            Icons.code,
            Colors.green,
            'Jurusan yang menekankan pengembangan aplikasi berbasis mobile, web, dan desktop.',
            [
              'Pengembangan aplikasi mobile (Android/iOS)',
              'Pengembangan web frontend & backend',
              'Database design dan implementasi',
              'UI/UX design',
              'Testing dan debugging',
              'DevOps dan CI/CD',
              'Manajemen proyek IT',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMajorCard(
    String kode,
    String nama,
    IconData icon,
    Color color,
    String deskripsi,
    List<String> keywords,
  ) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          '$kode - $nama',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(deskripsi, style: const TextStyle(color: Colors.black87)),
                const SizedBox(height: 12),
                const Text('Skill yang Dipelajari:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: keywords.map((k) => Chip(
                    label: Text(k, style: const TextStyle(fontSize: 12)),
                    visualDensity: VisualDensity.compact,
                  )).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}