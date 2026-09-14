import 'package:flutter/material.dart';
import '../data/contact_store.dart';
import '../models/contact.dart';
import '../pages/edit_contact_page.dart';

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({super.key});

  void _editContact(BuildContext context, Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditContactPage(contact: contact),
      ),
    );
  }

  Future<void> _deleteContact(BuildContext context, Contact contact) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Kontak'),
        content: Text('Yakin ingin menghapus kontak "${contact.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      ContactStore.instance.deleteContact(contact);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: ContactStore.instance.version,
      builder: (context, _, __) {
        final favorites = ContactStore.instance.favorites;

        if (favorites.isEmpty) {
          return const Center(child: Text('Belum ada kontak favorit.'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: favorites.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final contact = favorites[index];
            return ListTile(
              leading: const Icon(Icons.star, color: Colors.amber),
              title: Text(contact.name),
              subtitle: Text(
                '${contact.email}\n${contact.phone}\n'
                'Kategori: ${contact.kategori ?? 'Tanpa kategori'}',
              ),
              isThreeLine: true,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.teal),
                    tooltip: 'Edit',
                    onPressed: () => _editContact(context, contact),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Hapus',
                    onPressed: () => _deleteContact(context, contact),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
