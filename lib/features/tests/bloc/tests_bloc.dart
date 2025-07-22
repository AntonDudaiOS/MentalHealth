import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_mental_health_app/features/tests/bloc/tests_event.dart';
import 'package:my_mental_health_app/features/tests/bloc/tests_state.dart';
import 'package:my_mental_health_app/core/services/firebase_storage_service.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final FirebaseTestService firebaseTestService;

  TestBloc(this.firebaseTestService) : super(TestInitial()) {
    on<LoadTests>(_onLoadTests);
  }

  Future<void> _onLoadTests(LoadTests event, Emitter<TestState> emit) async {
    emit(TestLoading());

    try {
      final tests = await firebaseTestService.loadTests(event.filePath);
      emit(TestLoaded(tests));
    } catch (e) {
      emit(TestError('Не вдалося завантажити тести: ${e.toString()}'));
    }
  }
}