import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class SkillFormPage extends StatefulWidget {
  const SkillFormPage({super.key});

  @override
  State<SkillFormPage> createState() => _SkillFormPageState();
}

class _SkillFormPageState extends State<SkillFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  String _skillName = "";
  String _category = "Programming Language";
  String _proficiencyLevel = "Intermediate";
  int _yearsOfExperience = 0;
  DateTime? _acquiredDate;
  String _referenceLink = "";

  final List<String> _skillCategories = [
    'Programming Language',
    'Framework & Library',
    'Database & Cloud',
    'Tools & DevOps',
    'UI/UX Design',
  ];

  final List<String> _proficiencyLevels = [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Expert',
  ];

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Color _getProficiencyBgColor(String level) {
    switch (level) {
      case 'Beginner':
        return PortfolioTheme.mint;
      case 'Intermediate':
        return PortfolioTheme.accentSoft;
      case 'Advanced':
        return PortfolioTheme.accent;
      case 'Expert':
        return PortfolioTheme.accentDark;
      default:
        return PortfolioTheme.accentSoft;
    }
  }

  Color _getProficiencyTextColor(String level) {
    return level == 'Expert' ? PortfolioTheme.paper : PortfolioTheme.ink;
  }

  String _formatDate(DateTime date) {
    final String day = date.day.toString().padLeft(2, '0');
    final String month = date.month.toString().padLeft(2, '0');
    final String year = date.year.toString();
    return "$day-$month-$year";
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _acquiredDate ?? now,
      firstDate: DateTime(2000),
      lastDate: now,
    );

    if (picked != null) {
      setState(() {
        _acquiredDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  Widget _buildLivePreviewCard() {
    final Color levelBg = _getProficiencyBgColor(_proficiencyLevel);
    final Color levelFg = _getProficiencyTextColor(_proficiencyLevel);
    final String displaySkillName =
        _skillName.trim().isEmpty ? "Nama Skill" : _skillName.trim();
    final String displayDate =
        _dateController.text.isEmpty ? "Belum dipilih" : _dateController.text;

    return Container(
      margin: const EdgeInsets.only(bottom: 18.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: PortfolioTheme.card,
        border: Border.all(color: PortfolioTheme.accentDark, width: 2.0),
        borderRadius: BorderRadius.circular(PortfolioTheme.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.visibility_outlined,
                    size: 16,
                    color: PortfolioTheme.accentDark,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'LIVE PREVIEW',
                    style: PortfolioTheme.monoStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: PortfolioTheme.accentDark,
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: levelBg,
                  border: Border.all(
                    color: PortfolioTheme.accentDark,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  _proficiencyLevel,
                  style: PortfolioTheme.displayStyle(
                    color: levelFg,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 20, color: PortfolioTheme.line),
          Text(
            _category.toUpperCase(),
            style: PortfolioTheme.monoStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              color: PortfolioTheme.accentDark,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            displaySkillName,
            style: PortfolioTheme.displayStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: _skillName.trim().isEmpty
                  ? PortfolioTheme.textMuted
                  : PortfolioTheme.ink,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.work_history_outlined,
                size: 15,
                color: PortfolioTheme.textMuted,
              ),
              const SizedBox(width: 4),
              Text(
                '$_yearsOfExperience tahun',
                style: PortfolioTheme.monoStyle(
                  fontSize: 12.5,
                  color: PortfolioTheme.textMuted,
                ),
              ),
              const SizedBox(width: 16),
              const Icon(
                Icons.event_available_outlined,
                size: 15,
                color: PortfolioTheme.textMuted,
              ),
              const SizedBox(width: 4),
              Text(
                displayDate,
                style: PortfolioTheme.monoStyle(
                  fontSize: 12.5,
                  color: PortfolioTheme.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Skill Form'),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // === Opsi 1: Live Preview Card ===
              _buildLivePreviewCard(),

              // === Nama Skill ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: TextFormField(
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "Contoh: Flutter, Python, PostgreSQL",
                    labelText: "Nama Skill",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _skillName = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Nama skill tidak boleh kosong!";
                    }
                    if (value.trim().length < 2) {
                      return "Nama skill minimal terdiri dari 2 karakter!";
                    }
                    if (value.trim().length > 50) {
                      return "Nama skill maksimal 50 karakter!";
                    }
                    return null;
                  },
                ),
              ),

              // === Kategori Skill ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: DropdownButtonFormField<String>(
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  dropdownColor: PortfolioTheme.card,
                  decoration: const InputDecoration(
                    labelText: "Kategori Skill",
                  ),
                  initialValue: _category,
                  items: _skillCategories
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
                      return "Kategori skill tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),

              // === Opsi 2: Pemilih Tingkat Kemahiran Interaktif (.filter-chip) ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: "Tingkat Kemahiran",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 10.0,
                    ),
                  ),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 6.0,
                    children: _proficiencyLevels.map((level) {
                      final bool isSelected = _proficiencyLevel == level;
                      final Color chipBg = _getProficiencyBgColor(level);
                      final Color chipFg = _getProficiencyTextColor(level);

                      return ChoiceChip(
                        label: Text(
                          level,
                          style: PortfolioTheme.displayStyle(
                            color: isSelected
                                ? chipFg
                                : PortfolioTheme.accentDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.5,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: chipBg,
                        checkmarkColor: chipFg,
                        backgroundColor: PortfolioTheme.card,
                        shape: const StadiumBorder(
                          side: BorderSide(
                            color: PortfolioTheme.accentDark,
                            width: 1.8,
                          ),
                        ),
                        onSelected: (bool selected) {
                          if (selected) {
                            setState(() {
                              _proficiencyLevel = level;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),

              // === Tahun Pengalaman (Integer) ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "Contoh: 2",
                    labelText: "Lama Pengalaman (Tahun)",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _yearsOfExperience = int.tryParse(value ?? '') ?? 0;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Lama pengalaman tidak boleh kosong!";
                    }
                    final int? parsed = int.tryParse(value.trim());
                    if (parsed == null) {
                      return "Lama pengalaman harus berupa bilangan bulat!";
                    }
                    if (parsed < 0 || parsed > 50) {
                      return "Lama pengalaman harus berada di antara 0 hingga 50 tahun!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tanggal Mulai / Sertifikasi (showDatePicker) ===
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
                child: TextFormField(
                  controller: _dateController,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "Pilih tanggal mulai / sertifikasi",
                    labelText: "Tanggal Mulai / Sertifikasi",
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: PortfolioTheme.accentDark,
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        _acquiredDate == null) {
                      return "Tanggal mulai atau sertifikasi wajib dipilih!";
                    }
                    if (_acquiredDate!.isAfter(DateTime.now())) {
                      return "Tanggal tidak boleh melebihi hari ini!";
                    }
                    return null;
                  },
                ),
              ),

              // === Tautan Bukti / Sertifikat (URL) ===
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextFormField(
                  keyboardType: TextInputType.url,
                  style: PortfolioTheme.monoStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: "Contoh: https://github.com/niaishere-code",
                    labelText: "Tautan Bukti / Sertifikat",
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _referenceLink = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Tautan bukti atau sertifikat tidak boleh kosong!";
                    }
                    final uri = Uri.tryParse(value.trim());
                    if (uri == null ||
                        !uri.hasAuthority ||
                        uri.host.isEmpty ||
                        (uri.scheme != 'http' && uri.scheme != 'https')) {
                      return "Masukkan format URL yang valid (diawali http:// atau https://)!";
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
                            title: const Text('Skill berhasil ditambahkan!'),
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Nama Skill: $_skillName'),
                                  const SizedBox(height: 4),
                                  Text('Kategori: $_category'),
                                  const SizedBox(height: 4),
                                  Text(
                                      'Tingkat Kemahiran: $_proficiencyLevel'),
                                  const SizedBox(height: 4),
                                  Text(
                                      'Pengalaman: $_yearsOfExperience tahun'),
                                  const SizedBox(height: 4),
                                  Text('Tanggal: ${_dateController.text}'),
                                  const SizedBox(height: 4),
                                  Text('Tautan: $_referenceLink'),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                  _formKey.currentState!.reset();
                                  _dateController.clear();
                                  setState(() {
                                    _skillName = "";
                                    _category = "Programming Language";
                                    _proficiencyLevel = "Intermediate";
                                    _yearsOfExperience = 0;
                                    _acquiredDate = null;
                                    _referenceLink = "";
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