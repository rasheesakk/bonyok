import 'package:flutter/material.dart';
import '../data/contact_store.dart';

class ContactListView extends StatelessWidget {
  const ContactListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: ContactStore.instance.version,
      builder: (context, _, _) {
        final contacts = ContactStore.instance.contacts;

        if (contacts.isEmpty) {
          return const Center(
            child: Text('Belum ada kontak. Tekan tombol + untuk menambah.'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: contacts.length,
          separatorBuilder: (_, _) => const Divider(),
          itemBuilder: (context, index) {
            final contact = contacts[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text(
                  contact.name.isNotEmpty
                      ? contact.name[0].toUpperCase()
                      : '?',
                ),
              ),
              title: Text(contact.name),
              subtitle: Text('${contact.email}\n${contact.phone}'),
              isThreeLine: true,
            );
          },
        );
      },
    );
  }
}