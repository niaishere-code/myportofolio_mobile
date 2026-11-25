import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
  });

  final String message;
  final int? statusCode;

  @override
  String toString() =>
      statusCode != null ? 'ApiException ($statusCode): $message' : message;
}

class ApiClient {
  ApiClient({
    http.Client? httpClient,
    this.baseUrl = apiBaseUrl,
  }) : _httpClient = httpClient ?? http.Client();

  final http.Client _httpClient;
  final String baseUrl;

  Map<String, String> _headers({String? token}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Token $token',
    };
  }

  /// Mengambil daftar proyek publik dari GET /api/v1/projects/
  Future<List<Project>> fetchProjects() async {
    final uri = Uri.parse('$baseUrl/api/v1/projects/');
    final response = await _httpClient.get(uri, headers: _headers());

    if (response.statusCode == 200) {
      final decoded = jsonDecode(utf8.decode(response.bodyBytes));
      if (decoded is List) {
        return decoded
            .map((item) => Project.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      throw const ApiException(
        message: 'Format respons daftar proyek tidak valid.',
      );
    }

    throw ApiException(
      statusCode: response.statusCode,
      message: 'Gagal memuat daftar proyek (HTTP ${response.statusCode}).',
    );
  }

  /// Menambahkan proyek baru ke POST /api/v1/projects/ (membutuhkan Token)
  Future<Project> createProject(Project project, String token) async {
    final uri = Uri.parse('$baseUrl/api/v1/projects/');
    final payload = project.toJson()
      ..removeWhere((key, value) => value == null);

    final response = await _httpClient.post(
      uri,
      headers: _headers(token: token),
      body: jsonEncode(payload),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      final decoded =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return Project.fromJson(decoded);
    }

    if (response.statusCode == 401 || response.statusCode == 403) {
      throw ApiException(
        statusCode: response.statusCode,
        message:
            'Akses ditolak. Pastikan kamu login sebagai akun yang berwenang.',
      );
    }

    throw ApiException(
      statusCode: response.statusCode,
      message:
          'Gagal menyimpan proyek (HTTP ${response.statusCode}): ${response.body}',
    );
  }

  /// Menukar username & password menjadi token DRF via POST /api/v1/auth/token/
  Future<String> login(String username, String password) async {
    final uri = Uri.parse('$baseUrl/api/v1/auth/token/');
    final response = await _httpClient.post(
      uri,
      headers: _headers(),
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final decoded =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      final token = decoded['token'] as String?;
      if (token != null && token.isNotEmpty) {
        return token;
      }
      throw const ApiException(
        message: 'Token tidak ditemukan pada respons server.',
      );
    }

    if (response.statusCode == 400 || response.statusCode == 401) {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'Username atau password salah.',
      );
    }

    throw ApiException(
      statusCode: response.statusCode,
      message: 'Gagal melakukan login (HTTP ${response.statusCode}).',
    );
  }

  /// Menghapus token aktif di server via POST /api/v1/auth/logout/
  Future<void> logout(String token) async {
    final uri = Uri.parse('$baseUrl/api/v1/auth/logout/');
    final response = await _httpClient.post(
      uri,
      headers: _headers(token: token),
    );

    if (response.statusCode != 204 && response.statusCode != 200) {
      throw ApiException(
        statusCode: response.statusCode,
        message: 'Gagal logout dari server (HTTP ${response.statusCode}).',
      );
    }
  }
}