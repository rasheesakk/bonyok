import 'package:flutter/material.dart';
import '../models/contact.dart';

class ContactStore {
  static final ContactStore instance = ContactStore._();
  ContactStore._();

  final List<Contact> _contacts = [
    Contact(
      name: 'rapip',
      email: 'apip@gmail.com',
      phone: '078553',
      isFavorite: true, // Kontak ini hanya akan muncul di tab Favorit
    ),
  ];

  // Halaman Kontak: Mengambil kontak yang BUKAN favorit
  List<Contact> get contacts =>
      _contacts.where((contact) => !contact.isFavorite).toList();

  // Halaman Favorit: Mengambil kontak yang HANYA favorit
  List<Contact> get favorites =>
      _contacts.where((contact) => contact.isFavorite).toList();

  final ValueNotifier<int> version = ValueNotifier<int>(0);

  void notifyListeners() {
    version.value++;
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
    notifyListeners();
  }

  void toggleFavorite(Contact contact) {
    contact.isFavorite = !contact.isFavorite;
    notifyListeners();
  }

  // Memperbarui data kontak yang sudah ada.
  // Menggunakan referensi objek `contact` (bukan index list),
  // supaya kontak yang benar yang diperbarui walaupun sedang
  // berada di hasil pencarian.
  void updateContact(
    Contact contact, {
    required String name,
    required String email,
    required String phone,
    String? kategori,
  }) {
    contact.name = name;
    contact.email = email;
    contact.phone = phone;
    contact.kategori = kategori;
    notifyListeners();
  }

  // Menghapus kontak dari daftar berdasarkan referensi objeknya,
  // supaya kontak yang benar yang terhapus walaupun sedang
  // berada di hasil pencarian.
  void deleteContact(Contact contact) {
    _contacts.remove(contact);
    notifyListeners();
  }
}