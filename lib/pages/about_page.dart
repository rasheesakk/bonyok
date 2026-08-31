import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/foto_profil.jpg'),
            ),
          ),
          const SizedBox(height: 24),
          _buildInfoTile(Icons.badge, 'Nama Lengkap', 'Rasheesa Shareef'),
          _buildInfoTile(Icons.school, 'Kelas', 'XII RPL B'),
          _buildInfoTile(Icons.numbers, 'NIS / NISN', '123232'),
          _buildInfoTile(Icons.email, 'Email', 'rash@bakso.com'),
          _buildInfoTile(Icons.phone, 'No. Handphone', '08xxxxxxxxxx'),
          _buildInfoTile(Icons.location_on, 'Alamat', 'Adoh nggo helm'),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(value),
    );
  }
}