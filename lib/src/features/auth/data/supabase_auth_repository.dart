import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../constants/app_constants.dart';
import '../domain/auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  final SupabaseClient client;

  SupabaseAuthRepository(this.client);

  @override
  Future<void> signUp({required String email, required String password}) async {
    final response = await client.auth.signUp(email: email, password: password);
    if (response.user == null) {
      throw Exception(AppConstants.unknownError);
    }
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    final response = await client.auth.signInWithPassword(email: email, password: password);
    if (response.user == null) {
      throw Exception(AppConstants.unknownError);
    }
  }

  @override
  Future<void> signOut() async {
    await client.auth.signOut();
    
  }
}
