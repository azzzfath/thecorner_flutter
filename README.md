## Identitas
- **Nama**: Muhammad Azzam Fathurrahman  
- **NPM**: 2406412152  
- **Kelas**: B

-----------------------------

# Tugas 7 

## Jawaban Pertanyaan

1.  **Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.**
    * **Widget Tree** adalah struktur hierarki fundamental di Flutter yang menggambarkan bagaimana semua widget dalam aplikasi tersusun. Anggap saja seperti pohon silsilah, di mana UI aplikasi Anda dibangun dengan menyusun widget di dalam widget lain.
    * **Hubungan Parent-Child** adalah inti dari widget tree. Setiap widget (kecuali widget *root* paling atas) adalah **anak (child)** dari widget lain, yang disebut **induk (parent)**. Hubungan ini bekerja sebagai berikut:
        * **Komposisi**: UI dibangun melalui komposisi. `Parent` "memiliki" `child`-nya (misal, `Column` memiliki beberapa `Text` sebagai `children`).
        * **Kontrol & Batasan**: `Parent` bertanggung jawab untuk memberi tahu `child`-nya di mana ia harus diposisikan dan seberapa besar ukurannya (disebut *constraints*). `Child` kemudian me-render dirinya di dalam batasan yang diberikan oleh `parent`.
        * **Pewarisan Konteks**: `Parent` dapat meneruskan data (seperti tema, `ThemeData`) atau fungsionalitas (seperti `Navigator`) ke bawah *tree* kepada semua `child`-nya melalui `BuildContext`.

    

2.  **Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.**
    * **`MaterialApp`**: Widget *root* yang membungkus seluruh aplikasi dan menyediakan fungsionalitas dasar Material Design, seperti navigasi (routing) dan tema (theme).
    * **`Scaffold`**: Menyediakan struktur visual dasar untuk halaman, termasuk `AppBar` (bilah atas), `body` (konten utama), dan `BottomNavigationBar`.
    * **`AppBar`**: Widget yang ditampilkan di bagian atas `Scaffold`, biasanya berisi judul halaman dan tombol aksi.
    * **`Center`**: Widget layout yang menempatkan *child*-nya di tengah area yang tersedia.
    * **`Column`**: Widget layout yang menyusun *children*-nya secara vertikal (dari atas ke bawah).
    * **`Text`**: Widget untuk menampilkan string teks dengan gaya tertentu.
    * **`Container`**: Widget serbaguna yang dapat digunakan untuk *styling* (memberi warna, padding, margin, border) atau untuk mengatur batasan ukuran.
    * **`Padding`**: Memberikan ruang (bantalan) di sekitar *child*-nya.
    * **`Row`**: Widget layout yang menyusun *children*-nya secara horizontal (dari kiri ke kanan).
    * **`ElevatedButton`**: Tombol standar Material Design dengan latar belakang terangkat.
    * *...(Silakan tambahkan widget lain yang Anda gunakan di sini)...*

3.  **Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini sering digunakan sebagai widget root.**
    * **Fungsi `MaterialApp`**: `MaterialApp` adalah widget *convenience* (pembantu) yang membungkus sejumlah fungsionalitas inti yang dibutuhkan oleh sebagian besar aplikasi Material Design. Fungsi utamanya adalah menyediakan konfigurasi *top-level* untuk:
        * **Navigasi (Routing)**: Mengelola tumpukan halaman (`Navigator`) sehingga Anda bisa berpindah antar layar.
        * **Tema (Theming)**: Menyediakan `ThemeData` global yang akan digunakan oleh semua widget di bawahnya (mengatur warna, font, dll).
        * **Lokalisasi**: Mengatur bahasa dan format regional.
        * **Builder**: Menyiapkan layanan penting lainnya.
    * **Mengapa jadi Root**: Ia hampir selalu digunakan sebagai widget *root* (paling atas) karena widget-widget Material Design lainnya (seperti `Scaffold`, `Navigator`, `AppBar`, `TextButton`, dll.) **bergantung pada `BuildContext`** yang disediakan oleh `MaterialApp` untuk bisa berfungsi dengan benar. Tanpa `MaterialApp` di atasnya, Anda tidak bisa menggunakan `Navigator.push` atau `Theme.of(context)` secara efektif.

