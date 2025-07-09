class LoginState {
  final String email;
  final String password;
  final bool isValid;
  final bool ifLoginTap;
  final bool goToRegistry;
  final String? errorMessage;

  LoginState({
    required this.email,
    required this.password,
    required this.isValid,
    required this.ifLoginTap,
    required this.goToRegistry,
    required this.errorMessage,
  });

  factory LoginState.initial() => LoginState(
        email: '',
        password: '',
        isValid: false,
        ifLoginTap: false,
        goToRegistry: false,
        errorMessage: null,
      );

  LoginState copyWith({
    String? email,
    String? password,
    bool? isValid,
    bool? ifLoginTap,
    bool? goToRegistry,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      ifLoginTap: ifLoginTap ?? this.ifLoginTap,
      goToRegistry: goToRegistry ?? this.goToRegistry,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
