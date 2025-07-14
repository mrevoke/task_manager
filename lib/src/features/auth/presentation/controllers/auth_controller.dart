import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_manager/src/infra/supabase_provider.dart';

import '../../data/supabase_auth_repository.dart';
import '../../domain/auth_repository.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(supabaseProvider);
  return SupabaseAuthRepository(client);
});

final authStateProvider = StreamProvider<User?>((ref) {
  final client = ref.watch(supabaseProvider);
  return client.auth.onAuthStateChange.map((data) => data.session?.user);
});

final authControllerProvider = Provider<AuthController>((ref) {
  final repo = ref.watch(authRepoProvider);
  return AuthController(ref, repo);
});

class AuthController {
  final Ref ref;
  final AuthRepository _repo;

  AuthController(this.ref, this._repo);

  Future<void> signUp(String email, String password) async {
    await _repo.signUp(email: email, password: password);
  }

  Future<void> signIn(String email, String password) async {
    await _repo.signIn(email: email, password: password);
  }

  Future<void> signOut() async {
    await _repo.signOut();
  }
}