4.  **Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`. Kapan kamu memilih salah satunya?**
    * **`StatelessWidget`**:
        * **Deskripsi**: Widget yang **statis** (immutable). Tampilannya murni ditentukan oleh data (properti) yang diterima dari *parent*-nya saat ia dibuat.
        * **Karakteristik**: Tidak memiliki *state* internal. Setelah dibuat, ia tidak bisa diubah. Jika datanya perlu berubah, *parent*-nya harus membangun ulang `StatelessWidget` tersebut dengan data baru.
        * **Kapan Dipakai**: Gunakan untuk tampilan yang tidak pernah berubah berdasarkan interaksi pengguna atau data internal. **Contoh**: `Icon`, `Text` statis, `Container` dekoratif.

    * **`StatefulWidget`**:
        * **Deskripsi**: Widget yang **dinamis** (mutable). Ia memiliki objek `State` internal yang bisa menyimpan data dan berubah seumur hidup widget tersebut.
        * **Karakteristik**: Ketika data di dalam `State` berubah (biasanya dengan memanggil fungsi `setState()`), Flutter akan secara otomatis **membangun ulang (rebuild)** widget tersebut dengan tampilan baru untuk merefleksikan *state* yang baru.
        * **Kapan Dipakai**: Gunakan untuk apapun yang perlu berubah saat aplikasi berjalan. **Contoh**: *Checkbox*, *Slider*, *Form input*, halaman yang mengambil data dari internet, atau animasi.

    **Singkatnya**: Pilih `StatelessWidget` jika tampilan **hanya bergantung pada input** dari *parent*. Pilih `StatefulWidget` jika tampilan bisa **berubah dari dalam** widget itu sendiri.

5.  **Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di metode `build`?**
    * **Apa itu `BuildContext`**: `BuildContext` adalah "pegangan" (handle) yang menunjukkan **lokasi sebuah widget di dalam widget tree**. Ia BUKAN widget itu sendiri, melainkan informasi tentang "di mana" widget itu berada.
    * **Mengapa Penting**: `BuildContext` sangat penting karena digunakan oleh widget untuk **menemukan dan berinteraksi dengan widget leluhurnya (ancestors)**. Ini adalah mekanisme utama untuk mengambil data yang disediakan oleh *parent* di level yang lebih tinggi.
    * **Penggunaan di `build`**: Setiap metode `build` menerima `BuildContext context` sebagai argumen. `Context` inilah yang Anda gunakan untuk mengakses layanan atau data dari *ancestor* terdekat.
        * Contoh:
            * `Theme.of(context)`: Mencari `Theme` *ancestor* terdekat dan mengambil datanya.
            * `Navigator.of(context)`: Mencari `Navigator` *ancestor* terdekat untuk melakukan *routing* (pindah halaman).
            * `ScaffoldMessenger.of(context)`: Mencari `ScaffoldMessenger` untuk menampilkan `SnackBar`.

6.  **Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".**
    * **Hot Reload**:
        * **Konsep**: Proses menyuntikkan file kode yang baru diubah ke dalam **Dart Virtual Machine (VM) yang sedang berjalan**.
        * **Hasil**: Perubahan UI akan langsung terlihat dalam hitungan detik.
        * **State**: **State aplikasi tetap terjaga**. Misalnya, jika Anda sedang mengisi *form* dan melakukan *hot reload* untuk mengubah warna tombol, teks yang sudah Anda ketik di *form* tidak akan hilang.
        * **Kapan**: Ideal untuk *tuning* UI, memperbaiki *bug* visual, dan mengubah *logic* di dalam metode `build`.

    * **Hot Restart**:
        * **Konsep**: Membuang Dart VM yang ada dan membuat yang baru, lalu me-restart aplikasi dari awal.
        * **Hasil**: Membutuhkan waktu lebih lama daripada *hot reload* (tapi lebih cepat dari "Cold Restart"/menutup paksa aplikasi).
        * **State**: **State aplikasi hancur dan di-reset**. Aplikasi akan kembali ke kondisi awal (menjalankan ulang `main()` dan `initState()`).
        * **Kapan**: Digunakan ketika perubahan kode terlalu besar untuk *hot reload*, seperti mengubah *logic* di `initState()` atau mengubah struktur *dependency* global.