import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final SupabaseClient client;

  ProfileRepository(this.client);

  Future<void> updateUserName(String name) async {
    final currentUser = client.auth.currentUser;
    if (currentUser == null) {
      throw Exception('No current user found');
    }

    final response = await client
        .from('users')
        .update({'name': name}).eq('user_id', currentUser.id);

    if (response.error != null) {
      throw Exception('Failed to update user name: ${response.error!.message}');
    }
  }
}
