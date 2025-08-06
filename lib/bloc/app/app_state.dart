import 'package:equatable/equatable.dart';
import 'package:my_mental_health_app/core/models/app_tab.dart';
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
  final AppTab selectedTab;

  const AppState({
    required this.status,
    this.user,
    this.selectedTab = AppTab.home,
  });

  factory AppState.initial() => const AppState(
      status: AppStatus.splash,
      selectedTab: AppTab.home,
    );

  AppState copyWith({
    AppStatus? status,
    UserModel? user,
    AppTab? selectedTab,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }

  @override
  List<Object?> get props => [status, user, selectedTab];
}
