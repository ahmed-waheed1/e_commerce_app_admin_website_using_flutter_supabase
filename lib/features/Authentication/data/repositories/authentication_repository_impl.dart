import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/secret_data.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../models/user_data_model.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final SupabaseClient client;
  final logger = locator<Logger>();

  AuthenticationRepositoryImpl(this.client);

  @override
  Future<void> login({required String email, required String password}) async {
    await client.auth.signInWithPassword(password: password, email: email);
  }

  @override
  Future<void> register(
      {required String name,
      required String email,
      required String password}) async {
    await client.auth.signUp(password: password, email: email);
  }

  @override
  Future<AuthResponse> googleSignIn() async {
    const webClientId = webClientIdNumber;
    const androidClientId = androidClientIdNumber;

    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
      clientId: androidClientId,
      scopes: [
        'email',
        'profile',
      ],
    );
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      throw Exception('Google sign-in failed');
    }
    final googleAuth = await googleUser.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null || idToken == null) {
      throw Exception('Google sign-in failed');
    }

    return await client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await client.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> addUserData(
      {required String name, required String email}) async {
    await client.from('users').upsert({
      "user_id": client.auth.currentUser?.id,
      "name": name,
      "email": email,
    });
  }

  @override
  Future<UserDataModel?> getUserData() async {
    try {
      final currentUser = client.auth.currentUser;
      if (currentUser == null) {
        throw Exception('No current user found');
      }

      final List<Map<String, dynamic>> data = await client
          .from('users')
          .select("email, name, user_id")
          .eq("user_id", currentUser.id);
      if (data.isNotEmpty) {
        logger
            .i("User data retrieved: ${data[0]["email"]}, ${data[0]["name"]}");
        return UserDataModel(
            email: data[0]["email"],
            name: data[0]["name"],
            userId: data[0]["user_id"]);
      } else {
        logger.i("No user data found");
        throw Exception('No user data found');
      }
    } catch (e) {
      logger.e("Error retrieving user data: ${e.toString()}");
      throw Exception('Failed to load user data: ${e.toString()}');
    }
  }
}
