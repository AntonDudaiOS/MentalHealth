abstract class OnboardingEvent {}

class PageChanged extends OnboardingEvent {
  final int page;
  PageChanged(this.page);
}

class NextPressed extends OnboardingEvent {}

class BackPressed extends OnboardingEvent {}

class FinishOnboarding extends OnboardingEvent {}
