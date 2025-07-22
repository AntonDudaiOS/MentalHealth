import 'package:flutter/material.dart';
import 'package:my_mental_health_app/core/models/test_model.dart';
import 'package:my_mental_health_app/core/services/firebase_storage_service.dart';

class TestsScreen extends StatefulWidget {
  const TestsScreen({super.key});

  @override
  State<TestsScreen> createState() => _TestsScreenState();
}

class _TestsScreenState extends State<TestsScreen> {
  late Future<List<QuantitativeTest>> _futureTests;

  @override
  void initState() {
    super.initState();
    _futureTests = FirebaseTestService().loadTests('full_all_tests.json');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuantitativeTest>>(
      future: _futureTests,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Помилка: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Немає доступних тестів'));
        }

        final tests = snapshot.data!;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: tests.length,
          itemBuilder: (context, index) {
            final test = tests[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(test.title),
                subtitle: Text(test.description),
                onTap: () {
                  // TODO: перехід до екрану проходження тесту
                },
              ),
            );
          },
        );
      },
    );
  }
}
