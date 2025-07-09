abstract class RegistrationEvent {}

class EmailChanged extends RegistrationEvent {
  final String email;
  EmailChanged(this.email);
}

class PasswordChanged extends RegistrationEvent {
  final String password;
  PasswordChanged(this.password);
}

class ConfirmPasswordChanged extends RegistrationEvent {
  final String confirmPassword;
  ConfirmPasswordChanged(this.confirmPassword);
}

class Submitted extends RegistrationEvent {
  final String email;
  final String password;
  final String confirmPassword;

  Submitted(
      {required this.email,
      required this.password,
      required this.confirmPassword});
}

class LoginButtonTap extends RegistrationEvent {}
