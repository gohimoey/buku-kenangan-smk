// Halaman detail kenangan + QR code

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/memory.dart';

class MemoryDetailScreen extends StatelessWidget {
  final Memory memory;

  const MemoryDetailScreen({super.key, required this.memory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(memory.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(memory.description, style: const TextStyle(fontSize: 16)),
            Text('Tanggal: ${memory.date.day}/${memory.date.month}/${memory.date.year}'),
            const SizedBox(height: 16),
            // QR Code
            QrImageView(
              data: memory.qrData,
              size: 160,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 8),
            const Text('Scan QR untuk melihat detail', style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}