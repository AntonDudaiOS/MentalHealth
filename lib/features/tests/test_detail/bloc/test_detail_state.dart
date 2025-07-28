import 'package:equatable/equatable.dart';
import 'package:my_mental_health_app/core/models/test_model.dart';

abstract class TestDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TestDetailInitial extends TestDetailState {}

class TestDetailInProgress extends TestDetailState {
  final QuantitativeTest test;
  final Map<int, int> answers;

  TestDetailInProgress({required this.test, required this.answers});

  @override
  List<Object?> get props => [test, answers];
}

class TestDetailCompleted extends TestDetailState {
  final QuantitativeTest test;
  final Map<int, int> answers;
  final int totalScore;
  final ResultDescription result;

  TestDetailCompleted({
    required this.test,
    required this.answers,
    required this.totalScore,
    required this.result,
  });

  @override
  List<Object?> get props => [test, answers, totalScore, result];
}
