import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/widgets/email_text_field.dart';
import 'package:my_mental_health_app/widgets/password_text_field.dart';
import 'package:my_mental_health_app/widgets/custom_button.dart';
import 'package:my_mental_health_app/core/services/auth_service.dart';
import 'bloc/sign_up_bloc.dart';
import 'bloc/sign_up_event.dart';
import 'bloc/sign_up_state.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final authService = AuthService();

    return BlocProvider(
      create: (_) => RegistrationBloc(
        appBloc: appBloc,
        authService: authService,
      ),
      child: BlocConsumer<RegistrationBloc, RegistrationState>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          return const _RegistrationFormView();
        },
      ),
    );
  }
}

class _RegistrationFormView extends StatefulWidget {
  const _RegistrationFormView();

  @override
  State<_RegistrationFormView> createState() => _RegistrationFormViewState();
}

class _RegistrationFormViewState extends State<_RegistrationFormView> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  final _passFocus = FocusNode();
  final _confPassFocus = FocusNode();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confPassController = TextEditingController();

  @override
  void dispose() {
    _emailFocus.dispose();
    _passFocus.dispose();
    _confPassFocus.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.isSubmitted) {}
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Registration')),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              EmailFormField(
                                label: 'Email',
                                hintText: 'Enter your email',
                                errorText: 'Invalid email address',
                                controller: _emailController,
                                focusNode: _emailFocus,
                                textInputAction: TextInputAction.next,
                                onSubmit: (_) => FocusScope.of(context)
                                    .requestFocus(_passFocus),
                              ),
                              const SizedBox(height: 24),
                              PasswordFormField(
                                label: 'Password',
                                hintText: 'Enter your password',
                                errorText: 'Invalid password',
                                controller: _passController,
                                focusNode: _passFocus,
                                textInputAction: TextInputAction.next,
                                onSubmit: (_) => FocusScope.of(context)
                                    .requestFocus(_confPassFocus),
                              ),
                              const SizedBox(height: 24),
                              PasswordFormField(
                                label: 'Confirm password',
                                hintText: 'Confirm your password',
                                errorText: 'Please confirm your password',
                                controller: _confPassController,
                                focusNode: _confPassFocus,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (value != _passController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 32),
                              CustomButton(
                                text: 'SignUp',
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final email = _emailController.text.trim();
                                    final password =
                                        _passController.text.trim();
                                    final confirmPassword =
                                        _confPassController.text.trim();

                                    context.read<RegistrationBloc>().add(
                                          Submitted(
                                            email: email,
                                            password: password,
                                            confirmPassword: confirmPassword,
                                          ),
                                        );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<RegistrationBloc>().add(LoginButtonTap());
                      },
                      child: const Text('Already have account? Login'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
