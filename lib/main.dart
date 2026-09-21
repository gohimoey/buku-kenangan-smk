// Buku Kenangan SMK IHYAUL ULUM
import 'package:flutter/material.dart';

void main() => runApp(const BukuKenanganApp());

class BukuKenanganApp extends StatelessWidget {
  const BukuKenanganApp({super.key});
  
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Buku Kenangan IHYAUL ULUM',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const HomeScreen(),
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> memories = [];
  
  void _addMemory(String title, String desc) {
    setState(() {
      memories.add({'title': title, 'desc': desc, 'date': DateTime.now()});
    });
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Buku Kenangan')),
    body: memories.isEmpty 
      ? const Center(child: Text('Tap + untuk tambah kenangan'))
      : ListView.builder(
          itemCount: memories.length,
          itemBuilder: (_, i) => ListTile(
            title: Text(memories[i]['title']),
            subtitle: Text(memories[i]['desc']),
            trailing: Text(memories[i]['date'].toString().split(' ')[0]),
          ),
        ),
    floatingActionButton: FloatingActionButton(
      onPressed: () => showDialog(context: context, builder: (_) => _AddDialog(onAdd: _addMemory)),
      child: const Icon(Icons.add),
    ),
  );
}

class _AddDialog extends StatefulWidget {
  final void Function(String, String) onAdd;
  const _AddDialog({required this.onAdd});
  
  @override
  State<_AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<_AddDialog> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  
  @override
  Widget build(BuildContext context) => AlertDialog(
    title: const Text('Tambah Kenangan'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'Judul')),
        TextField(controller: _descCtrl, decoration: const InputDecoration(labelText: 'Deskripsi'), maxLines: 3),
      ],
    ),
    actions: [
      TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
      TextButton(onPressed: () {
        widget.onAdd(_titleCtrl.text, _descCtrl.text);
        Navigator.pop(context);
      }, child: const Text('Simpan')),
    ],
  );
}