Nama : Rania Aqila

NPM : 2506623282

Kelas : PBP C

-------------------------------------

### Tugas 7

**Refleksi**
1. Widget tree adalah struktur hierarki yang merepresentasikan seluruh elemen user interface di sebuah aplikasi Flutter yang mana mengcangkup mulai dari teks, tombol, ikon, hingga padding dan layout. Sebuah tree memiliki struktur "bercabang" mulai dari 1 root paling atas hingga leaf berupa elemen paling terakhir. Parent membungkus child lewat properti child atau children kemudian menentukan constraints (min/max lebar & tinggi) utk child yang kemudian child tsb menentukan ukurannya sendiri di dalam rentang batasan tersebut, dan memberitahu kembali ke parentnya untuk kemudian parent memposisikan childnya. Selain itu, parent (eg MaterialApp & Theme) mewariskan konfigurasi desain, skema warna, arah teks, dan sistem navigasi ke seluruh widget keturunannya melalui BuildContext.

2. List widget yang digunakan:

    *Widget Bawaan Flutter*
- MaterialApp: Root widget yang membungkus aplikasi dengan standar Material Design, mengatur judul aplikasi, tema warna, dan halaman utama
- Scaffold: Kerangka halaman Material Design untuk AppBar, body, dan Snackbar
- AppBar: header di atas halaman yang menampilkan judul aplikasi dan tombol aksi
- Padding: Memberi jarak di sekeliling child 
- Column / Row: Menyusun children secara vertikal dari atas ke bawah / horizontal dari kiri ke kanan
- SizedBox: Spasi atau ukuran tetap antar-widget
- Center: Menempatkan widget child di tengah area yang disediakan oleh parentnya
- GridView: Menampilkan elemen secara grid
- Card: Kartu dan baris item yang membungkus informasi pada InfoCard
- Container: Mengatur lebar, padding, dan tata letak elemen di dalamnya
- Material: Memberi permukaan Material (warna, elevation, borderRadius) pada ItemCard
- Inkwell: Membuat area ItemCard bisa diclick dan memberi efek ripple
- Icon: Menampilkan ikon vektor 
- Text:	Menampilkan teks dengan TextStyle
- Snackbar: Menampilkan notifikasi di bagian bawah layar yang dipanggil melalui ScaffoldMessenger
- SingleChildScrollView: membungkus body agar dapat discroll dan tidak overflow di layar kecil.
- FittedBox: Mengecilkan teks content di InfoCard agar fit dengan ukuran box
- Divider: Garis pemisah antara text (data diri dan deskripsi ketika click icon profile)
- IconButton: Button ikon info di AppBar yang memanggil _showProfileDialog
- TextButton: Botton “Tutup” di dialog yang memanggil Navigator.of(context).pop()
- AlertDialog: Menampilkan dialog profil (judul, konten, actions) lewat fungsi showDialog

    *Custom Widget*
- MyApp: StatelessWidget utama aplikasi yang mengonfigurasi skema warna berbasis Colors.indigo dan menentukan MyHomePage sebagai layar pembuka
- MyHomePage: StatelessWidget yang membangun struktur halaman utama menu portofolio beserta daftar kartu identitas dan tombol aksi.
- InfoCard: StatelessWidget kartu informasi untuk menampilkan identitas pemilik portofolio (NPM, Name, dan Class) secara terstruktur
- ItemCard: StatelessWidget kartu tombol menu portofolio yang menampilkan ikon, label aksi, warna latar berbeda, dan memicu SnackBar saat ditekan

3. MaterialApp adalah widget konfigurasi tingkat aplikasi yang mengimplementasikan Material Design, umumnya digunakan sebagai root widget karena menyediakan berbagai pengaturan utama yang dibutuhkan oleh aplikasi secara keseluruhan seperti
- home -> menentukan halaman yang pertama kali ditampilkan ketika aplikasi dijalankan
- theme dan darkTheme -> menentukan tampilan visual aplikasi (e.g. warna, jenis tulisan)
- routes dan initialRoute -> mengatur perpindahan antarhalaman dalam aplikasi
- menyediakan konfigurasi aplikasi -> mengatur informasi seperti judul aplikasi, bahasa, dan konfigurasi navigasi

4. StatelessWidget digunakan ketika data yang tampilan bersifat statis, ditentukan oleh data dari constructor seperti label, ikon, header, layout statis, dll. Sedangkan StatefulWidget digunakan ketika UI harus berubah karena data yang diinput yang berubah / reaktif terhadap interaksi pengguna seperti counter, toggle, checkbox, TextEditingController, hasil async fetch data, dll. Berikut adalah perbedaan mereka:

    *StatelessWidget*
- Data bersifat immutable (tetap), seluruh properti bertipe final
- Memiliki satu class & override build
- Rebuild hanya saat parent memberi data baru
- Memiliki lifecycle berupa konstruktor → build()


    *StatefulWidget*
- Data bersifat mutable (dapat berubah), memiliki objek State terpisah
- Memiliki dua class: widget + State
- Rebuild saat parent rebuild atau setState() dipanggil
- Memiliki lifecycle lengkap (createState(), initState(), didUpdateWidget(), dll)


