import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final String npm = "2506623282";
  final String nama = "Rania Aqila";
  final String kelas = "PBP C";

  final List<ItemHomepage> items = [
    ItemHomepage(
      "Lihat Proyek",
      "Eksplorasi karya & studi kasus",
      Icons.folder_outlined,
      PortfolioTheme.accentDark,
      PortfolioTheme.paper,
    ),
    ItemHomepage(
      "Tambah Proyek",
      "Unggah item portofolio baru",
      Icons.add_circle_outline,
      PortfolioTheme.mint,
      PortfolioTheme.ink,
    ),
    ItemHomepage(
      "Tambah Skill",
      "Catat keahlian & teknologi",
      Icons.code,
      PortfolioTheme.accent,
      PortfolioTheme.ink,
    ),
    ItemHomepage(
      "Logout",
      "Keluar dari sesi aplikasi",
      Icons.logout,
      PortfolioTheme.danger,
      PortfolioTheme.paper,
    ),
  ];

  void _showProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              const Icon(Icons.account_circle, color: PortfolioTheme.accentDark),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Profil Pemilik Portofolio',
                  style: PortfolioTheme.displayStyle(
                    fontSize: 17,
                    color: PortfolioTheme.ink,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama: $nama',
                style: PortfolioTheme.monoStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text('NPM: $npm', style: PortfolioTheme.monoStyle(fontSize: 13.5)),
              const SizedBox(height: 4),
              Text('Kelas: $kelas', style: PortfolioTheme.monoStyle(fontSize: 13.5)),
              const Divider(height: 20, color: PortfolioTheme.line),
              Text(
                'Aplikasi MyPortfolio Mobile untuk menampilkan daftar proyek dan keahlian.',
                style: PortfolioTheme.monoStyle(
                  fontSize: 12.5,
                  color: PortfolioTheme.textMuted,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPortfolio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Info Profil',
            onPressed: () => _showProfileDialog(context),
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Baris horizontal 3 InfoCard bergaya kartu portofolio
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            const SizedBox(height: 20.0),

            // Bagian tengah: pesan sambutan & kisi tombol menu portofolio
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                    child: Column(
                      children: [
                        Text(
                          'PORTFOLIO DASHBOARD',
                          style: PortfolioTheme.monoStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: PortfolioTheme.accentDark,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(
                              'Selamat datang di ',
                              style: PortfolioTheme.displayStyle(
                                fontSize: 18.0,
                                color: PortfolioTheme.ink,
                              ),
                            ),
                            Transform.rotate(
                              angle: -0.03,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: PortfolioTheme.accent,
                                  borderRadius: BorderRadius.circular(
                                    PortfolioTheme.radius,
                                  ),
                                ),
                                child: Text(
                                  'MyPortfolio!',
                                  style: PortfolioTheme.displayStyle(
                                    fontSize: 18.0,
                                    color: PortfolioTheme.ink,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // GridView 2x2 kartu aksi
                  GridView.count(
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    crossAxisCount: 2,
                    childAspectRatio: 1.38,
                    shrinkWrap: true,
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3.5,
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: PortfolioTheme.card,
        border: Border.all(color: PortfolioTheme.accentDark, width: 2.0),
        borderRadius: BorderRadius.circular(PortfolioTheme.radius),
      ),
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: PortfolioTheme.monoStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: PortfolioTheme.textMuted,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 6.0),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              content,
              style: PortfolioTheme.displayStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w700,
                color: PortfolioTheme.ink,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemHomepage {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color foregroundColor;

  ItemHomepage(
    this.name,
    this.subtitle,
    this.icon,
    this.color,
    this.foregroundColor,
  );
}