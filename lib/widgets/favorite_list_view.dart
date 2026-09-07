import 'package:flutter/material.dart';
import '../data/contact_store.dart';

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({super.key});

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
            );
          },
        );
      },
    );
  }
}