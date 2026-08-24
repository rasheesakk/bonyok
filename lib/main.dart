import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'Buku Kontak',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BukuKontakPage(),
    );
  }
}

// Model sederhana untuk menyimpan data kontak
class Kontak {
  final String nama;
  final String email;
  final String noHp;

  Kontak({required this.nama, required this.email, required this.noHp});
}

class BukuKontakPage extends StatefulWidget {
  const BukuKontakPage({super.key});

  @override
  State<BukuKontakPage> createState() => _BukuKontakPageState();
}

class _BukuKontakPageState extends State<BukuKontakPage> {
  // Controller Form
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();

  // List Penyimpanan Data Kontak
  final List<Kontak> _daftarKontak = [];

  void _tambahKontak() {
    if (_namaController.text.isNotEmpty) {
      setState(() {
        _daftarKontak.add(
          Kontak(
            nama: _namaController.text,
            email: _emailController.text,
            noHp: _noHpController.text,
          ),
        );
        _namaController.clear();
        _emailController.clear();
        _noHpController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Kontak'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // Section Form Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: _noHpController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'No Handphone'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _tambahKontak,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
          
          // Section List Kontak
          Expanded(
            child: ListView.builder(
              itemCount: _daftarKontak.length,
              itemBuilder: (context, index) {
                final kontak = _daftarKontak[index];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    kontak.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${kontak.email}\n${kontak.noHp}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}