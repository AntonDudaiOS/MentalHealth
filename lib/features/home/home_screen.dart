import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_state.dart';
import 'package:my_mental_health_app/core/models/app_tab.dart';
import 'package:my_mental_health_app/core/models/chart_data.dart';
import 'package:my_mental_health_app/core/services/test_results_service.dart';
import 'package:my_mental_health_app/features/home/bloc/home_bloc.dart';
import 'package:my_mental_health_app/features/home/bloc/home_event.dart';
import 'package:my_mental_health_app/features/home/bloc/home_state.dart';
import 'package:my_mental_health_app/widgets/chart_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        testResultService: context.read<TestResultService>(),
      )..add(LoadTestResults()),
      child: BlocListener<AppBloc, AppState>(
        listenWhen: (prev, curr) =>
            prev.selectedTab != curr.selectedTab &&
            curr.selectedTab == AppTab.home,
        listener: (context, state) {
          context.read<HomeBloc>().add(LoadTestResults());
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final groupedByCategory = <String, List<ChartPoint>>{};
            for (final result in state.testResults) {
              final category = result.category ?? 'Інше';
              groupedByCategory.putIfAbsent(category, () => []).add(
                ChartPoint(
                  score: result.score,
                  timestamp: result.timestamp,
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(16),
              children: groupedByCategory.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        entry.key,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(
                      height: 250,
                      child: TestResultsChartWidget(points: entry.value),
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
