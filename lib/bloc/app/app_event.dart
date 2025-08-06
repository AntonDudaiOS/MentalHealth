import 'package:my_mental_health_app/core/models/app_tab.dart';
import 'package:my_mental_health_app/core/models/user_model.dart';

abstract class AppEvent {}

class AppStarted extends AppEvent {}

class OnboardingCompleted extends AppEvent {}

class RegistrationCompleted extends AppEvent {
  final UserModel userModel;

  RegistrationCompleted({required this.userModel});
}

class LoginStarted extends AppEvent {}

class LoginCompleted extends AppEvent {
  final UserModel userModel;

  LoginCompleted({required this.userModel});
}

class RegistryStarted extends AppEvent {}

class AppLogoutRequested extends AppEvent {}


class TabChanged extends AppEvent {
  final AppTab tab;

  TabChanged(this.tab);
}