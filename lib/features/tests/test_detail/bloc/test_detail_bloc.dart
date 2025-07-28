import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/core/models/test_model.dart';
import 'test_detail_event.dart';
import 'test_detail_state.dart';

class TestDetailBloc extends Bloc<TestDetailEvent, TestDetailState> {
  TestDetailBloc() : super(TestDetailInitial()) {
    on<StartTest>(_onStart);
    on<AnswerSelected>(_onAnswerSelected);
    on<SubmitTest>(_onSubmit);
  }

  void _onStart(StartTest event, Emitter<TestDetailState> emit) {
    emit(TestDetailInProgress(test: event.test, answers: {}));
  }

  void _onAnswerSelected(AnswerSelected event, Emitter<TestDetailState> emit) {
    final currentState = state;
    if (currentState is TestDetailInProgress) {
      final updatedAnswers = Map<int, int>.from(currentState.answers)
        ..[event.questionIndex] = event.selectedValue;

      emit(TestDetailInProgress(test: currentState.test, answers: updatedAnswers));
    }
  }

  void _onSubmit(SubmitTest event, Emitter<TestDetailState> emit) {
    final currentState = state;
    if (currentState is TestDetailInProgress) {
      int total = 0;
      final test = currentState.test;

      for (int i = 0; i < test.questions.length; i++) {
        final answer = currentState.answers[i];
        final question = test.questions[i];

        if (answer != null) {
          final score = question.reverse ? (question.max - answer) : answer;
          total += score;
        }
      }

      final result = test.resultDescriptions.firstWhere(
        (r) => total >= r.minScore && total <= r.maxScore,
        orElse: () => ResultDescription(
          minScore: 0,
          maxScore: 0,
          description: 'Результат не визначено.',
        ),
      );

      emit(TestDetailCompleted(
        test: test,
        answers: currentState.answers,
        totalScore: total,
        result: result,
      ));
    }
  }
}
