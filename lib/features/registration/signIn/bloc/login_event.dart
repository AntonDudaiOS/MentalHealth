abstract class LoginEvent {}

class EmailRow extends LoginEvent {
  final String email;
  EmailRow(this.email);
}

class PasswordRow extends LoginEvent {
  final String password;
  PasswordRow(this.password);
}

class LoginConfirm extends LoginEvent {
  final String email;
  final String password;

  LoginConfirm({required this.email, required this.password});
}

class RegistrationButtonTup extends LoginEvent {}
