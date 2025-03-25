import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/services/service_locator.dart';
import 'core/utils/app_colors.dart';
import 'core/utils/style_manager.dart';
import 'features/Authentication/presentation/cubit/authentication_cubit.dart';
import 'features/Authentication/presentation/pages/forget_password_view.dart';
import 'features/Authentication/presentation/pages/login_view.dart';
import 'features/nav_bar/presentation/cubit/nav_bar_cubit.dart';
import 'features/nav_bar/presentation/pages/main_home_view.dart';
import 'features/nav_bar/presentation/pages/product_detials_view.dart';
import 'features/profile/presentation/pages/edit_name_view.dart';
import 'features/profile/presentation/pages/my_orders_view.dart';
import 'features/profile/presentation/pages/profile_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const FlutterEcommerceApp());
}

class FlutterEcommerceApp extends StatelessWidget {
  const FlutterEcommerceApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) => locator<AuthenticationCubit>(),
        ),
        BlocProvider<NavBarCubit>(
          create: (context) => NavBarCubit(),
        ),
      ],
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
          GetPage(
              name: MainHomeView.routeName, page: () => const MainHomeView()),
          GetPage(name: ProfileView.routeName, page: () => const ProfileView()),
          GetPage(
              name: EditNameView.routeName, page: () => const EditNameView()),
          GetPage(
            name: ProductDetialsView.routeName,
            page: () => const ProductDetialsView(),
          ),
          GetPage(
            name: MyOrdersView.routeName,
            page: () => const MyOrdersView(),
          ),
        ],
        initialRoute: locator<SupabaseClient>().auth.currentUser != null
            ? MainHomeView.routeName
            : LoginView.routeName,
      ),
    );
  }
}
