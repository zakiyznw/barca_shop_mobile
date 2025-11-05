‎1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
‎Jawab:
‎Widget tree (pohon widget) adalah struktur hierarki (bertingkat) yang menggambarkan bagaimana widget saling bersarang (nested) di dalam aplikasi Flutter.
‎
‎Contohnya seperti ini:
‎
‎MaterialApp(
‎  home: Scaffold(
‎    appBar: AppBar(title: Text("Contoh Widget Tree")),
‎    body: Center(
‎      child: Column(
‎        children: [
‎          Text("Halo"),
‎          ElevatedButton(onPressed: () {}, child: Text("Klik Saya")),
‎        ],
‎      ),
‎    ),
‎  ),
‎)
‎
‎
‎Sedangkan hubungan parent-child, bekerja dengan cara menentukan bagaimana tampilan dan perilaku dari widget bekerja bersama. Parent adalah widget yang menampung widget lain di dalamnya. Biasanya mengatur posisi, ukuran, dan tata letak anak-anaknya. Sedangkan Child adalah widget yang berada di dalam parent. Child mewarisi atau menyesuaikan aturan layout dari induknya.
‎
‎Contoh Sederhana
‎
‎Center(
‎  child: Text("Halo Dunia"),
‎)
‎
‎Center → Parent widget
‎
‎Text("Halo Dunia") → Child widget
‎
‎2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
‎Jawab:
‎1. MaterialApp
‎Widget utama untuk aplikasi berbasis Material Design. Widget ini menjadi root widget dari aplikasi, mengatur tema (theme), judul (title), dan halaman awal (home).
‎
‎2. ThemeData & ColorScheme
‎ThemeData menyimpan pengaturan tampilan global seperti warna, font, dan gaya elemen. ColorScheme mengatur skema warna utama dan sekunder.
‎
‎3. Scaffold
‎Menyediakan struktur standar: appBar, body, floatingActionButton, dsb.
‎
‎4. AppBar
‎AppBar menampilkan judul atau tombol navigasi.
‎
‎5. Text
‎Widget untuk menampilkan teks di layar.
‎Dalam kasus saya digunakan untuk menampilkan NPM, nama, kelas
‎
‎6. Padding
‎Digunakan untuk memberi ruang antar elemen, misalnya pada body dan teks sambutan.
‎
‎7. Column
‎Digunakan untuk menyusun widget anak secara vertikal. Di body untuk menyusun InfoCard dan bagian grid. Di ItemCard untuk menyusun ikon dan teks secara vertikal
‎
‎8. Row
‎Digunakan untuk menyusun widget anak secara horizontal. Dipakai untuk menampilkan tiga InfoCard berdampingan (NPM, Name, Class).
‎
‎12. Card
‎ Widget berbentuk kartu dengan elevation (bayangan). Digunakan di InfoCard untuk menampilkan informasi NPM, nama, dan kelas.
‎
‎13. Container
‎Widget serbaguna untuk mengatur ukuran, padding, margin, warna, dan alignment.
‎
‎14. MediaQuery
‎Digunakan untuk memberikan informasi tentang ukuran dan orientasi layar perangkat.
‎
‎15. Material
‎Digunakan untuk memberikan efek Material Design seperti bayangan dan ripple effect.
‎
‎16. InkWell
‎Widget interaktif yang mendeteksi sentuhan dan menampilkan efek ripple.
‎Digunakan untuk membuat ItemCard dapat ditekan, dan menampilkan SnackBar saat ditekan.
‎
‎17. SnackBar
‎Pesan notifikasi singkat yang muncul di bawah layar. Ditampilkan ketika pengguna menekan tombol (ItemCard), berisi pesan seperti:
‎> “Kamu telah menekan tombol All Products!”
‎
‎18. Icon
‎Digunakan untuk menampilkan ikon dari pustaka Material Icons.
‎
‎3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
‎Jawab:
‎MaterialApp adalah widget utama yang digunakan untuk membuat aplikasi Flutter yang mengikuti desain Material (standar UI buatan Google). Widget MaterialApp digunakan untuk menyediakan struktur dasar aplikasi Material Design, mengatur tema (Theme) aplikasi, mengatur navigasi antar halaman (Route / Navigator), menyediakan Localizations (format tanggal, bahasa, dsb.). MaterialApp sering dijadikan widget root karena MaterialApp menyediakan context global untuk semua widget di bawahnya. Tanpa MaterialApp, banyak widget tidak akan bisa bekerja dengan benar. 
‎
‎4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
‎Jawab:
‎StatelessWidget:
‎-Tidak menyimpan data yang berubah.
‎-UI tetap dari awal sampai akhir.
‎-Digunakan untuk tampilan statis.
‎
‎StatefulWidget
‎-Menyimpan data (state) yang dapat berubah saat aplikasi berjalan.
‎-UI dapat berubah dengan setState().
‎-Digunakan untuk tampilan dinamis.
‎
‎5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
‎Jawab:
‎BuildContext adalah objek yang menyimpan informasi tentang posisi sebuah widget dalam widget tree. Mengapa penting di Flutter? Ini karena BuildContext digunakan untuk mengakses data atau fitur yang disediakan oleh widget di atasnya. Penggunaan di metode build adalah kita menggunakan context untuk mengambil data atau melakukan aksi terkait UI.
‎
‎6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
‎Jawab:
‎Hot Reload:
‎- Memuat ulang perubahan kode tanpa mengulang ulang aplikasi.
‎- State tetap (nilai variabel, halaman yang sedang dibuka tidak hilang).
‎- Cepat, cocok saat mengubah UI atau layout.
‎
‎Hot Restart:
‎-Memulai ulang aplikasi dari awal.
‎-State hilang (semua variabel kembali ke kondisi awal).
‎-Digunakan jika perubahan terkait inisialisasi atau struktur aplikasi.
