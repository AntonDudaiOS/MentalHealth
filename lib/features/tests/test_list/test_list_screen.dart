import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/core/services/firebase_storage_service.dart';
import 'package:my_mental_health_app/features/tests/test_list/bloc/test_list_bloc.dart';
import 'package:my_mental_health_app/features/tests/test_list/bloc/test_list_event.dart';
import 'package:my_mental_health_app/features/tests/test_list/bloc/test_list_state.dart';

class TestsListScreen extends StatelessWidget {
  const TestsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TestListBloc(FirebaseTestService())
        ..add(LoadTestList('full_all_tests.json')),
      child: const TestsListView(),
    );
  }
}

class TestsListView extends StatelessWidget {
  const TestsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF6FA),
      appBar: AppBar(title: const Text('Обрати тест')),
      body: BlocBuilder<TestListBloc, TestListState>(
        builder: (context, state) {
          if (state is TestListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TestListLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: state.tests.length,
              itemBuilder: (context, index) {
                final test = state.tests[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      // TODO: transition to the test
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            test.title,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            test.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is TestListError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
