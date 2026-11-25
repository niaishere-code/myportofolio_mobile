import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/providers/auth_state.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/theme/portfolio_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ApiClient>(
          create: (_) => ApiClient(),
        ),
        ChangeNotifierProvider<AuthState>(
          create: (context) => AuthState(
            apiClient: context.read<ApiClient>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'MyPortfolio',
        theme: PortfolioTheme.themeData,
        home: MyHomePage(),
      ),
    );
  }
}