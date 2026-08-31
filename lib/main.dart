import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_contact_page.dart';
import 'pages/about_page.dart';

void main() {
  runApp(const BukuKontakApp());
}

class BukuKontakApp extends StatelessWidget {
  const BukuKontakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Buku Kontak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/tambah': (context) => const AddContactPage(),
        '/tentang': (context) => const AboutPage(),
      },
    );
  }
}