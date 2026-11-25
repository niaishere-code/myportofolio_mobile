import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/providers/auth_state.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:provider/provider.dart';

/// Route guard: mengembalikan `true` jika pengguna sudah login atau berhasil login.
Future<bool> ensureLoggedIn(BuildContext context) async {
  final authState = context.read<AuthState>();
  if (authState.isLoggedIn) {
    return true;
  }

  final result = await Navigator.push<bool>(
    context,
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
  );

  return result == true || authState.isLoggedIn;
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authState = context.read<AuthState>();
    final username = _usernameController.text.trim();
    final password = _passwordController.text;

    try {
      await authState.login(username, password);
      if (!mounted) return;

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('Selamat datang, $username! Login berhasil.'),
          ),
        );

      if (Navigator.canPop(context)) {
        Navigator.pop(context, true);
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      }
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
            content: Text('Tidak dapat terhubung ke server: $e'),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthState>().isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 440),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: PortfolioTheme.card,
              border: Border.all(color: PortfolioTheme.accentDark, width: 2.0),
              borderRadius: BorderRadius.circular(PortfolioTheme.radius),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'AUTHENTICATION',
                    style: PortfolioTheme.monoStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w700,
                      color: PortfolioTheme.accentDark,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Masuk ke MyPortfolio',
                    style: PortfolioTheme.displayStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                      color: PortfolioTheme.ink,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Login menggunakan akun Django untuk menambah proyek baru.',
                    style: PortfolioTheme.monoStyle(
                      fontSize: 12.5,
                      color: PortfolioTheme.textMuted,
                    ),
                  ),
                  const Divider(height: 24, color: PortfolioTheme.line),
                  TextFormField(
                    controller: _usernameController,
                    style: PortfolioTheme.monoStyle(fontSize: 14),
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Masukkan username Django',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        color: PortfolioTheme.accentDark,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Username tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: PortfolioTheme.monoStyle(fontSize: 14),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Masukkan password',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: PortfolioTheme.accentDark,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: PortfolioTheme.accentDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 46,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _handleLogin,
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: PortfolioTheme.paper,
                              ),
                            )
                          : const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}