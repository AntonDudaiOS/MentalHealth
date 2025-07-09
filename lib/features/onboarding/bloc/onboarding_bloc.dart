import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_event.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final PageController pageController;
  final AppBloc appBloc;

  OnboardingBloc({required this.pageController, required this.appBloc})
      : super(const OnboardingState(currentPage: 0)) {
    on<PageChanged>((event, emit) {
      emit(state.copyWith(currentPage: event.page));
    });

    on<NextPressed>((event, emit) {
      if (!state.isLastPage) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    on<BackPressed>((event, emit) {
      if (!state.isFirstPage) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });

    on<FinishOnboarding>(_onFinishOnboarding);
  }

  Future<void> _onFinishOnboarding(
      FinishOnboarding event, Emitter<OnboardingState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingSeen', true);
    appBloc.add(OnboardingCompleted());
  }
}
