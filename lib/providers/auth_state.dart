import 'package:flutter/foundation.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

class AuthState extends ChangeNotifier {
  AuthState({required this.apiClient});

  final ApiClient apiClient;

  String? _token;
  String? _username;
  bool _isLoading = false;

  String? get token => _token;
  String? get username => _username;
  bool get isLoggedIn => _token != null && _token!.isNotEmpty;
  bool get isLoading => _isLoading;

  Future<void> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final receivedToken = await apiClient.login(username, password);
      _token = receivedToken;
      _username = username;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    final currentToken = _token;
    _isLoading = true;
    notifyListeners();

    try {
      if (currentToken != null && currentToken.isNotEmpty) {
        await apiClient.logout(currentToken);
      }
    } finally {
      _token = null;
      _username = null;
      _isLoading = false;
      notifyListeners();
    }
  }
}