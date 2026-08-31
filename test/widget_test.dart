// Basic smoke test untuk aplikasi Buku Kontak.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bonyok/main.dart';

void main() {
  testWidgets('Halaman Beranda menampilkan judul dan tab', (tester) async {
    await tester.pumpWidget(const BukuKontakApp());

    // Judul AppBar muncul
    expect(find.text('Buku Kontak'), findsOneWidget);

    // Kedua tab muncul
    expect(find.text('Kontak'), findsOneWidget);
    expect(find.text('Favorit'), findsOneWidget);

    // FloatingActionButton ada
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}