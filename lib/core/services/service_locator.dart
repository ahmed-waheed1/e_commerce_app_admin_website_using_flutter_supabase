import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../features/Authentication/data/repositories/authentication_repository_impl.dart';
import '../../features/Authentication/domain/repositories/authentication_repository.dart';
import '../../features/Authentication/presentation/cubit/authentication_cubit.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // Initialize Supabase
  await Supabase.initialize(
      url: 'https://hqmlbwzlrnmnkduzvfqf.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhxbWxid3pscm5tbmtkdXp2ZnFmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI0MTg3MjAsImV4cCI6MjA1Nzk5NDcyMH0.gHU4WB59pyZk1I5BlQRd_4SJgwEvf7ps1fLdIPmd4U8');
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
