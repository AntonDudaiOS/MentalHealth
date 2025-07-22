import 'package:equatable/equatable.dart';
import 'package:my_mental_health_app/core/models/test_model.dart';

abstract class TestListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TestListInitial extends TestListState {}

class TestListLoading extends TestListState {}

class TestListLoaded extends TestListState {
  final List<QuantitativeTest> tests;

  TestListLoaded(this.tests);

  @override
  List<Object?> get props => [tests];
}

class TestListError extends TestListState {
  final String message;

  TestListError(this.message);

  @override
  List<Object?> get props => [message];
}
