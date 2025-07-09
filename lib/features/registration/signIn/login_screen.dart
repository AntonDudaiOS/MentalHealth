import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/core/services/auth_service.dart';
import 'package:my_mental_health_app/widgets/email_text_field.dart';
import 'package:my_mental_health_app/widgets/password_text_field.dart';
import 'package:my_mental_health_app/widgets/custom_button.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();
    final authService = AuthService();

    return BlocProvider(
      create: (_) => LoginBloc(appBloc: appBloc, authService: authService),
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (previous, current) =>
            previous.goToRegistry != current.goToRegistry,
        listener: (context, state) {
          if (state.goToRegistry) {
            context.read<LoginBloc>().add(RegistrationButtonTup());
          }
        },
        child: const _LoginFormView(),
      ),
    );
  }
}

class _LoginFormView extends StatefulWidget {
  const _LoginFormView();

  @override
  State<_LoginFormView> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginFormView> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.ifLoginTap) {
          // navigation to Home controller
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Login')),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
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
                                    .requestFocus(_passwordFocus),
                              ),
                              const SizedBox(height: 24),
                              PasswordFormField(
                                label: 'Password',
                                hintText: 'Enter your password',
                                errorText: 'Invalid password',
                                controller: _passwordController,
                                focusNode: _passwordFocus,
                                textInputAction: TextInputAction.done,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 48),
                              CustomButton(
                                text: 'SignIn',
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final email = _emailController.text.trim();
                                    final password =
                                        _passwordController.text.trim();
                                    context.read<LoginBloc>().add(
                                          LoginConfirm(
                                            email: email,
                                            password: password,
                                          ),
                                        );
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   const SnackBar(
                                    //       content:
                                    //           Text('Login successfully done')),
                                    // );
                                  }
                                },
                              ),
                              if (state.ifLoginTap) ...[
                                const SizedBox(height: 24),
                                const Text(
                                  '✅ Login successfully done!!!',
                                  style: TextStyle(color: Colors.amber),
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<LoginBloc>().add(RegistrationButtonTup());
                      },
                      child: const Text('No account? Registry!'),
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
