import 'package:flutter/material.dart';
import 'package:barca_shop/models/product_entry.dart';
import 'package:barca_shop/widgets/left_drawer.dart';
import 'package:barca_shop/widgets/product_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:barca_shop/screens/product_detail.dart';
import 'package:barca_shop/screens/productlist_form.dart';

class ProductEntryListPage extends StatefulWidget {
  const ProductEntryListPage({super.key});

  @override
  State<ProductEntryListPage> createState() => _ProductEntryListPageState();
}

class _ProductEntryListPageState extends State<ProductEntryListPage> {
  late Future<List<ProductEntry>> futureProducts;
  CookieRequest? _request;

  Future<List<ProductEntry>> fetchProducts(CookieRequest request) async {
    // Pastikan port 8000 ada di URL
    final response = await request.get('http://10.0.2.2:8000/products/json/');

    // Debug: cetak response bila perlu
    // print("GET /products/json/ => $response");

    List<ProductEntry> productList = [];
    // Jika response adalah list of maps:
    if (response is List) {
      for (var d in response) {
        if (d != null) {
          productList.add(ProductEntry.fromJson(Map<String, dynamic>.from(d)));
        }
      }
    }
    return productList;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ambil CookieRequest dari Provider satu kali
    final req = context.watch<CookieRequest>();
    if (_request == null) {
      _request = req;
      futureProducts = fetchProducts(_request!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder<List<ProductEntry>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No products available yet.',
                style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
              ),
            );
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (_, index) {
              final product = products[index];
              return ProductEntryCard(
                product: product,
                onTap: () async {
                  // contoh: navigasi ke detail (tidak memicu refresh)
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Kalau kamu membuka form dari FAB (opsional), tangkap hasilnya
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProductFormPage()),
          );
          if (result == true && _request != null) {
            // refresh
            setState(() {
              futureProducts = fetchProducts(_request!);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
