class OnboardingState {
  final int currentPage;
  final int totalPages;
  final bool completed;

  const OnboardingState({
    required this.currentPage,
    this.totalPages = 3,
    this.completed = false,
  });

  bool get isFirstPage => currentPage == 0;
  bool get isLastPage => currentPage == totalPages - 1;

  OnboardingState copyWith({
    int? currentPage,
    bool? completed,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages,
      completed: completed ?? this.completed,
    );
  }
}
