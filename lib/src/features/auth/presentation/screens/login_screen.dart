import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../task/presentation/widgets/auth_text_field.dart';
import '../controllers/auth_controller.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);
    final messenger = ScaffoldMessenger.of(context);

    return Scaffold(
      body: Center(
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Login',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  AuthTextField(controller: emailController, label: 'Email'),
                  const SizedBox(height: 16),
                  AuthTextField(
                      controller: passwordController,
                      label: 'Password',
                      obscureText: true),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () async {
                        isLoading.value = true;
                        try {
                          await ref.read(authControllerProvider).signIn(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                        } catch (e) {
                          messenger.showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        } finally {
                          isLoading.value = false;
                        }
                      },
                      child: isLoading.value
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Login'),
                    ),
                  ),
                  TextButton(
                    onPressed: () => context.push('/register'),
                    child: const Text("Don't have an account? Register"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
