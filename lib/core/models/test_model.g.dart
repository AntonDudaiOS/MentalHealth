// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuantitativeTest _$QuantitativeTestFromJson(Map<String, dynamic> json) =>
    QuantitativeTest(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      answerScale: (json['answerScale'] as List<dynamic>)
          .map((e) => AnswerScaleItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      resultDescriptions: (json['resultDescriptions'] as List<dynamic>)
          .map((e) => ResultDescription.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuantitativeTestToJson(QuantitativeTest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'category': instance.category,
      'description': instance.description,
      'questions': instance.questions,
      'answerScale': instance.answerScale,
      'resultDescriptions': instance.resultDescriptions,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
  text: json['text'] as String,
  min: (json['min'] as num).toInt(),
  max: (json['max'] as num).toInt(),
  reverse: json['reverse'] as bool? ?? false,
);

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
  'text': instance.text,
  'min': instance.min,
  'max': instance.max,
  'reverse': instance.reverse,
};

AnswerScaleItem _$AnswerScaleItemFromJson(Map<String, dynamic> json) =>
    AnswerScaleItem(
      value: (json['value'] as num).toInt(),
      label: json['label'] as String,
    );

Map<String, dynamic> _$AnswerScaleItemToJson(AnswerScaleItem instance) =>
    <String, dynamic>{'value': instance.value, 'label': instance.label};

ResultDescription _$ResultDescriptionFromJson(Map<String, dynamic> json) =>
    ResultDescription(
      minScore: (json['minScore'] as num).toInt(),
      maxScore: (json['maxScore'] as num).toInt(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$ResultDescriptionToJson(ResultDescription instance) =>
    <String, dynamic>{
      'minScore': instance.minScore,
      'maxScore': instance.maxScore,
      'description': instance.description,
    };
