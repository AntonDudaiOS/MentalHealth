import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_mental_health_app/core/models/test_model.dart';
import 'package:my_mental_health_app/features/tests/test_detail/bloc/test_detail_bloc.dart';
import 'package:my_mental_health_app/features/tests/test_detail/bloc/test_detail_event.dart';
import 'package:my_mental_health_app/features/tests/test_detail/bloc/test_detail_state.dart';
import 'package:my_mental_health_app/core/services/test_results_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TestDetailScreen extends StatelessWidget {
  final QuantitativeTest test;

  const TestDetailScreen({super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TestDetailBloc(
        testResultService: TestResultService(
          firestore: FirebaseFirestore.instance,
          auth: FirebaseAuth.instance,
        ),
      )..add(StartTest(test)),
      child: Scaffold(
        appBar: AppBar(title: Text(test.title)),
        body: BlocBuilder<TestDetailBloc, TestDetailState>(
          builder: (context, state) {
            if (state is TestDetailInProgress) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.test.questions.length,
                        itemBuilder: (context, index) {
                          final question = state.test.questions[index];
                          final selected = state.answers[index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Питання ${index + 1}: ${question.text}',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              ...state.test.answerScale.map((scale) {
                                return RadioListTile<int>(
                                  title: Text(scale.label),
                                  value: scale.value,
                                  groupValue: selected,
                                  onChanged: (value) {
                                    context.read<TestDetailBloc>().add(
                                      AnswerSelected(index, value!),
                                    );
                                  },
                                );
                              }),
                              const Divider(height: 32),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.answers.length == state.test.questions.length
                              ? () => context.read<TestDetailBloc>().add(SubmitTest())
                              : null,
                          child: const Text('Завершити тест'),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is TestDetailCompleted) {
              return Padding(
                padding: const EdgeInsets.all(24),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ваш результат: ${state.totalScore}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.result.description,
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => context.pop('/tests'),
                              child: const Text('Ще тести'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => context.go('/home'),
                              child: const Text('На головну'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
