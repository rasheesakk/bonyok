import 'package:flutter/foundation.dart';
import '../models/contact.dart';

class ContactStore {
  ContactStore._internal();
  static final ContactStore instance = ContactStore._internal();

  final List<Contact> _contacts = [];

  // Berubah setiap kali data kontak berubah, dipakai untuk trigger rebuild UI.
  final ValueNotifier<int> version = ValueNotifier<int>(0);

  List<Contact> get contacts => List.unmodifiable(_contacts);

  List<Contact> get favorites =>
      _contacts.where((c) => c.isFavorite).toList();

  void addContact(Contact contact) {
    _contacts.add(contact);
    _notify();
  }

  void toggleFavorite(Contact contact) {
    contact.isFavorite = !contact.isFavorite;
    _notify();
  }

  void _notify() => version.value++;
}