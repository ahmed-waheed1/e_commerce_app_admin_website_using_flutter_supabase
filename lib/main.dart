import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/app_colors.dart';
import 'features/Authentication/presentation/pages/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ckculgffeqpjznbmgfug.supabase.co',
    // apiKey: 'your
    // -anon-key',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNrY3VsZ2ZmZXFwanpuYm1nZnVnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAxNDk4NzEsImV4cCI6MjA1NTcyNTg3MX0.7Jew1_7KOHyUWfG0Dh8BrILqAbcB9oEo4GEo30XNLI0',
  );
  runApp(const FlutterEcommerceApp());
}

class FlutterEcommerceApp extends StatelessWidget {
  const FlutterEcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kScaffoldColor,
      ),
      debugShowCheckedModeBanner: false,
      title: 'e-commerce app',
      home: const LoginView(),
    );
  }
}
