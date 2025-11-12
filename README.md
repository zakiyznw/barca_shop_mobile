1. Jelaskan perbedaan antara Navigator.push() dan Navigator.pushReplacement() pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
   Navigator.push() berfungsi untuk menambahkan (mendorong) halaman baru ke atas stack navigasi, halaman sebelumnya tetap ada di bawahnya. Akibatnya stack bertambah 1 halaman baru. Sedangkan
   Navigator.pushReplacement() berfungsi mengganti halaman saat ini dengan halaman baru, halaman lama dihapus dari stack. Akibatnya stack tidak bertambah, tetapi halaman lama diganti. Navigator.push() digunakan
   saat kamu ingin bisa kembali ke halaman sebelumnya menggunakan tombol Back (misalnya setelah melihat detail produk, bisa kembali ke daftar produk). Sedangkan Navigator.pushReplacement() digunakan saat kamu
   tidak ingin pengguna kembali ke halaman sebelumnya (misalnya setelah login berhasil, berpindah ke halaman utama tanpa bisa kembali ke halaman login).

3. Bagaimana kamu memanfaatkan hierarchy widget seperti Scaffold, AppBar, dan Drawer untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
   Scaffold digunakan sebagai kerangka utama yang menyediakan struktur halaman (app bar, body, drawer, floating button, dsb). AppBar digunakan untuk menampilkan judul halaman dan ikon aksi (cart, search, dsb). Dan
   Drawer berguna sebagai navigasi antar-halaman seperti “All Products”, “My Products”, dan “About”.

4. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti Padding, SingleChildScrollView, dan ListView saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
   Padding -> Membuat tampilan lebih rapi dan tidak menempel pada tepi layar.
   SingleChildScrollView -> Mencegah overflow saat form panjang atau keyboard muncul.
   ListView -> Cocok untuk menampilkan daftar produk atau form panjang dengan banyak elemen.
   Contoh penggunaannya di aplikasi:
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Nama Produk')),
            SizedBox(height: 12),
            TextField(decoration: InputDecoration(labelText: 'Harga')),
            SizedBox(height: 12),
            ElevatedButton(onPressed: () {}, child: Text('Tambah Produk')),
          ],
        ),
      ),
    )
5. Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
   Untuk menjaga identitas visual brand, Flutter menyediakan sistem tema global melalui ThemeData. Berikut contoh penggunaannya:
    MaterialApp(
      title: 'Football Shop',
      theme: ThemeData(
        primaryColor: Colors.green[700], // Warna utama brand
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green[700],
          secondary: Colors.yellow[600],
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700],
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow[600],
            foregroundColor: Colors.black,
          ),
        ),
      ),
      home: MyHomePage(),
    );

