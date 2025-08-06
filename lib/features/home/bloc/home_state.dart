import 'package:equatable/equatable.dart';
import 'package:my_mental_health_app/core/models/test_result_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<TestResultModel> testResults;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.testResults = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    bool? isLoading,
    List<TestResultModel>? testResults,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      testResults: testResults ?? this.testResults,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, testResults, errorMessage];
}
