import 'package:equatable/equatable.dart';
import 'package:my_mental_health_app/core/models/user_model.dart';

enum AppStatus {
  splash,
  showOnboarding,
  showRegistration,
  showHome,
  showLogin,
  switchToRegistration,
  showSettings,
}

class AppState extends Equatable {
  final AppStatus status;
  final UserModel? user;

  const AppState({
    required this.status,
    this.user,
  });

  factory AppState.initial() => const AppState(status: AppStatus.splash);

  AppState copyWith({
    AppStatus? status,
    UserModel? user,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [status, user];
}
