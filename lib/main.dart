import 'package:e_commerce_app_admin_website_using_flutter_supabase/features/auth/views/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FlutterEcommerceApp());
}

class FlutterEcommerceApp extends StatelessWidget {
  const FlutterEcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'e-commerce app',
      home: const LoginView(),
    );
  }
}
