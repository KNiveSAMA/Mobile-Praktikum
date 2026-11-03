import 'package:flutter/material.dart';

class Food {
  final String image;
  final String name;
  final int price;
  final String description;

  const Food({
    required this.image,
    required this.name,
    required this.price,
    required this.description,
  });

  String get heroTag => 'food-$name';
}

const List<Food> foodList = [
  Food(
    image: 'assets/images/nasi_goreng.jpg',
    name: 'Nasi Goreng',
    price: 18000,
    description:
        'Nasi goreng khas dengan bumbu rempah yang meresap, disajikan bersama '
        'telur mata sapi, irisan mentimun, tomat, dan kerupuk renyah.',
  ),
  Food(
    image: "assets/images/nasi_bakar.jpg",
    name: 'Nasi Bakar',
    price: 22000,
    description:
        'Nasi gurih berisi suwiran ayam kemangi yang dibungkus daun pisang '
        'lalu dibakar, menghasilkan aroma harum yang menggugah selera.',
  ),
  Food(
    image: 'assets/images/ayam_balado.jpeg',
    name: 'Ayam Balado',
    price: 25000,
    description:
        'Ayam goreng empuk yang disiram sambal balado merah pedas manis, '
        'cocok disantap dengan nasi putih hangat.',
  ),
  Food(
    image: 'assets/images/burger.jpg',
    name: 'Burger',
    price: 30000,
    description:
        'Roti burger lembut dengan patty daging sapi juicy, keju leleh, '
        'selada segar, tomat, dan saus spesial.',
  ),
];

String formatRupiah(int value) {
  final s = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
    buffer.write(s[i]);
  }
  return 'Rp $buffer';
}

class FoodImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final int? cacheWidth;

  const FoodImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.cacheWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.cover,
      cacheWidth: cacheWidth,
      errorBuilder: (context, error, stackTrace) => Container(
        width: width,
        height: height,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child: Icon(
          Icons.restaurant_menu_rounded,
          size: 36,
          color: Theme.of(context).colorScheme.outline,
        ),
      ),
    );
  }
}
