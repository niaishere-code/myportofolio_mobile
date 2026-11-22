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

### Tugas 8

**Refleksi**
1. Navigator.push() digunakan untuk membuka halaman baru di atas halaman yang sedang ditampilkan. Halaman sebelumnya tetap tersimpan di dalam navigation stack (di dalam memori tepat di bawahnya) sehingga pengguna dapat kembali menggunakan tombol Back. Navigator.pushReplacement() digunakan untuk membuka halaman baru sekaligus menggantikan halaman yang sedang aktif. Halaman sebelumnya dihapus dari navigation stack sehingga pengguna tidak dapat kembali ke halaman tersebut menggunakan tombol Back. Sedangkan Navigator.pop() digunakan untuk menutup halaman yang sedang aktif dan kembali ke halaman sebelumnya. Mmbuka formulir dari kartu aksi menggunakan Navigator.push() sebagaimana halaman formulir perlu dibuka tanpa menghilangkan halaman utama. Halaman utama tetap tersimpan di lapisan bawah tumpukan navigasi, sehingga pengguna dapat kembali ke halaman utama kapan saja melalui tombol Back. Sementara itu, opsi Home pada Drawer digunakan untuk mengarahkan pengguna kembali ke halaman utama sehingga dapat menggunakan Navigator.popUntil(context, (route) => route.isFirst) yang akan menghapus halaman-halaman di atas halaman pertama dari navigation stack sehingga pengguna kembali ke halaman utama serta menggunakan Navigator.pop(context) untuk menutup Drawer sebelumnya. 

