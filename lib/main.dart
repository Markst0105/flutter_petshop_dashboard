import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/app.dart';
import 'providers/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const PetshopDashboardApp(),
    ),
  );
}

class PetshopDashboardApp extends StatelessWidget {
  const PetshopDashboardApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Shop Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2b7fff),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const App(),
    );
  }
}
