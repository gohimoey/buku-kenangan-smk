// Halaman tambah kenangan baru

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/memory.dart';
import '../services/database_helper.dart';

class AddMemoryScreen extends StatefulWidget {
  const AddMemoryScreen({super.key});

  @override
  State<AddMemoryScreen> createState() => _AddMemoryScreenState();
}

class _AddMemoryScreenState extends State<AddMemoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String? _imagePath;
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(ImageSource.gallery);
    if (picked != null) {
      setState(() => _imagePath = picked.path);
    }
  }

  Future<void> _saveMemory() async {
    if (!_formKey.currentState!.validate()) return;

    final memory = Memory(
      id: 0,
      title: _titleController.text,
      description: _descController.text,
      imagePath: _imagePath ?? '',
      date: _selectedDate,
      qrData: '${_titleController.text}|${_descController.text}',
    );

    await DatabaseHelper.instance.insertMemory(memory);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Kenangan')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Judul'),
              validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
            ),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Deskripsi'),
              maxLines: 3,
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Tanggal'),
              subtitle: Text('${_selectedDate.toLocal()}'.split(' ')[0]),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (picked != null) {
                  setState(() => _selectedDate = picked);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Pilih Foto'),
              subtitle: Text(_imagePath ?? 'Belum pilih foto'),
              onTap: _pickImage,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveMemory,
        backgroundColor: Colors.green,
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}