import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_mental_health_app/core/services/auth_service.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:my_mental_health_app/core/models/user_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AppBloc appBloc;
  final AuthService authService;

  LoginBloc({
    required this.appBloc,
    required this.authService,
  }) : super(LoginState.initial()) {
    on<EmailRow>((event, emit) {
      emit(state.copyWith(
          email: event.email, isValid: _validate(event.email, state.password)));
    });

    on<PasswordRow>((event, emit) {
      emit(state.copyWith(isValid: _validate(state.email, event.password)));
    });

    on<LoginConfirm>(_onLoginConfirm);

    on<RegistrationButtonTup>(_onRegistrationButtonTup);
  }

  Future<void> _onRegistrationButtonTup(
      RegistrationButtonTup event, Emitter<LoginState> emit) async {
    appBloc.add(RegistryStarted());
  }

  Future<void> _onLoginConfirm(
      LoginConfirm event, Emitter<LoginState> emit) async {
    emit(state.copyWith(ifLoginTap: true, errorMessage: null));

    try {
      await authService.login(event.email, event.password);

      final userCredential = FirebaseAuth.instance.currentUser;

      final user = UserModel(
        id: userCredential?.uid ?? '',
        email: event.email,
        displayName: null,
        subscriptionType: 'free',
      );

      emit(state.copyWith(
        ifLoginTap: true,
        errorMessage: null,
      ));
      appBloc.add(LoginCompleted(userModel: user));
    } catch (error) {
      emit(state.copyWith(
        ifLoginTap: false,
        errorMessage: error.toString(),
      ));
    }
  }

  bool _validate(String email, String password) {
    final emailValid = email.contains('@');
    final passValid = password.length >= 8;
    return emailValid && passValid;
  }
}