2. Scaffold berfungsi sebagai kerangka utama Material Design pada setiap halaman yang menyediakan struktur seperti AppBar (bagian atas halaman yang biasanya menampilkan judul halaman serta tombol navigasi), Drawer (panel navigasi yang muncul dari sisi layar dan menyediakan menu untuk berpindah ke bagian lain aplikasi), dan body (area konten utama). Palet warna yang diadaptasi dari desain web portofolio sebelumnya didefinisikan secara terpusat di PortfolioTheme (ThemeData pada MaterialApp) dan diterapkan pada lebih dari satu halaman:   
- Warna --accent-dark (#6E1E42) digunakan sebagai warna latar AppBar serta garis tepi pada kartu identitas InfoCard dan tombol aksi ItemCard di halaman utama (MyHomePage), sekaligus digunakan kembali pada AppBar, garis tepi kolom input (InputDecoration), tombol Simpan, dan bingkai AlertDialog di halaman ProjectFormPage maupun SkillFormPage.   
- Warna latar kertas --paper (#FFF3F6) digunakan sebagai scaffoldBackgroundColor pada MyHomePage, ProjectFormPage, dan SkillFormPage, serta menjadi warna latar panel navigasi LeftDrawer.

3. Formulir pada ProjectFormPage dan SkillFormPage disusun menggunakan kombinasi SingleChildScrollView dan Column (crossAxisAlignment: CrossAxisAlignment.stretch). Tata letak vertikal satu kolom (Column) dipilih karena sesuai dengan pola pengisian formulir dari atas ke bawah pada layar perangkat seluler berorientasi potret, memudahkan pembacaan label maupun pesan kesalahan tepat di bawah masing-masing kolom, serta memastikan seluruh kolom isian dan tombol Simpan membentang selebar layar secara proporsional. Terdapat dua jenis widget yang membantu mengatur tampilan formulir:
- Widget pengatur jarak, seperti SizedBox, Padding, dan Spacer, digunakan untuk memberikan jarak antar-elemen agar formulir tidak terlihat terlalu rapat. Contohnya, SizedBox dapat memberikan jarak antara satu kolom input dengan kolom berikutnya.
- Widget penggulir, seperti SingleChildScrollView, digunakan agar seluruh konten formulir tetap dapat diakses ketika tinggi layar tidak cukup untuk menampilkan semua elemen sekaligus. Pengguna dapat menggulir layar ke bawah untuk melihat dan mengisi bagian formulir lainnya.

4. GlobalKey<FormState> digunakan sebagai identitas unik untuk mengakses dan mengelola kondisi formulir sehingga aplikasi dapat memanggil fungsi validasi pada Form. Validator merupakan fungsi yang dipasang pada widget input, seperti TextFormField, untuk memeriksa apakah nilai yang dimasukkan pengguna sudah memenuhi aturan tertentu. Jika input tidak sesuai, fungsi ini mengembalikan pesan kesalahan. Jika sesuai, fungsi mengembalikan null. validate() merupakan metode yang menjalankan seluruh fungsi validator pada field yang berada di dalam Form. Metode ini menghasilkan nilai true apabila semua input valid dan false apabila terdapat input yang tidak valid. Contoh Nilai yang Ditolak oleh Validasi:
- Pada kolom Tautan Proyek (ProjectFormPage) atau Tautan Bukti / Sertifikat (SkillFormPage), jika pengguna memasukkan teks "   " (hanya berisi spasi) atau "[github.com/niaishere-code](https://github.com/niaishere-code)" (tanpa awalan http:// atau https://), fungsi validator akan menolaknya dan memunculkan pesan kesalahan "Masukkan format URL yang valid (diawali http:// atau https://)!".
- Pada kolom Lama Pengalaman (Tahun) (SkillFormPage), jika pengguna memasukkan nilai 75 atau -2, fungsi validator akan menolaknya karena berada di luar rentang aturan 0 hingga 50 tahun.

**Deklarasi AI**
Pada tugas ini, Gemini (Google) digunakan secara terbatas sebagai asisten code review untuk memeriksa kesesuaian checklist tugas, memberikan saran penyempurnaan tata letak UI/UX untuk mendapatkan full point sesuai rubrik.

Prompt:
Sesuaikan color di web ini dengan nuansa portofolio sebelumnya serta berikan rekomendasi peningkatan UI/UX dan interaktivitas yang relevan untuk aplikasi portofolio ini agar memenuhi kriteria skor maksimal 4.0 (dengan menyertakan rubrik penilaian: Menambahkan fitur ekstra, interaktivitas, atau elemen UI/UX yang relevan di luar instruksi minggu ini)

Jawaban AI:
Dari sesi brainstorming, AI memberikan beberapa opsi peningkatan antarmuka—mulai dari penambahan Live Preview Card yang diperbarui secara real-time di atas formulir, pemilih tingkat kemahiran interaktif menggunakan ChoiceChip atau Slider, tombol sekunder Reset Form beserta SnackBar konfirmasi, input tag teknologi dinamis menggunakan InputChip pada ProjectFormPage, hingga dekorasi prefixIcon dan penghitung karakter (maxLength) pada setiap kolom input.

Keterbatasan AI: 
- AI menyarankan terlalu banyak komponen tambahan sekaligus (seperti tombol Reset terpisah, InputChip untuk daftar teknologi, serta ikon dan penghitung karakter di seluruh kolom) yang kurang selaras dengan konsep desain formulir portofolio yang ringkas dan berpotensi membuat tampilan menjadi terlalu penuh.
- Ketika awal diminta untuk menyesuaikan color dengan web portofolio sebelumnya, AI malah merombak ulang semua warnanya menjadi yang default tutorial

Implementasi mandiri:
Saya tidak mengambil seluruh ide yang diberikan oleh AI, melainkan menyeleksi hanya fitur yang selaras dengan konsep desain aplikasi portofolio saya yang ringkas, bersih, dan berfokus pada fungsi navigasi menu utama, yakni
- Live Preview Card pada SkillFormPage: Menampilkan preview kartu skill secara di bagian atas formulir yang otomatis berubah mengikuti isian nama skill, kategori, tingkat kemahiran, lama pengalaman, dan tanggal sertifikasi.
- Pemilih Tingkat Kemahiran Interaktif (ChoiceChip): Menambahkan pilihan tingkat level (Beginner, Intermediate, Advanced, Expert) yang langsung terhubung dengan badge pada Live Preview Card dan ringkasan AlertDialog.
Saya juga mengatur ulang sendiri untuk menyesuaikan tema warna dan font untuk disamakan dengan yang sudah diimlementasikan di style.css dalam web portofolio sebelumnya.

Prompt:
Mengajukan pertanyaan konseptual mengenai maksud poin checklist "Validasi dan Dialog Ringkasan" pada spesifikasi Tugas 8—khususnya cara kerja tombol Simpan dalam memanggil FormState.validate(), syarat kemunculan AlertDialog melalui showDialog(), serta fungsi tombol Tutup atau OK untuk menutup dialog dan kembali ke formulir.

Jawaban AI:
AI memecah penjelasan menjadi tiga tahapan alur kerja berdasarkan kode pada project_form.dart dan skill_form.dart:
- Pemanggilan _formKey.currentState!.validate() saat tombol Simpan ditekan untuk menjalankan seluruh fungsi validator di dalam Form secara serentak dan memunculkan pesan kesalahan merah pada kolom yang tidak valid.   
- Penempatan showDialog() berisi AlertDialog ringkasan isian secara eksklusif di dalam blok kondisi if (_formKey.currentState!.validate()) agar kotak pop-up hanya muncul setelah semua kolom lolos validasi.   
- Penggunaan Navigator.pop(context) pada tombol OK (TextButton) untuk menutup lapisan overlay AlertDialog dan mengembalikan pengguna ke halaman formulir sambil mereset ulang status formulir.   

Keterbatasan AI: 
AI hanya menjelaskan alur logika berdasarkan potongan sintaks kode tanpa dapat menguji langsung bagaimana perilaku UI saat berbagai kombinasi input salah dimasukkan secara bersamaan

Implementasi mandiri:
Saya menguji formulir secara langsung dengan berbagai skenario uji negatif (mengosongkan kolom, mengisi spasi saja, memasukkan format URL tanpa http:// atau https://, serta membiarkan tanggal kosong) untuk memastikan pesan kesalahan muncul sebelum dialog ditampilkan, lalu menguji tombol OK guna memastikan dialog tertutup dan seluruh isian formulir ter-reset dengan bersih.

Saya pun memeriksa ulang seluruh kode setelah integrasi untuk memastikan kesesuaian data, menyelaraskan palet warna pink (#FFF3F6, #6E1E42, #FF8FB1, #BFE8D4) serta tipografi (Space Grotesk dan monospace) dengan style.css web portofolio saya, serta memvalidasi seluruh aturan input (validator untuk string kosong/spasi, batas panjang karakter, rentang angka, tanggal pada showDatePicker(), dan format URL) beserta tampilan AlertDialog ringkasan. Selain itu, saya juga menjalankan perintah flutter analyze pada root folder proyek hingga dipastikan bersih (No issues found!), lalu menguji seluruh interaksi form dan tombol secara langsung pada aplikasi.