5. BuildContext adalah objek referensi (handle) yang merepresentasikan lokasi sebuah widget di dalam widget tree dimana setiap widget dalam tree memiliki instance BuildContext-nya masing-masing. Dengan mengetahui lokasi, sebuah widget dapat mengakses informasi atau layanan yang disediakan oleh widget-widget parentnya seperti mengambil konfigurasi dan mengakses fungsi yang disediakan oleh widget lain. Di dalam metode build, ia dapat digunakan untuk (contohnya dalam projek ini):
- Theme.of(context).colorScheme.primary di AppBar -> mengambil warna utama tema yang didefinisikan pada MaterialApp
- ScaffoldMessenger.of(context)..showSnackBar(...) di ItemCard -> menemukan Scaffold terdekat dan menampilkan pesan SnackBar
- MediaQuery.of(context).size.width di dalam InfoCard -> memperoleh lebar layar perangkat

6. Hot reload merupakan fitur Flutter untuk memperbarui kode program dan langsung melihat perubahan pada aplikasi tanpa harus menjalankan ulang seluruh aplikasi dari awal (memasukkan perubahan kode ke dalam Dart Virtual Machine (VM) yang sedang berjalan), sedangkan Hot Restart menjalankan ulang aplikasi Flutter dari awal pada lingkungan aplikasi yang sama (menghapus dan menginisialisasi ulang state Dart aplikasi). Kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart apabila:
- Mengubah kode di dalam fungsi main() atau metode initState() pada StatefulWidget
- Mengubah nilai variabel global, variabel bertipe static, atau initializer final/const global
- Mengubah tipe widget (e.g mengubah StatelessWidget menjadi StatefulWidget)
- Mengubah enum menjadi class biasa, atau mengubah deklarasi tipe generik.


**Deklarasi AI**

Sebagian besar arsitektur dan implementasi utama pada proyek myportofolio_mobile untuk memenuhi seluruh requirement tugas 7 dikerjakan secara mandiri tanpa AI, mengingat penjelasan di tutorial sudah jelas dan digunakan sebagai basis dalam pengerjaan tugas 7, meliputi:
- Pemisahan halaman utama MyHomePage sebagai StatelessWidget ke dalam berkas lib/menu.dart
- Konfigurasi MaterialApp dan skema warna utama pada berkas lib/main.dart.   
- Pembuatan 3 kartu identitas (InfoCard) yang memuat data NPM (2506623282), nama (Rania Aqila), dan kelas (PBP C).
- Perubahan warna item
- Implementasi komponen dasar ItemHomepage, ItemCard, tata letak GridView.count, serta mekanisme umpan balik SnackBar interaktif saat tombol ditekan

Pada tugas ini, Gemini (Google) digunakan secara terbatas sebagai asisten code review untuk memeriksa kesesuaian checklist tugas, memberikan saran penyempurnaan tata letak UI/UX untuk mendapatkan full point sesuai rubrik.

Prompt:
Berikan rekomendasi peningkatan UI/UX dan interaktivitas yang relevan untuk aplikasi portofolio ini agar memenuhi kriteria skor maksimal tanpa mengubah MyHomePage dari StatelessWidge (dengan menyertakan rubrik penilaian)

Jawaban AI:
Dari sesi brainstorming, AI memberikan beberapa opsi peningkatan antarmuka—mulai dari penambahan section baru berbasis StatefulWidget untuk filter daftar proyek menggunakan ChoiceChip dan modal bottom sheet, perubahan gaya SnackBar menjadi floating, penambahan ikon di dalam InfoCard, tata letak grid 2x2 dengan 4 tombol aksi, hingga penambahan modal profil pada AppBar. 

Keterbatasan AI: 
- AI menyarankan terlalu banyak komponen tambahan sekaligus (seperti penambahan section baru berbasis StatefulWidget untuk filter daftar proyek, modifikasi desain InfoCard, hingga perubahan gaya SnackBar), yang kurang selaras dengan konsep desain halaman utama portofolio, ia tidak bisa mengevaluasi secara detail konteks projek diluar kode dari tutorial yang telah ada
- AI tidak dapat melihat proporsi tampilan aktual pada layar perangkat sehingga pilihan warna bawaan pada ItemCard perlu disesuaikan kembali agar lebih kontras dan sesuai dengan preferensi pembuat.

Implementasi mandiri:
Saya tidak mengambil seluruh ide yang diberikan oleh AI, melainkan menyeleksi hanya fitur yang selaras dengan konsep desain aplikasi portofolio saya yang ringkas, bersih, dan berfokus pada fungsi navigasi menu utama, yakni
- Tata Letak Grid 2x2 dengan 4 Tombol Aksi (ItemCard): Menambahkan tombol Lihat Skills serta membungkus halaman dengan SingleChildScrollView dan FittedBox guna mencegah RenderFlex overflow pada layar kecil.   
- Dialog Modal Info Profil pada AppBar: Menambahkan tombol ikon informasi (IconButton) di sisi kanan AppBar yang memunculkan AlertDialog berisi ringkasan identitas pemilik portofolio (Rania Aqila, 2506623282, PBP C).

Saya pun memeriksa ulang seluruh kode setelah integrasi untuk memastikan kesesuaian data, memodifikasi kembali warna setiap ItemCard agar kontras satu sama lain, serta pesan SnackBar tetap mempertahankan format wajib "Kamu telah menekan tombol [Nama Tombol]!". Selain itu, saya juga menjalankan perintah flutter analyze pada root folder proyek hingga dipastikan bersih (No issues found!), lalu menguji seluruh interaksi tombol dan modal dialog secara langsung pada aplikasi.

---------------------------------------------------------