import 'dart:async';

import 'package:flutter/material.dart';
import '../data/contact_store.dart';
import '../models/contact.dart';

class ContactListView extends StatefulWidget {
  const ContactListView({super.key});

  @override
  State<ContactListView> createState() => _ContactListViewState();
}

class _ContactListViewState extends State<ContactListView> {
  final StreamController<String> _searchController =
      StreamController<String>.broadcast();
  final TextEditingController _searchFieldController = TextEditingController();

  @override
  void dispose() {
    _searchController.close();
    _searchFieldController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String teks) {
    _searchController.add(teks);
  }

  List<Contact> _filterContacts(List<Contact> contacts, String keyword) {
    final query = keyword.trim().toLowerCase();
    if (query.isEmpty) return contacts;

    return contacts.where((contact) {
      final nameMatch = contact.name.toLowerCase().contains(query);
      final kategoriMatch =
          (contact.kategori ?? '').toLowerCase().contains(query);
      return nameMatch || kategoriMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: TextField(
            controller: _searchFieldController,
            onChanged: _onSearchChanged,
            decoration: const InputDecoration(
              hintText: 'Cari nama atau kategori...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
        ),
        Expanded(
          child: ValueListenableBuilder<int>(
            valueListenable: ContactStore.instance.version,
            builder: (context, _, __) {
              final contacts = ContactStore.instance.contacts;

              return StreamBuilder<String>(
                stream: _searchController.stream,
                initialData: '',
                builder: (context, snapshot) {
                  final keyword = snapshot.data ?? '';
                  final filtered = _filterContacts(contacts, keyword);

                  if (contacts.isEmpty) {
                    return const Center(
                      child: Text('Belum ada kontak. Tekan tombol + untuk menambah.'),
                    );
                  }

                  if (filtered.isEmpty) {
                    return const Center(child: Text('Kontak tidak ditemukan.'));
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final contact = filtered[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            contact.name.isNotEmpty
                                ? contact.name[0].toUpperCase()
                                : '?',
                          ),
                        ),
                        title: Text(contact.name),
                        subtitle: Text(
                          '${contact.email}\n${contact.phone}\n'
                          'Kategori: ${contact.kategori ?? 'Tanpa kategori'}',
                        ),
                        isThreeLine: true,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}