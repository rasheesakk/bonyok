import 'package:flutter/material.dart';
import '../widgets/contact_list_view.dart';
import '../widgets/favorite_list_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _goToTab(int index) {
    Navigator.pop(context);
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Kontak'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.contacts), text: 'Kontak'),
            Tab(icon: Icon(Icons.star), text: 'Favorit'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Buku Kontak',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.contacts),
              title: const Text('Kontak'),
              onTap: () => _goToTab(0),
            ),
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Tambah Kontak'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tambah');
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Favorit'),
              onTap: () => _goToTab(1),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Tentang'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/tentang');
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          ContactListView(),
          FavoriteListView(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Tambah Kontak',
        onPressed: () => Navigator.pushNamed(context, '/tambah'),
        child: const Icon(Icons.add),
      ),
    );
  }
}