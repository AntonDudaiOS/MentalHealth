import 'package:my_mental_health_app/core/models/test_model.dart';

abstract class TestDetailEvent {}

class StartTest extends TestDetailEvent {
  final QuantitativeTest test;
  StartTest(this.test);
}

class AnswerSelected extends TestDetailEvent {
  final int questionIndex;
  final int selectedValue;
  AnswerSelected(this.questionIndex, this.selectedValue);
}

class SubmitTest extends TestDetailEvent {}
