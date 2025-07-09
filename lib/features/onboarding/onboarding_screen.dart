import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/onboarding_bloc.dart';
import 'bloc/onboarding_event.dart';
import 'bloc/onboarding_state.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    final appBloc = context.read<AppBloc>();

    return BlocProvider(
      create: (_) => OnboardingBloc(
        pageController: pageController,
        appBloc: appBloc,
      ),
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      context.read<OnboardingBloc>().add(PageChanged(index));
                    },
                    children: const [
                      OnboardingPage(
                        title: "Ласкаво просимо!",
                        description: "Це ваш додаток для ментального здоров'я.",
                        image: "assets/mentalHealth.png",
                      ),
                      OnboardingPage(
                        title: "Функції",
                        description:
                            "Ви можете вести щоденник емоцій, слухати аудіо-терапію та більше.",
                        image: "assets/mentalHealth1.png",
                      ),
                      OnboardingPage(
                        title: "Готові розпочати?",
                        description:
                            "Почніть користуватися додатком прямо зараз!",
                        image: "assets/mentalHealth2.png",
                      ),
                    ],
                  ),
                ),
                _buildPageIndicator(
                    state.currentPage, state.totalPages, context),
                _buildNavigationButtons(state, context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageIndicator(
      int currentPage, int totalPages, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          totalPages,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: currentPage == index ? 12 : 8,
            height: currentPage == index ? 12 : 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentPage == index
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(OnboardingState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: state.isFirstPage
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceBetween,
        children: [
          if (!state.isFirstPage)
            ElevatedButton(
              onPressed: () =>
                  context.read<OnboardingBloc>().add(BackPressed()),
              child: const Text('Back'),
            ),
          ElevatedButton(
            onPressed: () {
              if (state.isLastPage) {
                context.read<OnboardingBloc>().add(FinishOnboarding());
              } else {
                context.read<OnboardingBloc>().add(NextPressed());
              }
            },
            child: Text(state.isFirstPage ? "Start" : "Next"),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: screenHeight * 0.3,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 100, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
