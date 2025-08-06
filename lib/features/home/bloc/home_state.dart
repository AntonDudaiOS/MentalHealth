import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final List<Map<String, dynamic>> testResults;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.testResults = const [],
    this.errorMessage,
  });

  HomeState copyWith({
    bool? isLoading,
    List<Map<String, dynamic>>? testResults,
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
