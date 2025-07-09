class RegistrationState {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isValid;
  final bool isSubmitted;
  final bool goToLogin;
  final bool isSubmitting;
  final String? errorMessage;
  final bool successfullyRegistered;

  RegistrationState({
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.isValid,
    required this.isSubmitted,
    required this.goToLogin,
    required this.isSubmitting,
    required this.errorMessage,
    required this.successfullyRegistered,
  });

  factory RegistrationState.initial() => RegistrationState(
        email: '',
        password: '',
        confirmPassword: '',
        isValid: false,
        isSubmitted: false,
        goToLogin: false,
        isSubmitting: false,
        errorMessage: null,
        successfullyRegistered: false,
      );

  RegistrationState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isValid,
    bool? isSubmitted,
    bool? goToLogin,
    bool? isSubmitting,
    String? errorMessage,
    bool? successfullyRegistered,
  }) {
    return RegistrationState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValid: isValid ?? this.isValid,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      goToLogin: goToLogin ?? this.goToLogin,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      successfullyRegistered:
          successfullyRegistered ?? this.successfullyRegistered,
    );
  }
}
