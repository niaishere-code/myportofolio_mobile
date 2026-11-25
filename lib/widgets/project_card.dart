import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/providers/auth_state.dart';
import 'package:myportofolio_mobile/screens/login.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/project_list.dart';
import 'package:myportofolio_mobile/screens/skill_form.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(PortfolioTheme.radius),
        side: const BorderSide(color: PortfolioTheme.accentDark, width: 2.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(PortfolioTheme.radius),
        onTap: () async {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!"),
              ),
            );

          if (item.name == "Lihat Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProjectListScreen(),
              ),
            );
          } else if (item.name == "Tambah Proyek") {
            final allowed = await ensureLoggedIn(context);
            if (!allowed || !context.mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProjectFormPage(),
              ),
            );
          } else if (item.name == "Tambah Skill") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SkillFormPage(),
              ),
            );
          } else if (item.name == "Logout") {
            final authState = context.read<AuthState>();
            if (!authState.isLoggedIn) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text("Kamu belum masuk ke akun mana pun."),
                  ),
                );
              return;
            }

            try {
              await authState.logout();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text("Logout berhasil! Token sesi telah dihapus."),
                  ),
                );
            } catch (_) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(
                    content: Text("Sesi lokal telah diakhiri."),
                  ),
                );
            }
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: item.foregroundColor,
                  size: 28.0,
                ),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: PortfolioTheme.displayStyle(
                    color: item.foregroundColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: PortfolioTheme.monoStyle(
                    color: item.foregroundColor.withValues(alpha: 0.85),
                    fontSize: 10.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}