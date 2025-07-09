import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_event.dart';
import 'package:my_mental_health_app/core/services/auth_service.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_mental_health_app/core/models/user_model.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AppBloc appBloc;
  final AuthService authService;

  RegistrationBloc({
    required this.appBloc,
    required this.authService,
  }) : super(RegistrationState.initial()) {
    on<EmailChanged>((event, emit) {
      emit(state.copyWith(
        email: event.email,
        isValid: _validate(event.email, state.password, state.confirmPassword),
      ));
    });

    on<PasswordChanged>((event, emit) {
      emit(state.copyWith(
        password: event.password,
        isValid: _validate(state.email, event.password, state.confirmPassword),
      ));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      emit(state.copyWith(
        confirmPassword: event.confirmPassword,
        isValid: _validate(state.email, state.password, event.confirmPassword),
      ));
    });

    on<Submitted>(_onSubmitted);
    on<LoginButtonTap>(_onLoginButtonTap);
  }

  Future<void> _onSubmitted(
      Submitted event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      await authService.register(event.email, event.password);

      final userCredential = FirebaseAuth.instance.currentUser;

      final user = UserModel(
        id: userCredential?.uid ?? '',
        email: event.email,
        displayName: null,
        subscriptionType: 'free',
      );

      emit(state.copyWith(
        isSubmitted: true,
        successfullyRegistered: true,
        isSubmitting: false,
        errorMessage: null,
      ));
      appBloc.add(RegistrationCompleted(userModel: user));
    } catch (error) {
      emit(state.copyWith(
        isSubmitting: false,
        successfullyRegistered: false,
        errorMessage: error.toString(),
      ));
    }
  }

  Future<void> _onLoginButtonTap(
      LoginButtonTap event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(goToLogin: true));
    appBloc.add(LoginStarted());
  }

  bool _validate(String email, String password, String confirmPassword) {
    final emailValid = email.contains('@');
    final passValid = password.length >= 8;
    final passMatch = password == confirmPassword;
    return emailValid && passValid && passMatch;
  }
}
