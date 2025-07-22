import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            Center(
              child: Text(
                'Навіщо проходити тести?',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              ' Психологічні тести допомагають краще зрозуміти свій емоційний стан,'
              ' виявити тривожність, депресію або ПТСР на ранніх стадіях.',
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 60),
            const Text(
              ' Тестування займає 3–5 хвилин і базується на науково обґрунтованих методиках.',
              textAlign: TextAlign.start,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/test_list');
                },
                child: const Text('Переглянути тести'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
