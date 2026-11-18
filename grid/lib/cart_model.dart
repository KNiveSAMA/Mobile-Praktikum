import 'package:flutter/foundation.dart';

class Product {
  final String name;
  final String description;
  final int price;

  const Product(this.name, {required this.description, required this.price});
}

/// Data produk dipindah ke luar widget supaya tidak dibuat ulang di setiap build.
const List<Product> kProducts = [
  Product(
    'Laptop',
    description: 'Laptop ringan dengan baterai tahan seharian, cocok untuk kerja dan kuliah.',
    price: 12500000,
  ),
  Product(
    'Mouse',
    description: 'Mouse nirkabel ergonomis dengan sensor presisi tinggi.',
    price: 250000,
  ),
  Product(
    'Keyboard',
    description: 'Keyboard mekanik dengan switch tactile dan lampu latar.',
    price: 750000,
  ),
];

String formatRupiah(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  return 'Rp $buffer';
}

class CartModel extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;
  int get totalItems => _items.length;

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }
}