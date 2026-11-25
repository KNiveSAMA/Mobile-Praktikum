import 'package:flutter/material.dart';
import 'package:tugas7/cart_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider( // agar mendapatkan notifikasi
    create: (context) => CartModel(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AnjayMart',
      debugShowCheckedModeBanner: false,
      home: ProdukPage(),  // panggil class halaman
    );
  }
}


//halaman produk

class ProdukPage extends StatelessWidget {
   ProdukPage({super.key});

  final products = [
    Product('IPHONE 13'),
    Product('IPHONE 14'),
    Product('IPHONE 15'),
    Product('IPHONE 16'),
    Product('IPHONE 17')

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'WELCOME TO EROG MART'
        ),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        actions: [ // button sebelah kiri agar bisa di tekan
          Padding(
            padding: EdgeInsetsGeometry.only(right: 20), // agar ada spasi hanya di kanan
            child: Consumer<CartModel>(
              builder: (context, cart, child) {
                return Badge( // ada icon yang berisi angka di action
                  label: Text('${cart.totalItems}'),
                  isLabelVisible: cart.totalItems > 0,                                         // syarat total item agar terlihat di keranjang

                  child: IconButton(
                    onPressed: (){
                      Navigator.push(                                                       // untuk berpindah halaman 
                        context, MaterialPageRoute(
                          builder: (context) => Cartpage(),
                        )
                      );
                    },
                    icon: Icon(Icons.shopping_cart)
                  ),
                );
              },
            ),
          )
        ],
      ),


      body: ListView.builder(
        itemCount: products.length,                                                        // agar tau jumlah produk yang ada
        itemBuilder: (context, index) {
          final product = products[index];                                                // buat variable yang menampung produk berdasarkan index
          return ListTile(                                                                // untuk menampilkan dengan ListView
            title: Text(product.nama),
            shape: BoxBorder.fromLTRB(bottom: BorderSide()),                              // garis bawah di setiap produk
            trailing: IconButton(
              onPressed: (){
                Provider.of<CartModel>(context ,listen: false).add(product);              // fungsi untuk menambahkan produk ke dalam keranjang
              }, 
              icon: Icon(Icons.shopping_bag)
            ),
          );
        },
      ),

    );
  }
}



// halaman keranjang

class Cartpage extends StatelessWidget {
  const Cartpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHECKOUT'),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),

      body: Consumer<CartModel>(                                                                       // gunakan costumer untuk menyesuaikan dengahn fungsi
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {                                                                    // jika keranjang kosong maka
            return Text('Belum ada apa apa nih');
          }

          return ListView.builder(                                                                    // jika keranjang ada isi nya
            itemCount: cart.items.length,                                                             // berapa jumlah item nya
            itemBuilder: (context, index) =>ListTile(                               
              title: Text(cart.items[index].nama),  
              shape: BoxBorder.fromLTRB(bottom: BorderSide()),
              trailing: IconButton(
                onPressed: (){
                  Provider.of<CartModel>(context ,listen: false).delete(cart.items[index]);
                }, 
                icon: Icon(Icons.delete) 
              ),                         
            )

          );
        },
      ),
    );
  }
}