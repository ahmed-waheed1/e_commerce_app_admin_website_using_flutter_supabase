import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/Authentication/data/repositories/authentication_repository_impl.dart';
import '../../features/Authentication/domain/repositories/authentication_repository.dart';
import '../../features/Authentication/presentation/cubit/authentication_cubit.dart';
import '../utils/secret_data.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize Supabase
  await Supabase.initialize(
      url: supabaseUrl, anonKey: anonKey);
  locator.registerLazySingleton<Logger>(() => Logger());
  // Register SupabaseClient
  locator.registerSingleton<SupabaseClient>(Supabase.instance.client);

  // Register AuthenticationRepository
  locator.registerSingleton<AuthenticationRepository>(
    AuthenticationRepositoryImpl(locator<SupabaseClient>()),
  );

  // Register AuthenticationCubit
  locator.registerFactory(
      () => AuthenticationCubit(locator<AuthenticationRepository>()));
}
