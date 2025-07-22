import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/features/tests/test_list/bloc/test_list_event.dart';
import 'package:my_mental_health_app/features/tests/test_list/bloc/test_list_state.dart';
import 'package:my_mental_health_app/core/services/firebase_storage_service.dart';

class TestListBloc extends Bloc<TestListEvent, TestListState> {
  final FirebaseTestService testService;

  TestListBloc(this.testService) : super(TestListInitial()) {
    on<LoadTestList>(_onLoadTestList);
  }

  Future<void> _onLoadTestList(LoadTestList event, Emitter<TestListState> emit) async {
    emit(TestListLoading());
    try {
      final tests = await testService.loadTests(event.filePath);
      emit(TestListLoaded(tests));
    } catch (e) {
      emit(TestListError('Помилка при завантаженні тестів: ${e.toString()}'));
    }
  }
}
