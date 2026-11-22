import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _projectName = "";
  String _description = "";
  String _category = "Web Development";
  String _technologies = "";
  String _projectLink = "";

  final List<String> _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

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
              // === Project Name ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: TextFormField(
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "Nama Proyek",
                    labelText: "Nama Proyek",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _projectName = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama proyek tidak boleh kosong!";
                    }
                    if (value.trim().length < 3) {
                      return "Nama proyek minimal terdiri dari 3 karakter!";
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
                      _description = value!;
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

              // === Category ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: DropdownButtonFormField<String>(
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  dropdownColor: PortfolioTheme.card,
                  decoration: const InputDecoration(
                    labelText: "Kategori Proyek",
                  ),
                  initialValue: _category,
                  items: _categories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Kategori proyek tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Technologies ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: TextFormField(
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "Contoh: Flutter, Django, Figma",
                    labelText: "Teknologi yang Digunakan",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _technologies = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Teknologi yang digunakan tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Project Link ===
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "Contoh: https://github.com/niaishere-code/project",
                    labelText: "Tautan Proyek",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _projectLink = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tautan proyek tidak boleh kosong!";
                    }
                    final uri = Uri.tryParse(value.trim());
                    if (uri == null ||
                        !uri.hasAuthority ||
                        uri.host.isEmpty ||
                        (uri.scheme != 'http' && uri.scheme != 'https')) {
                      return "Masukkan tautan URL yang valid (diawali http:// atau https://)!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
              SizedBox(
                height: 46,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Proyek berhasil ditambahkan!'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Nama Proyek: $_projectName'),
                                  const SizedBox(height: 4),
                                  Text('Deskripsi: $_description'),
                                  const SizedBox(height: 4),
                                  Text('Kategori: $_category'),
                                  const SizedBox(height: 4),
                                  Text('Teknologi: $_technologies'),
                                  const SizedBox(height: 4),
                                  Text('Tautan: $_projectLink'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _formKey.currentState!.reset();
                                  setState(() {
                                    _projectName = "";
                                    _description = "";
                                    _category = "Web Development";
                                    _technologies = "";
                                    _projectLink = "";
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text("Simpan"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}