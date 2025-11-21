# uts_arizaljunior_pm

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# UTS_Pemob2_Arizal-Junior

## Jawaban untuk Soal Bagian A – Teori

---

## **1. Jelaskan bagaimana state management dengan Cubit dapat membantu dalam pengelolaan transaksi yang memiliki logika diskon dinamis.**

Cubit membantu mengelola transaksi dengan logika diskon dinamis karena:

a. **Memisahkan logika bisnis dari UI**, sehingga perhitungan diskon, subtotal, dan total transaksi tidak tercampur dengan kode tampilan.  
b. **Memungkinkan pembaruan state secara real-time.** Saat quantity berubah, item ditambah/dihapus, atau persentase diskon diganti, Cubit langsung memancarkan state baru.  
c. **State yang terstruktur** memastikan setiap perubahan konsisten (misalnya total selalu dihitung ulang otomatis).  
d. **Logika diskon lebih fleksibel**, misalnya diskon musiman, diskon minimal pembelian, atau voucher.  
e. **Mendukung reusability**, sehingga logika diskon tidak perlu ditulis ulang pada banyak widget.  
f. **Mengurangi potensi bug**, karena seluruh perhitungan melalui satu sumber kebenaran (single source of truth).

**Kesimpulan:**  
Cubit memberikan alur terstruktur, reaktif, dan aman untuk mengelola transaksi dengan logika diskon dinamis.

---

## **2. Apa perbedaan antara diskon per item dan diskon total transaksi? Berikan contohnya dalam aplikasi kasir.**

### **a. Diskon Per Item**  
Diskon diterapkan pada **setiap produk secara individual**.

**Karakteristik:**  
- Besaran diskon berbeda per barang.  
- Harga akhir = *harga setelah diskon × quantity*.  
- Cocok untuk promo produk tertentu, misalnya:  
  - “Diskon 10% untuk semua minuman.”  
  - “Diskon Rp 5.000 per ayam goreng.”

**Contoh di aplikasi kasir:**  
- Saat item “Latte” dipilih, sistem otomatis mengurangi 10% dari harga aslinya.  
- Jika quantity menjadi 3 pcs, diskon diterapkan untuk tiap item.

---

### **b. Diskon Total Transaksi**  
Diskon diterapkan pada **total belanja**, bukan per item.

**Karakteristik:**  
- Pengaruhnya terlihat pada nilai “Total Belanja”.  
- Cocok untuk promo umum, seperti:  
  - “Diskon 20% untuk total transaksi di atas Rp 200.000.”  
  - “Voucher potongan Rp 15.000.”

**Contoh di aplikasi kasir:**  
- Setelah seluruh item masuk ke keranjang, total dihitung.  
- Jika total mencapai Rp 200.000, otomatis diberi diskon 20%.  
- Diskon hanya diberikan sekali, tidak per item.

---

## **3. Jelaskan manfaat penggunaan widget Stack pada tampilan kategori menu di aplikasi Flutter.**

Widget **Stack** sangat berguna untuk tampilan yang memerlukan elemen **bertumpuk (overlapping)**.

### **Manfaat Stack:**
a. Dapat menempatkan beberapa elemen di atas satu sama lain, seperti gambar, teks, dan badge promo.  
b. Membuat UI kategori lebih menarik, misalnya teks kategori di atas gambar background.  
c. Mendukung penempatan elemen di posisi tertentu menggunakan `Positioned` (misalnya ikon di pojok).  
d. Fleksibel untuk membuat kartu kategori yang memakai bayangan, gradient overlay, atau kombinasi elemen dekoratif.  
e. Memudahkan menambahkan efek seperti blur, gradient, atau highlight.

### **Contoh Penerapan:**
- Kategori “Coffee” menampilkan gambar kopi sebagai background.  
- Di atasnya terdapat overlay hitam transparan agar teks terbaca.  
- Teks “Coffee” dan badge “Promo 20%” diposisikan menggunakan `Positioned`.

Stack memudahkan pembuatan layout ini tanpa mempersulit struktur UI.

---

