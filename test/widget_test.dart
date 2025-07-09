import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:my_mental_health_app/main.dart';
import 'package:my_mental_health_app/bloc/app/app_bloc.dart';
import 'package:my_mental_health_app/bloc/app/app_event.dart';
import 'package:my_mental_health_app/bloc/app/app_state.dart';

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

void main() {
  late MockAppBloc mockAppBloc;

  setUp(() {
    mockAppBloc = MockAppBloc();

    when(() => mockAppBloc.state).thenReturn(
      const AppState(status: AppStatus.showOnboarding),
    );

    whenListen(
      mockAppBloc,
      Stream<AppState>.value(const AppState(status: AppStatus.showOnboarding)),
    );
  });

  testWidgets('Show onboardin if first launch', (tester) async {
    await tester.pumpWidget(
      BlocProvider<AppBloc>.value(
        value: mockAppBloc,
        child: const MaterialApp(
          home: MyApp(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("Welcome!"), findsOneWidget);
  });
}
