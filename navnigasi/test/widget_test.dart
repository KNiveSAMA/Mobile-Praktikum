import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:navnigasi/food.dart';
import 'package:navnigasi/main.dart';

void main() {
  testWidgets('Daftar makanan tampil dan bisa membuka halaman detail',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Semua makanan tampil di halaman utama.
    expect(find.text('Menu Makanan'), findsWidgets);
    expect(find.text('Nasi Goreng'), findsOneWidget);
    expect(find.text('Nasi Bakar'), findsOneWidget);
    expect(find.text('Ayam Balado'), findsOneWidget);

    // Ketuk item pertama, lalu pindah ke halaman detail.
    await tester.tap(find.text('Nasi Goreng'));
    await tester.pumpAndSettle();

    expect(find.text('Deskripsi'), findsOneWidget);
    expect(find.textContaining('Pesan'), findsOneWidget);

    // Kembali ke halaman utama.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Deskripsi'), findsNothing);
  });

  test('formatRupiah memberi pemisah ribuan', () {
    expect(formatRupiah(18000), 'Rp 18.000');
    expect(formatRupiah(1250000), 'Rp 1.250.000');
    expect(formatRupiah(500), 'Rp 500');
  });
}
