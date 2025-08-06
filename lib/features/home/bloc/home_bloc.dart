import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import 'package:my_mental_health_app/core/services/test_results_service.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final TestResultService testResultService;

  HomeBloc({required this.testResultService}) : super(const HomeState()) {
    on<LoadTestResults>(_onLoadTestResults);
  }

  Future<void> _onLoadTestResults(
    LoadTestResults event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final results = await testResultService.getLatestResults();
      emit(state.copyWith(
        isLoading: false,
        testResults: results,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Помилка завантаження результатів: $e',
      ));
    }
  }
}
