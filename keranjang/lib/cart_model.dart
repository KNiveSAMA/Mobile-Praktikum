import 'package:flutter/material.dart';

class Product{
  final String nama;

  Product(this.nama);
}

class CartModel extends ChangeNotifier{
  final List<Product> _items = [];

  List<Product> get items => _items;
  int get totalItems => _items.length;

  void add(Product product){
    _items.add(product);
    notifyListeners();
  }

  void delete(Product product){
    _items.remove(product);
    notifyListeners();
  }
}