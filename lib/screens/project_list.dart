import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/screens/login.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  late Future<List<Project>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = context.read<ApiClient>().fetchProjects();
  }

  Future<void> _refreshProjects() async {
    setState(() {
      _projectsFuture = context.read<ApiClient>().fetchProjects();
    });
    await _projectsFuture;
  }

  Future<void> _navigateToAddProject() async {
    final allowed = await ensureLoggedIn(context);
    if (!allowed || !mounted) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProjectFormPage(),
      ),
    );
    if (mounted) {
      _refreshProjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Proyek'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Muat Ulang',
            onPressed: _refreshProjects,
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: PortfolioTheme.accentDark,
        foregroundColor: PortfolioTheme.paper,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(PortfolioTheme.radius),
          side: const BorderSide(color: PortfolioTheme.ink, width: 2.0),
        ),
        onPressed: _navigateToAddProject,
        icon: const Icon(Icons.add),
        label: Text(
          'Tambah Proyek',
          style: PortfolioTheme.monoStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: PortfolioTheme.paper,
          ),
        ),
      ),
      body: RefreshIndicator(
        color: PortfolioTheme.accentDark,
        onRefresh: _refreshProjects,
        child: FutureBuilder<List<Project>>(
          future: _projectsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: PortfolioTheme.accentDark,
                ),
              );
            }

            if (snapshot.hasError) {
              return ListView(
                padding: const EdgeInsets.all(20.0),
                children: [
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      color: PortfolioTheme.card,
                      border: Border.all(
                        color: PortfolioTheme.danger,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(PortfolioTheme.radius),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Gagal Memuat Data Proyek',
                          style: PortfolioTheme.displayStyle(
                            fontSize: 17,
                            color: PortfolioTheme.danger,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${snapshot.error}',
                          style: PortfolioTheme.monoStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _refreshProjects,
                          icon: const Icon(Icons.refresh, size: 18),
                          label: const Text('Coba Lagi'),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            final projects = snapshot.data ?? [];
            if (projects.isEmpty) {
              return ListView(
                padding: const EdgeInsets.all(24.0),
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: PortfolioTheme.card,
                      border: Border.all(
                        color: PortfolioTheme.accentDark,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(PortfolioTheme.radius),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.folder_open_outlined,
                          size: 42,
                          color: PortfolioTheme.accentDark,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Belum ada proyek tersimpan.',
                          style: PortfolioTheme.displayStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tambahkan proyek portofolio pertamamu melalui tombol di bawah.',
                          textAlign: TextAlign.center,
                          style: PortfolioTheme.monoStyle(
                            fontSize: 12.5,
                            color: PortfolioTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 88),
              itemCount: projects.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                final project = projects[index];
                final hasImage = project.projectImageUrl != null &&
                    project.projectImageUrl!.trim().isNotEmpty;

                return Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: PortfolioTheme.card,
                    border: Border.all(
                      color: PortfolioTheme.accentDark,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(PortfolioTheme.radius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hasImage) ...[
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(PortfolioTheme.radius),
                          child: Image.network(
                            project.projectImageUrl!,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: PortfolioTheme.accentSoft,
                          border: Border.all(
                            color: PortfolioTheme.accentDark,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          project.techStack,
                          style: PortfolioTheme.monoStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: PortfolioTheme.accentDark,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        project.title,
                        style: PortfolioTheme.displayStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: PortfolioTheme.ink,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        project.description,
                        style: PortfolioTheme.monoStyle(
                          fontSize: 13.0,
                          color: PortfolioTheme.textMuted,
                        ),
                      ),
                      const Divider(height: 20, color: PortfolioTheme.line),
                      Row(
                        children: [
                          const Icon(
                            Icons.link,
                            size: 16,
                            color: PortfolioTheme.accentDark,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              project.projectUrl,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: PortfolioTheme.monoStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                color: PortfolioTheme.accentDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}