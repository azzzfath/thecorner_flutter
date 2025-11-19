import 'package:flutter/material.dart';

import 'package:football_shop/screens/menu.dart';
import 'package:football_shop/screens/productlist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  'Football Shop',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("Seluruh berita sepak bola terkini di sini!",
                    // TODO: Tambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                    ),
              ],
            ),
          ),
          ListTile(
  leading: const Icon(Icons.home_outlined),
  title: const Text('Home'),
  // Bagian redirection ke MyHomePage
  onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  },
),
ListTile(
  leading: const Icon(Icons.post_add),
  title: const Text('Add News'),
  // Bagian redirection ke NewsFormPage
  onTap: () {
    /*
    TODO: Buatlah routing ke NewsFormPage di sini,
    setelah halaman NewsFormPage sudah dibuat.
    */

        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProductFormPage(),
        ));
  },
),
        ],
      ),
    );
  }
}