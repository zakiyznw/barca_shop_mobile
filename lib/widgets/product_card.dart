import 'package:flutter/material.dart';
import 'package:barca_shop/screens/productlist_form.dart'; // <- pastiin ini juga

class ProductItemCard extends StatelessWidget {
  final String name;
  final IconData icon;

  const ProductItemCard({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text("Kamu telah menekan tombol $name!")));

          if (name == "Tambah Produk") {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductFormPage()));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 30.0),
                const SizedBox(height: 3),
                Text(name, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
