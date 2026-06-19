import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'screens/app.dart';
import 'providers/app_state.dart';
import 'repositories/booking_repository.dart';

// Placeholder Supabase Credentials
// Replace these with your actual local or remote Supabase credentials
const String supabaseUrl = 'https://istoxscgzhbovvbzgdyd.supabase.co';
const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlzdG94c2Nnemhib3Z2YnpnZHlkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzk4Mzg3NjUsImV4cCI6MjA5NTQxNDc2NX0._L9egAfHzHbz-fdK1hy7q5KHaWVrVoVXlx_zBMuWfuE';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  try {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  } catch (e) {
    debugPrint('Supabase init failed. Please check credentials: $e');
  }

  final supabaseClient = Supabase.instance.client;
  final bookingRepository = BookingRepository(supabaseClient: supabaseClient);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(repository: bookingRepository),
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
