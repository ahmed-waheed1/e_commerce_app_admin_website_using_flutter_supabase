import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/models/user_data_model.dart';

abstract class AuthenticationRepository {
  Future<void> login({required String email, required String password});
  Future<void> register(
      {required String name, required String email, required String password});
  Future<AuthResponse> googleSignIn();
  Future<void> signOut();
  Future<void> resetPassword({required String email});
  Future<void> addUserData({required String name, required String email});
  Future<UserDataModel?> getUserData();
}
