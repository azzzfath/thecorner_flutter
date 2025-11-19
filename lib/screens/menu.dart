import 'package:flutter/material.dart';
// Asumsikan ItemCard berada di widgets/product_card.dart (sudah ada di import)
import 'package:thecorner/widgets/product_card.dart'; 
// Asumsikan LeftDrawer berada di file terpisah dan perlu diimpor
import 'package:thecorner/widgets/left_drawer.dart'; // <--- Import LeftDrawer

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String nama = "Muhammad Azzam Fathurrahman"; //nama
  final String npm = "2406412152"; //npm
  final String kelas = "B";

  final List<ItemHomepage> items = [
    ItemHomepage("Create Product", Icons.my_library_add_outlined),
    ItemHomepage("My Product", Icons.inventory),
    ItemHomepage("See Football Products", Icons.visibility)
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // TODO 1: Menambahkan LeftDrawer ke Scaffold
      drawer: const LeftDrawer(), 

      appBar: AppBar(
        title: const Text(
          'Football shop',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,

        iconTheme: const IconThemeData(color: Colors.white), 
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 16.0),

            Center(
              child: Column(

                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Selamat datang di Football Shop',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),

                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,

                    shrinkWrap: true,

                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ItemHomepage {
  final String name;
  final IconData icon;

  ItemHomepage(this.name, this.icon);
}


class InfoCard extends StatelessWidget {

  final String title; 
  final String content;  

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(

      elevation: 2.0,
      child: Container(

        width: MediaQuery.of(context).size.width / 3.5, 
        padding: const EdgeInsets.all(16.0),

        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}