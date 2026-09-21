// Halaman utama - daftar kenangan

import 'package:flutter/material.dart';
import '../models/memory.dart';
import '../services/database_helper.dart';
import 'add_memory.dart';
import 'memory_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Memory>> futureMemories;

  @override
  void initState() {
    super.initState();
    loadMemories();
  }

  void loadMemories() {
    futureMemories = DatabaseHelper.instance.getAllMemories();
  }

  void _navigateToAdd(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddMemoryScreen()),
    );
    setState(() {
      loadMemories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Kenangan SMK IHYAUL ULUM'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Memory>>(
        future: futureMemories,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final memories = snapshot.data ?? [];
          if (memories.isEmpty) {
            return const Center(
              child: Text('Belum ada kenangan. Tekan + untuk menambah!'),
            );
          }
          return ListView.builder(
            itemCount: memories.length,
            itemBuilder: (context, i) {
              final m = memories[i];
              return ListTile(
                title: Text(m.title),
                subtitle: Text(m.description),
                trailing: Text(
                  '${m.date.day}/${m.date.month}/${m.date.year}',
                  style: const TextStyle(fontSize: 12),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemoryDetailScreen(memory: m),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAdd(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}