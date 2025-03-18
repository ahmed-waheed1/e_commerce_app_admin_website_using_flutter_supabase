import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/utils/app_colors.dart';
import 'core/utils/style_manager.dart';
import 'features/Authentication/presentation/cubit/authentication_cubit.dart';
import 'features/Authentication/presentation/pages/forget_password_view.dart';
import 'features/Authentication/presentation/pages/login_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ckculgffeqpjznbmgfug.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNrY3VsZ2ZmZXFwanpuYm1nZnVnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAxNDk4NzEsImV4cCI6MjA1NTcyNTg3MX0.7Jew1_7KOHyUWfG0Dh8BrILqAbcB9oEo4GEo30XNLI0',
  );
  runApp(const FlutterEcommerceApp());
}

class FlutterEcommerceApp extends StatelessWidget {
  const FlutterEcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationCubit(),
      child: GetMaterialApp(
        theme: ThemeData(
          fontFamily: StyleManager.fontFamily,
          scaffoldBackgroundColor: AppColors.kScaffoldColor,
        ),
        debugShowCheckedModeBanner: false,
        title: 'e-commerce app',
        getPages: [
          GetPage(name: LoginView.routeName, page: () => const LoginView()),
          GetPage(
              name: ForgetPasswordView.routeName,
              page: () => const ForgetPasswordView()),
        ],
        initialRoute: LoginView.routeName,
      ),
    );
  }
}
