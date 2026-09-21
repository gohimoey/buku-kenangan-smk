// Buku Kenangan SMK IHYAUL ULUM v2.0
// Fitur: Kelas 10/11/12, Jurusan TKJ/TKR/PBS, Foto, Alamat, Nomor HP
// Fitur baru: Halaman Profil, Halaman Perjurusan

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'models/memory.dart';
import 'services/database_helper.dart';
import 'screens/profile_screen.dart';
import 'screens/majors_screen.dart';

void main() => runApp(const BukuKenanganApp());

class BukuKenanganApp extends StatelessWidget {
  const BukuKenanganApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Kenangan SMK IHYAUL ULUM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late Future<List<Memory>> memoriesFuture;
  final db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadMemories();
  }

  void _loadMemories() {
    setState(() {
      memoriesFuture = db.getAllMemories();
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Filter Memories'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Filter by:'),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(ctx, 'all'),
              icon: const Icon(Icons.list),
              label: const Text('Semua Kelas & Jurusan'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(ctx, '10'),
              icon: const Icon(Icons.school),
              label: const Text('Kelas 10'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(ctx, '11'),
              icon: const Icon(Icons.school),
              label: const Text('Kelas 11'),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(ctx, '12'),
              icon: const Icon(Icons.school),
              label: const Text('Kelas 12'),
            ),
          ],
        ),
      ),
    );
  }

  void _openAddMemory() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => const AddMemoryScreen()),
    ).then((_) => _loadMemories());
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomeTab() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Kenangan SMK IHYAUL ULUM'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt),
            onPressed: _showFilterDialog,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddMemory,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Memory>>(
        future: memoriesFuture,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final memories = snap.data ?? [];
          if (memories.isEmpty) {
            return const Center(child: Text('Belum ada kenangan. Tambahkan satu!'));
          }
          return ListView.builder(
            itemCount: memories.length,
            itemBuilder: (ctx, i) => Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                leading: memories[i].imagePath.isNotEmpty
                    ? Image.file(
                        File(memories[i].imagePath),
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : const Icon(Icons.photo, size: 50),
                title: Text(memories[i].title),
                subtitle: Text(
                  '${memories[i].classNumber} ${memories[i].major} • ${DateFormat("dd MMM yyyy").format(memories[i].date)}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  showDialog(
                    context: ctx,
                    builder: (_) => AlertDialog(
                      title: Text(memories[i].title),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (memories[i].imagePath.isNotEmpty)
                            Image.file(File(memories[i].imagePath)),
                          const SizedBox(height: 8),
                          Text(memories[i].description),
                          const Divider(),
                          Text('Kelas: ${memories[i].classNumber}'),
                          Text('Jurusan: ${memories[i].major}'),
                          Text('Alamat: ${memories[i].address}'),
                          Text('HP: ${memories[i].phoneNumber}'),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          const MajorsScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.photo_library),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Perjurusan',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class AddMemoryScreen extends StatefulWidget {
  const AddMemoryScreen({super.key});
  @override
  State<AddMemoryScreen> createState() => _AddMemoryScreenState();
}

class _AddMemoryScreenState extends State<AddMemoryScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '',
      _desc = '',
      _classNum = '11',
      _major = 'TKJ',
      _address = '',
      _phone = '',
      _imagePath = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() => _imagePath = img.path);
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final mem = Memory(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _title,
        description: _desc,
        imagePath: _imagePath,
        date: DateTime.now(),
        classNumber: _classNum,
        major: _major,
        address: _address,
        phoneNumber: _phone,
      );
      DatabaseHelper().insertMemory(mem);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Kenangan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Judul'),
              validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              onSaved: (v) => _title = v!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 3,
              onSaved: (v) => _desc = v!,
            ),
            DropdownButtonFormField<String>(
              value: _classNum,
              items: ['10', '11', '12'].map((c) => DropdownMenuItem(value: c, child: Text('Kelas $c'))).toList(),
              onChanged: (v) => setState(() => _classNum = v!),
              decoration: const InputDecoration(labelText: 'Kelas'),
            ),
            DropdownButtonFormField<String>(
              value: _major,
              items: ['TKJ', 'TKR', 'PBS'].map((m) => DropdownMenuItem(value: m, child: Text('Jurusan $m'))).toList(),
              onChanged: (v) => setState(() => _major = v!),
              decoration: const InputDecoration(labelText: 'Jurusan'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Alamat'),
              onSaved: (v) => _address = v ?? '',
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Nomor HP'),
              keyboardType: TextInputType.phone,
              onSaved: (v) => _phone = v ?? '',
            ),
            const SizedBox(height: 16),
            _imagePath.isEmpty
                ? const Text('Foto tidak dipilih')
                : Image.file(File(_imagePath), height: 150),
            TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_library),
              label: const Text('Pilih Foto'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Simpan Kenangan'),
            ),
          ]),
        ),
      ),
    );
  }
}