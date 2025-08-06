import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:my_mental_health_app/core/models/app_tab.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_state.dart';
import 'package:my_mental_health_app/bloc/app/app_event.dart';
import 'package:my_mental_health_app/core/models/user_model.dart';

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

    return BlocListener<AppBloc, AppState>(
      listenWhen: (prev, curr) =>
          prev.selectedTab != curr.selectedTab &&
          curr.selectedTab == AppTab.home,
      listener: (context, state) {
        print('[HomeScreen] ✅ Tab HOME activated');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🟢 Повернулись на Home'),
            duration: Duration(milliseconds: 1500),
          ),
        );
      },
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final UserModel? user = state.user;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hello, ${user?.displayName ?? "User"}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  user?.subscriptionType == 'premium'
                      ? 'You are a Premium user'
                      : 'You are using Free version',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
