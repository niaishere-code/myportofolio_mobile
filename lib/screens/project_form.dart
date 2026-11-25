import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/providers/auth_state.dart';
import 'package:myportofolio_mobile/screens/login.dart';
import 'package:myportofolio_mobile/screens/project_list.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _techStack = "";
  String _projectUrl = "";
  String _projectImageUrl = "";
  bool _isSubmitting = false;

  bool _isValidHttpUrl(String value) {
    final uri = Uri.tryParse(value.trim());
    return uri != null &&
        uri.hasAuthority &&
        uri.host.isNotEmpty &&
        (uri.scheme == 'http' || uri.scheme == 'https');
  }

  Future<void> _submitProject() async {
    if (!_formKey.currentState!.validate()) return;

    final allowed = await ensureLoggedIn(context);
    if (!allowed || !mounted) return;

    final token = context.read<AuthState>().token;
    if (token == null || token.isEmpty) return;

    setState(() {
      _isSubmitting = true;
    });

    final newProject = Project(
      title: _title.trim(),
      description: _description.trim(),
      techStack: _techStack.trim(),
      projectUrl: _projectUrl.trim(),
      projectImageUrl:
          _projectImageUrl.trim().isEmpty ? null : _projectImageUrl.trim(),
    );

    try {
      final created =
          await context.read<ApiClient>().createProject(newProject, token);
      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Proyek berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Judul Proyek: ${created.title}'),
                  const SizedBox(height: 4),
                  Text('Deskripsi: ${created.description}'),
                  const SizedBox(height: 4),
                  Text('Tech Stack: ${created.techStack}'),
                  const SizedBox(height: 4),
                  Text('Tautan Proyek: ${created.projectUrl}'),
                  if (created.projectImageUrl != null &&
                      created.projectImageUrl!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text('URL Gambar: ${created.projectImageUrl}'),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          );
        },
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ProjectListScreen(),
        ),
      );
    } on ApiException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: PortfolioTheme.danger,
            content: Text(e.message),
          ),
        );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: PortfolioTheme.danger,
            content: Text('Terjadi kesalahan jaringan: $e'),
          ),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Project Form'),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // === Title ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: TextFormField(
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "Nama / Judul Proyek",
                    labelText: "Judul Proyek",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Judul proyek tidak boleh kosong!";
                    }
                    if (value.trim().length < 3) {
                      return "Judul proyek minimal terdiri dari 3 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Description ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: TextFormField(
                  maxLines: 5,
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "Deskripsi Proyek",
                    labelText: "Deskripsi Proyek",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _description = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Deskripsi proyek tidak boleh kosong!";
                    }
                    if (value.trim().length < 10) {
                      return "Deskripsi proyek minimal terdiri dari 10 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tech Stack ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: TextFormField(
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "Contoh: Flutter, Django REST, PostgreSQL",
                    labelText: "Tech Stack",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _techStack = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tech stack tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Project URL ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText:
                        "Contoh: https://github.com/niaishere-code/project",
                    labelText: "Tautan Proyek (Project URL)",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _projectUrl = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tautan proyek tidak boleh kosong!";
                    }
                    if (!_isValidHttpUrl(value)) {
                      return "Masukkan tautan URL yang valid (diawali http:// atau https://)!";
                    }
                    return null;
                  },
                ),
              ),

              // === Project Image URL (Opsional) ===
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "https://example.com/preview.png (opsional)",
                    labelText: "URL Gambar Proyek (Opsional)",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _projectImageUrl = value ?? "";
                    });
                  },
                  validator: (String? value) {
                    if (value != null &&
                        value.trim().isNotEmpty &&
                        !_isValidHttpUrl(value)) {
                      return "Masukkan URL gambar yang valid (diawali http:// atau https://)!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitProject,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: PortfolioTheme.paper,
                          ),
                        )
                      : const Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}