import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:task_manager/src/constants/routes_paths.dart';
import 'package:task_manager/src/features/task/presentation/screens/add_task_screen.dart';
import 'package:task_manager/src/features/task/presentation/screens/task_list_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/controllers/auth_controller.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RoutePaths.login,
    redirect: (context, state) {
      final loggedIn = authState.asData?.value != null;
      final loggingIn = state.uri.path == RoutePaths.login || state.uri.path == RoutePaths.register;

      if (!loggedIn && !loggingIn) return RoutePaths.login;
      if (loggedIn && loggingIn) return RoutePaths.home;
      return null;
    },
    routes: [
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutePaths.home,
        builder: (context, state) => const TaskListScreen(),
      ),
      GoRoute(
        path: RoutePaths.addTask,
        builder: (context, state) => const AddTaskScreen(),
      ),
    ],
  );
});
