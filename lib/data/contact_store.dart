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
}