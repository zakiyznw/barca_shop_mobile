import 'package:flutter/material.dart';
import 'package:barca_shop/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:barca_shop/screens/menu.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _priceCtrl = TextEditingController();
  final TextEditingController _descCtrl = TextEditingController();
  final TextEditingController _thumbnailCtrl = TextEditingController();

  String _category = 'Jersey';
  bool _isFeatured = false;

  final List<String> _categories = [
    'Jersey',
    'Sepatu',
    'Aksesoris',
    'Merchandise',
  ];

  @override
  void dispose() {
    _nameCtrl.dispose();
    _priceCtrl.dispose();
    _descCtrl.dispose();
    _thumbnailCtrl.dispose();
    super.dispose();
  }

  bool _isValidUrl(String value) {
    if (value.isEmpty) return false;
    final uri = Uri.tryParse(value);
    if (uri == null) return false;
    return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final name = _nameCtrl.text.trim();
      final price = double.parse(_priceCtrl.text.trim());
      final desc = _descCtrl.text.trim();
      final thumb = _thumbnailCtrl.text.trim();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Produk berhasil disimpan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Nama: $name'),
                  Text('Harga: ${price.toStringAsFixed(2)}'),
                  Text('Deskripsi: $desc'),
                  Text('Kategori: $_category'),
                  Text('Thumbnail: ${thumb.isEmpty ? "Tidak diset" : thumb}'),
                  Text('Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                  _formKey.currentState!.reset();
                  _nameCtrl.clear();
                  _priceCtrl.clear();
                  _descCtrl.clear();
                  _thumbnailCtrl.clear();
                  setState(() {
                    _category = _categories[0];
                    _isFeatured = false;
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Nama produk tidak boleh kosong';
    final len = value.trim().length;
    if (len < 3) return 'Nama minimal 3 karakter';
    if (len > 50) return 'Nama maksimal 50 karakter';
    return null;
  }

  String? _validatePrice(String? value) {
    if (value == null || value.trim().isEmpty) return 'Harga tidak boleh kosong';
    final parsed = double.tryParse(value.trim());
    if (parsed == null) return 'Harga harus angka (contoh: 120000)';
    if (parsed <= 0) return 'Harga harus lebih besar dari 0';
    return null;
  }

  String? _validateDesc(String? value) {
    if (value == null || value.trim().isEmpty) return 'Deskripsi tidak boleh kosong';
    if (value.trim().length < 10) return 'Deskripsi minimal 10 karakter';
    return null;
  }

  String? _validateThumbnail(String? value) {
    if (value == null || value.trim().isEmpty) return null; // optional
    if (!_isValidUrl(value.trim())) return 'Format URL tidak valid (http/https)';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Tambah Produk'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(
                    hintText: 'Nama produk',
                    labelText: 'Nama',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                  ),
                  validator: _validateName,
                ),
              ),

              // Price
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _priceCtrl,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    hintText: 'Harga (contoh: 120000)',
                    labelText: 'Harga',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                  ),
                  validator: _validatePrice,
                ),
              ),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _descCtrl,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Deskripsi produk',
                    labelText: 'Deskripsi',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                  ),
                  validator: _validateDesc,
                ),
              ),

              // Category
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Kategori',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                  ),
                  value: _category,
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _category = val ?? _categories[0];
                    });
                  },
                ),
              ),

              // Thumbnail
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _thumbnailCtrl,
                  decoration: InputDecoration(
                    hintText: 'URL thumbnail (http/https) - opsional',
                    labelText: 'Thumbnail URL',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.0)),
                  ),
                  validator: _validateThumbnail,
                ),
              ),

              // Is Featured
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SwitchListTile(
                  title: const Text('Tandai sebagai Produk Unggulan'),
                  value: _isFeatured,
                  onChanged: (val) => setState(() => _isFeatured = val),
                ),
              ),

              // Save button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final name = _nameCtrl.text.trim();
                      final price = int.tryParse(_priceCtrl.text.trim()) ?? 0;
                      final description = _descCtrl.text.trim();

                      // Sesuaikan URL dengan endpoint Django-mu
                      final url = "http://10.0.2.2:8000/create-flutter/";

                      // Kirim Map agar library menangani header JSON
                      final payload = {
                        "name": name,
                        "price": price,         // PENTING: gunakan "price"
                        "stock": 1,
                        "description": description,
                        "category": _category,
                        "thumbnail": _thumbnailCtrl.text.trim(),
                        "is_featured": _isFeatured,
                      };

                      // Jika postJson menerima Map, berikan payload langsung
                      final response = await request.postJson(url, payload);

                      // debug (jika ingin lihat raw response)
                      // print("POST response: $response");

                      if (!context.mounted) return;

                      // Periksa format response dari backend. Saya pakai pattern 'status' == 'success'
                      if (response != null && response['status'] == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Product successfully saved!")),
                        );
                        Navigator.pop(context, true); // <-- kembalikan true untuk trigger refresh
                      } else if (response != null && response['status'] == 'unauthorized') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("You must login first.")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Something went wrong. Response: $response")),
                        );
                      }
                    }
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
