// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResultModel _$TestResultModelFromJson(Map<String, dynamic> json) =>
    TestResultModel(
      testId: json['testId'] as String,
      testTitle: json['testTitle'] as String,
      category: json['category'] as String,
      score: (json['score'] as num).toInt(),
      resultDescription: json['resultDescription'] as String,
      timestamp: const TimestampConverter().fromJson(
        json['timestamp'] as Timestamp,
      ),
    );

Map<String, dynamic> _$TestResultModelToJson(TestResultModel instance) =>
    <String, dynamic>{
      'testId': instance.testId,
      'testTitle': instance.testTitle,
      'category': instance.category,
      'score': instance.score,
      'resultDescription': instance.resultDescription,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
