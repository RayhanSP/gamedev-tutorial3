# Tutorial 3

**Nama:** Rayhan Syahdira Putra  
**NPM:** 2306275903  

---

Pada latihan mandiri ini, saya mengimplementasikan tiga fitur, yaitu Double Jump, Crouching, dan Dashing. Berikut adalah proses pengerjaannya:

## 1. Double Jump 
Fitur ini memungkinkan karakter untuk melompat sekali lagi saat masih berada di udara.

Saya menambahkan variabel max_jumps (dengan nilai 2) dan jump_count untuk melacak jumlah lompatan. Setiap kali karakter menyentuh lantai (is_on_floor()), jump_count di-reset ke 0. Saat tombol lompat ditekan, sistem akan mengecek apakah karakter berada di lantai OR jump_count masih kurang dari max_jumps. Jika syarat terpenuhi, velocity.y diubah menjadi kecepatan lompat dan jump_count ditambah 1.

Animasinya, sistem akan mengecek status lompatan di udara. Jika jump_count bernilai 2, maka AnimatedSprite2D akan memutar animasi khusus bernama doublejump.

## 2. Crouching
Fitur ini memungkinkan karakter untuk berjongkok ketika pemain menahan tombol Ctrl.

Ketika tombol ditahan dan karakter berada di lantai, pergerakan horizontal karakter akan dihentikan paksa (velocity.x = 0). Saya juga menambahkan guard clause agar karakter tidak bisa melompat saat sedang dalam state jongkok.

Animasinya, saat kondisi jongkok terpenuhi, karakter memutar animasi crouch.

## 3. Dashing
Saya mengimplementasikan dash sekali tekan menggunakan tombol Shift.

Saya menggunakan variabel boolean is_dashing dan timer dash_timer. Saat trigger, kecepatan horizontal karakter dikalikan dengan kecepatan tinggi (dash_speed) sesuai dengan arah hadap Sprite saat itu (flip_h). Kecepatan vertikal (velocity.y) di-set menjadi 0 agar efek gravitasi diabaikan sementara, sehingga karakter bisa melakukan air-dash lurus. Logika timer akan menghitung mundur menggunakan delta hingga durasi dash habis.

Animasinya, agar bervariasi, saat dash tereksekusi, script akan menggunakan fungsi pick_random() dari sebuah Array string untuk memilih secara acak antara memutar animasi dash atau slide.