// Halaman Profil SMK Ihyaul Ulum
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil SMK')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Logo/Icon Sekolah
            const CircleAvatar(
              radius: 60,
              child: Icon(Icons.school, size: 60),
            ),
            const SizedBox(height: 20),
            
            // Nama Sekolah
            const Text(
              'SMK Ihyaul Ulum',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            
            // Tagline
            const Text(
              'Membangun Karir dari Sejak Awal',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            
            // Info Sekolah
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(context, Icons.location_on, 'Alamat', 'Jl. Profesor Ki Usroomodjo No. 10, Cikanggera Utara, Cikanggera, Bekasi 13230'),
                    _buildInfoRow(context, Icons.phone, 'Telepon', '+62 21 4749 8899'),
                    _buildInfoRow(context, Icons.email, 'Email', 'info@ihyaululum.sch.id'),
                    _buildInfoRow(context, Icons.web, 'Website', 'www.ihyaululum.sch.id'),
                    _buildInfoRow(context, Icons.calendar_today, 'Tahun Ajaran', '2024/2025'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Visi & Misi
            Card(
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Visi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('Membangun lulusan yang profesional, inovatif, dan mandiri dalam bidang teknologi informasi dan komunikasi'),
                    const SizedBox(height: 16),
                    const Text('Misi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('• Menyelenggarakan pembelajaran yang relevan dengan dunia usaha\n• Mengembangkan sumber daya manususia yang unggul\n• Membangun kemitraan dengan dunia industri\n• Menumbuhkan citra diri yang baik dalam diri lulusan'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Jurusan
            const Text(
              'Jurusan yang Disediakan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                _buildMajorChip('TKJ', Colors.red, 'Teknik Komputer Jaringan'),
                _buildMajorChip('TKR', Colors.blue, 'Teknik Revai'),
                _buildMajorChip('PBS', Colors.green, 'Pengembangan Perangkat Lunak Bersertifikat'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext ctx, IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.grey.shade700),
          const SizedBox(width: 10),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: Theme.of(ctx).textTheme.bodyMedium,
                children: [
                  TextSpan(text: '$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMajorChip(String kode, Color color, String nama) {
    return Chip(
      label: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(kode, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(nama, style: const TextStyle(fontSize: 10)),
        ],
      ),
      backgroundColor: color.withOpacity(0.2),
      side: BorderSide(color: color),
    );
  }
}