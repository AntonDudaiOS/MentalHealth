import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_mental_health_app/core/services/auth_service.dart';
import 'package:my_mental_health_app/core/services/onboarding_service.dart';
import 'app_event.dart';
import 'app_state.dart';
import 'package:my_mental_health_app/core/models/user_model.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthService authService;
  final OnboardingService onboardingService;
  late final StreamSubscription _authSub;

  AppBloc({
    required this.authService,
    required this.onboardingService,
  }) : super(AppState.initial()) {
    _authSub = authService.authStateChanges.listen((user) async {
      if (user != null) {
        final userModel = await _buildUserModel(user.uid);
        add(RegistrationCompleted(userModel: userModel));
      } else {
        add(LoginStarted());
      }
    });

    on<AppStarted>(_onStarted);
    on<OnboardingCompleted>(_onOnboardingCompleted);
    on<RegistrationCompleted>(_onRegistrationCompleted);
    on<LoginStarted>(_onLoginStarted);
    on<RegistryStarted>(_onRegistryStarted);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<TabChanged>(_onTabChanged);
  }

  Future<void> _onTabChanged(TabChanged event, Emitter<AppState> emit) async {
    emit(state.copyWith(selectedTab: event.tab));
    return;
  }

  Future<void> _onStarted(AppStarted event, Emitter<AppState> emit) async {
    emit(const AppState(status: AppStatus.splash));

    final prefs = await SharedPreferences.getInstance();
    final onboardingSeen = prefs.getBool('onboardingSeen') ?? false;
    final isRegistered = prefs.getBool('isRegistered') ?? false;

    if (!onboardingSeen) {
      emit(const AppState(status: AppStatus.showOnboarding));
    } else if (!isRegistered) {
      emit(const AppState(status: AppStatus.showRegistration));
    } else {}
  }

  Future<void> _onOnboardingCompleted(
      OnboardingCompleted event, Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingSeen', true);
    emit(const AppState(status: AppStatus.showRegistration));
  }

  Future<void> _onRegistrationCompleted(
      RegistrationCompleted event, Emitter<AppState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRegistered', true);
    emit(AppState(status: AppStatus.showHome, user: event.userModel));
  }

  Future<void> _onLoginStarted(
      LoginStarted event, Emitter<AppState> emit) async {
    emit(const AppState(status: AppStatus.showLogin));
  }

  Future<void> _onRegistryStarted(
      RegistryStarted event, Emitter<AppState> emit) async {
    emit(const AppState(status: AppStatus.switchToRegistration));
  }

  Future<void> _onLogoutRequested(
      AppLogoutRequested event, Emitter<AppState> emit) async {
    await authService.logout();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRegistered', false);

    emit(const AppState(status: AppStatus.showLogin));
  }

  Future<UserModel> _buildUserModel(String uid) async {
    return UserModel(
      id: uid,
      email: 'example@email.com',
      displayName: 'User',
      subscriptionType: 'free',
    );
  }

  @override
  Future<void> close() async {
    await _authSub.cancel();
    return super.close();
  }
}
