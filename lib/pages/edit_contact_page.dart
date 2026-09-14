import 'package:flutter/material.dart';
import '../data/contact_store.dart';
import '../models/contact.dart';

class EditContactPage extends StatefulWidget {
  const EditContactPage({super.key, required this.contact});

  // Kontak yang sedang diedit (referensi objek asli, bukan salinan).
  final Contact contact;

  @override
  State<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _kategoriController;

  @override
  void initState() {
    super.initState();
    // Form Edit menampilkan data kontak yang sebelumnya sudah tersimpan.
    _nameController = TextEditingController(text: widget.contact.name);
    _emailController = TextEditingController(text: widget.contact.email);
    _phoneController = TextEditingController(text: widget.contact.phone);
    _kategoriController =
        TextEditingController(text: widget.contact.kategori ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _kategoriController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final kategoriText = _kategoriController.text.trim();
      ContactStore.instance.updateContact(
        widget.contact,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        kategori: kategoriText.isEmpty ? null : kategoriText,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Kontak')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? 'Nama wajib diisi'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email wajib diisi';
                  }
                  if (!value.contains('@')) {
                    return 'Format email tidak valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'No. Handphone',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.isEmpty) {
                    return 'Nomor HP wajib diisi';
                  }
                  if (!RegExp(r'^[0-9]+$').hasMatch(text)) {
                    return 'Nomor HP hanya boleh berisi angka';
                  }
                  if (text.length < 10) {
                    return 'Nomor HP minimal 10 digit';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _kategoriController,
                decoration: const InputDecoration(
                  labelText: 'Kategori (opsional)',
                  hintText: 'Keluarga / Teman / Kerja',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveChanges,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('Simpan Perubahan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
