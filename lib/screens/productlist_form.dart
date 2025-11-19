import 'dart:convert';
import 'package:flutter/material.dart';
// Sesuaikan imports ini dengan struktur project kamu
import 'package:thecorner/widgets/left_drawer.dart';
import 'package:thecorner/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Variabel Input
  String _name = "";
  int _price = 0;
  String _description = "";
  String _brand = "other"; // Default sesuai opsi di list
  String _category = "other"; // Default sesuai opsi di list
  String _thumbnail = "";
  int _stock = 0;
  bool _isFeatured = false;

  // === LIST KATEGORI (Sesuai Django CATEGORY_CHOICES) ===
  final List<String> _categories = [
    'jersey',
    'shoes',
    'ball',
    'accessories',
    'equipment',
    'goalkeeper',
    'other',
  ];

  // === LIST BRAND (Sesuai Django BRAND_CHOICES) ===
  final List<String> _brands = [
    'nike',
    'adidas',
    'puma',
    'under_armour',
    'reebok',
    'mils',
    'specs',
    'ortuseight',
    'other',
  ];

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Add New Product'),
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              // 1. Nama Produk
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Nama Produk",
                    labelText: "Nama Produk",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _name = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Nama produk tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // 2. Harga
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Harga",
                    labelText: "Harga",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    setState(() {
                      _price = int.tryParse(value!) ?? 0;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Harga tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Harga harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),

              // 3. Brand (Dropdown sesuai Django)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Brand",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _brand,
                  items: _brands.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value, // Nilai yang dikirim ke Django (huruf kecil)
                      // Tampilan di layar (Huruf besar & hilangkan underscore)
                      child: Text(value.replaceAll('_', ' ').toUpperCase()), 
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _brand = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Pilih Brand!";
                    }
                    return null;
                  },
                ),
              ),

              // 4. Kategori (Dropdown sesuai Django)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: "Kategori",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  value: _category,
                  items: _categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value, 
                      child: Text(value.replaceAll('_', ' ').toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Pilih Kategori!";
                    }
                    return null;
                  },
                ),
              ),

              // 5. Stock
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Stok",
                    labelText: "Stok",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (String? value) {
                    setState(() {
                      _stock = int.tryParse(value!) ?? 0;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Stok tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Stok harus berupa angka!";
                    }
                    return null;
                  },
                ),
              ),

              // 6. Deskripsi
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Deskripsi",
                    labelText: "Deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Deskripsi tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // 7. Thumbnail URL
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "URL Gambar (Opsional)",
                    labelText: "URL Thumbnail",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _thumbnail = value!;
                    });
                  },
                ),
              ),

              // 8. Is Featured
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Produk Unggulan"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() {
                      _isFeatured = value;
                    });
                  },
                  activeColor: Colors.indigo,
                ),
              ),

              // === TOMBOL SAVE ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        
                        // PILIH URL SESUAI ENV:
                        // Android Emulator:
                        // const String url = "http://10.0.2.2:8000/create-product-flutter/";
                        // Browser/Web:
                        const String url = "http://localhost:8000/create-product-flutter/";

                        try {
                          final response = await request.postJson(
                            url,
                            jsonEncode(<String, dynamic>{
                              "name": _name,
                              "price": _price,
                              "description": _description,
                              "brand": _brand, // Kirim value (ex: 'under_armour')
                              "category": _category, // Kirim value (ex: 'shoes')
                              "stock": _stock,
                              "thumbnail": _thumbnail,
                              "is_featured": _isFeatured,
                            }),
                          );

                          if (context.mounted) {
                            if (response['status'] == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Produk berhasil disimpan!")),
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => MyHomePage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Gagal: ${response['message']}")),
                              );
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Error koneksi: $e")),
                            );
                          }
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}