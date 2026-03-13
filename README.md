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

---

# Tutorial 5: Animasi Asset & Integrasi Audio

Pada latihan mandiri ini, saya mengimplementasikan aset visual (*spritesheet*) dan audio ke dalam permainan, serta membangun interaksi antar objek. Berikut adalah proses pengerjaannya:

## 1. Efek Suara (SFX) Karakter
Fitur ini memberikan umpan balik berupa suara (*audio feedback*) setiap kali karakter pemain melakukan aksi lompat.

Saya menambahkan node `AudioStreamPlayer` sebagai *child* dari node karakter pemain. Pada *script* pergerakan karakter, saya menyisipkan pemanggilan fungsi `.play()` tepat setelah logika lompatan tereksekusi. Aset suara lompatan ini saya unduh secara gratis dari Pixabay.

## 2. Objek Baru Interaktif (Collectible Coin)
Saya membuat sebuah objek koin baru di dalam permainan yang dilengkapi dengan animasi menggunakan *spritesheet*. Aset *spritesheet* koin ini didapatkan secara gratis dari OpenGameArt.

Pembuatan objek ini menggunakan node `Area2D` sebagai *root*, dilengkapi dengan `CollisionShape2D` untuk mendeteksi tabrakan, dan `AnimatedSprite2D` untuk visual. Untuk animasinya, saya memotong (*slicing*) *spritesheet* menggunakan fitur import *grid* pada panel SpriteFrames dan mengatur agar animasi berputar (*loop*) secara otomatis menggunakan fitur *Autoplay on Load*.

## 3. Umpan Balik Interaksi
Fitur ini mengimplementasikan sistem audio yang memberikan efek suara saat koin diambil.

Untuk interaksinya, saya menghubungkan sinyal `body_entered` dari `Area2D` ke *script* koin. Ketika sinyal mendeteksi perpotongan (*overlap*) dengan node bernama "Player", *script* akan mengeksekusi urutan berikut:
1. Memutar efek suara *pickup* (menggunakan `AudioStreamPlayer`).
2. Menyembunyikan sprite koin (`hide()`).
3. Mematikan fungsi deteksi tabrakan sementara dengan `set_deferred("monitoring", false)` agar audio tidak terpicu berkali-kali.
4. Menghapus objek baru sepenuhnya dari hirarki (*scene tree*) menggunakan `queue_free()` setelah menunggu (menggunakan sintaks `await`) efek suara *pickup* selesai diputar.

---

### Referensi
Godot Engine Documentation: AnimatedSprite2D Class
    Referensi pengelolaan *state* animasi, manipulasi properti `flip_h` untuk membalikkan *sprite* sesuai arah gerak, serta penggunaan fungsi `play()`.
   [https://docs.godotengine.org/en/stable/classes/class_animatedsprite2d.html](https://docs.godotengine.org/en/stable/classes/class_animatedsprite2d.html)
   
Godot Engine Documentation: InputEvent and InputMap
   Panduan untuk mengelola *custom action* pada Input Map (seperti penambahan aksi `dash` dan `crouch`).
   [https://docs.godotengine.org/en/stable/tutorials/inputs/inputevent.html](https://docs.godotengine.org/en/stable/tutorials/inputs/inputevent.html)

Godot Engine Documentation: Array Class
   Referensi untuk logika variasi animasi dinamis menggunakan *method* `pick_random()` dari tipe data Array bawaan GDScript.
   [https://docs.godotengine.org/en/stable/classes/class_array.html#class-array-method-pick-random](https://docs.godotengine.org/en/stable/classes/class_array.html#class-array-method-pick-random)

OpenGameArt.org
   Sumber aset visual gratis berlisensi terbuka yang digunakan untuk animasi *spritesheet* koin.
   [https://opengameart.org/](https://opengameart.org/)

Pixabay Sound Effects
   Sumber aset efek suara (SFX) gratis berlisensi terbuka yang digunakan untuk suara lompatan karakter, *ambient* koin, dan efek *pickup*.
   [https://pixabay.com/sound-effects/](https://pixabay.com/sound-effects/)