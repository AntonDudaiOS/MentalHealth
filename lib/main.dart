import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_event.dart';
import 'package:my_mental_health_app/bloc/app/app_state.dart';
import 'package:my_mental_health_app/core/router/routes.dart';
import 'package:my_mental_health_app/core/services/auth_service.dart';
import 'package:my_mental_health_app/core/services/onboarding_service.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final authService = AuthService();
  final onboardingService = OnboardingService();

  runApp(
    BlocProvider(
      create: (_) => AppBloc(
        authService: authService,
        onboardingService: onboardingService,
      )..add(AppStarted()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();

    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        final router = createRouter(appBloc);

        return MaterialApp.router(
          routerConfig: router,
          title: 'My Mental App',
          theme: ThemeData.light(),
        );
      },
    );
  }
}
