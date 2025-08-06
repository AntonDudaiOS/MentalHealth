import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_state.dart';
import 'package:my_mental_health_app/core/services/test_results_service.dart';
//import 'package:my_mental_health_app/bloc/app/app_event.dart';
import 'package:my_mental_health_app/features/home/bloc/home_bloc.dart';
import 'package:my_mental_health_app/features/home/bloc/home_event.dart';
import 'package:my_mental_health_app/features/home/bloc/home_state.dart';
import 'package:my_mental_health_app/core/models/app_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        testResultService: context.read<TestResultService>()
      ),
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

            return ListView(
              children: state.testResults
                  .map((e) => ListTile(title: Text(e['testTitle'] ?? 'No name')))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
