import 'package:go_router/go_router.dart';
import 'package:my_mental_health_app/features/home/home_screen.dart';
import 'package:my_mental_health_app/features/onboarding/onboarding_screen.dart';
import 'package:my_mental_health_app/features/registration/signIn/login_screen.dart';
import 'package:my_mental_health_app/features/registration/signUp/registration_screen.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/core/router/go_router_refresh_stream.dart';
import 'package:my_mental_health_app/bloc/app/app_state.dart';
import 'package:my_mental_health_app/features/settings/screens/settings_screen.dart';
import 'package:my_mental_health_app/widgets/main_scaffold.dart';
import 'package:my_mental_health_app/features/tests/tests_screen.dart';
import 'package:my_mental_health_app/features/techniques/techniques_screen.dart';
import 'package:my_mental_health_app/features/relaxation/relaxation_screen.dart';

GoRouter createRouter(AppBloc appBloc) {
  return GoRouter(
    initialLocation: '/home',
    refreshListenable: GoRouterRefreshStream(appBloc.stream),
    redirect: (context, stateGo) {
      final status = appBloc.state.status;
      final location = stateGo.uri.toString();

      if (status == AppStatus.showOnboarding && location != '/onboarding') {
        return '/onboarding';
      }
      if (status == AppStatus.showRegistration && location != '/registry') {
        return '/registry';
      }
      if (status == AppStatus.showHome &&
          (location == '/onboarding' || location == '/registry')) {
        return '/home';
      }
      if (status == AppStatus.showLogin && location != '/login') {
        return '/login';
      }
      if (status == AppStatus.switchToRegistration && location != '/registry') {
        return '/registry';
      }
      return null;
    },
    routes: [
      // Routes out of TaBar
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/registry',
        builder: (context, state) => const RegistrationForm(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginForm(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      // Screens on the TabBar
      ShellRoute(
        builder: (context, state, child) {
          return MainScaffold(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/tests',
            builder: (context, state) => const TestsScreen(), 
          ),
          GoRoute(
            path: '/techniques',
            builder: (context, state) => const TechniquesScreen(), 
          ),
          GoRoute(
            path: '/relaxation',
            builder: (context, state) => const RelaxationScreen(),
          ),
        ],
      ),
    ],
  );
}
