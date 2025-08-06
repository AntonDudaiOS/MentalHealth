import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_result_model.g.dart';

@JsonSerializable()
class TestResultModel {
  final String testId;
  final String testTitle;
  final String category;
  final int score;
  final String resultDescription;
  @TimestampConverter()
  final DateTime timestamp;

  TestResultModel({
    required this.testId,
    required this.testTitle,
    required this.category,
    required this.score,
    required this.resultDescription,
    required this.timestamp,
  });

  factory TestResultModel.fromJson(Map<String, dynamic> json) =>
      _$TestResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$TestResultModelToJson(this);

  factory TestResultModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TestResultModel.fromJson(data);
  }
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
