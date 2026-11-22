import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/skill_form.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: PortfolioTheme.paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: PortfolioTheme.accentDark, width: 2.0),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: PortfolioTheme.accentDark,
              border: Border(
                bottom: BorderSide(color: PortfolioTheme.ink, width: 2.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MyPortfolio',
                  style: PortfolioTheme.displayStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: PortfolioTheme.paper,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore personal projects and skills!',
                  style: PortfolioTheme.monoStyle(
                    fontSize: 13.5,
                    color: PortfolioTheme.accentSoft,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home_outlined,
              color: PortfolioTheme.accentDark,
            ),
            title: Text(
              'Home',
              style: PortfolioTheme.displayStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: PortfolioTheme.ink,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(),
                ),
              );
            },
          ),
          const Divider(height: 1, color: PortfolioTheme.line),
          ListTile(
            leading: const Icon(
              Icons.add_circle_outline,
              color: PortfolioTheme.accentDark,
            ),
            title: Text(
              'Add Project',
              style: PortfolioTheme.displayStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: PortfolioTheme.ink,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProjectFormPage(),
                ),
              );
            },
          ),
          const Divider(height: 1, color: PortfolioTheme.line),
          ListTile(
            leading: const Icon(
              Icons.code,
              color: PortfolioTheme.accentDark,
            ),
            title: Text(
              'Add Skill',
              style: PortfolioTheme.displayStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: PortfolioTheme.ink,
              ),
            ),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const SkillFormPage(),
                ),
              );
            },
          ),
          const Divider(height: 1, color: PortfolioTheme.line),
        ],
      ),
    );
  }
}