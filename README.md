# Latihan Responsi IF-C - Toko Anikwork

Aplikasi mobile toko online berbasis Flutter yang menggunakan API eksternal untuk menampilkan produk dan menyimpan data keranjang belanja di database lokal.

## Fitur Utama

### 1. **Autentikasi & Session Management**

- Login dengan username bebas dan password (NIM)
- Session disimpan menggunakan Shared Preferences
- Otomatis masuk ke halaman utama jika sudah login sebelumnya
- Fitur logout untuk menghapus session

### 2. **Halaman Home**

- Menampilkan username pengguna yang sedang login
- Tombol keranjang belanja dengan counter jumlah item
- Grid produk dari API https://dummyjson.com/products
- Setiap produk dapat diklik untuk melihat detail

### 3. **Halaman Detail Produk**

- Menampilkan informasi lengkap produk (judul, harga, rating, deskripsi, stok)
- Gallery gambar produk (swipe untuk melihat gambar lain)
- Selector quantity (kurang/tambah dengan validasi stok)
- Tombol "Add to Cart" untuk menambahkan ke keranjang
- Data disimpan ke Hive dengan username user

### 4. **Halaman Keranjang Belanja**

- Menampilkan semua produk yang sudah ditambahkan oleh user
- Setiap user memiliki keranjang berbeda (terpisah berdasarkan username)
- Fitur mengubah quantity produk
- Fitur menghapus produk dari keranjang
- Menampilkan total harga dan tombol checkout
- Data disimpan di Hive dengan key berdasarkan username dan product ID

### 5. **Halaman Profile**

- Menampilkan informasi username yang sedang login
- Deskripsi toko
- Status pengguna (Aktif)
- Tombol logout dengan konfirmasi

### 6. **Bottom Navigation Bar**

- Home: Navigasi ke halaman home
- Profile: Navigasi ke halaman profile

## Struktur Project

```
lib/
├── main.dart                           # Entry point aplikasi
├── models/
│   ├── product_model.dart             # Model untuk produk dari API
│   ├── cart_item_model.dart           # Model untuk item keranjang (Hive entity)
│   └── cart_item_model.g.dart         # Generated file untuk Hive adapter
├── screens/
│   ├── login_screen.dart              # Layar login
│   ├── main_screen.dart               # Layar utama dengan bottom nav
│   ├── home_screen.dart               # Layar home dengan daftar produk
│   ├── product_detail_screen.dart     # Layar detail produk
│   ├── cart_screen.dart               # Layar keranjang belanja
│   └── profile_screen.dart            # Layar profile pengguna
├── controllers/
│   ├── auth_controller.dart           # Controller untuk autentikasi (GetX)
│   ├── product_controller.dart        # Controller untuk produk (GetX)
│   └── cart_controller.dart           # Controller untuk keranjang (GetX)
└── services/
    ├── api_service.dart               # Service untuk HTTP request ke API
    ├── storage_service.dart           # Service untuk Shared Preferences
    └── cart_service.dart              # Service untuk Hive database
```
