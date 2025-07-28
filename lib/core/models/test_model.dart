import 'package:json_annotation/json_annotation.dart';

part 'test_model.g.dart';

@JsonSerializable()
class QuantitativeTest {
  final String id;
  final String title;
  final String category;
  final String description;
  final List<Question> questions;
  final List<AnswerScaleItem> answerScale;
  final List<ResultDescription> resultDescriptions;

  QuantitativeTest({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.questions,
    required this.answerScale,
    required this.resultDescriptions,
  });

  factory QuantitativeTest.fromJson(Map<String, dynamic> json) =>
      _$QuantitativeTestFromJson(json);

  Map<String, dynamic> toJson() => _$QuantitativeTestToJson(this);
}

@JsonSerializable()
class Question {
  final String text;
  final int min;
  final int max;

  @JsonKey(defaultValue: false)
  final bool reverse;

  Question({
    required this.text,
    required this.min,
    required this.max,
    this.reverse = false,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class AnswerScaleItem {
  final int value;
  final String label;

  AnswerScaleItem({
    required this.value,
    required this.label,
  });

  factory AnswerScaleItem.fromJson(Map<String, dynamic> json) =>
      _$AnswerScaleItemFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerScaleItemToJson(this);
}

@JsonSerializable()
class ResultDescription {
  final int minScore;
  final int maxScore;
  final String description;

  ResultDescription({
    required this.minScore,
    required this.maxScore,
    required this.description,
  });

  factory ResultDescription.fromJson(Map<String, dynamic> json) =>
      _$ResultDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$ResultDescriptionToJson(this);
}
