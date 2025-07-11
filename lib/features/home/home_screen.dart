import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_mental_health_app/widgets/custom_button.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_state.dart';
import 'package:my_mental_health_app/core/models/user_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      analytics.logScreenView(
       screenClass: 'HomeScreen',
       screenName: 'HomeScreen',
      );
    });

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        final UserModel? user = state.user;

        return Scaffold(
          appBar: AppBar(
            title: Text('Hello, ${user?.displayName ?? "User"}'),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => context.push('/settings'),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  user?.subscriptionType == 'premium'
                      ? 'You are a Premium user'
                      : 'You are using Free version',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: 'Settings',
                      border: Border.all(color: Colors.purple, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.4),
                          spreadRadius: 2.5,
                          blurRadius: 4,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      onPressed: () {
                        context.push('/settings');
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
