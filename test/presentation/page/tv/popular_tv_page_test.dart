import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv/popular/bloc/popular_bloc.dart';
import 'package:ditonton/presentation/pages/tv/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_tv.dart';

class MockPopularTvBloc
    extends MockBloc<PopularTvEvent, PopularTvState>
    implements PopularTvBloc {}

class FakePopularTvEvent extends Fake implements PopularTvEvent {}

class FakePopularTvState extends Fake implements PopularTvState {}

void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularTvEvent());
    registerFallbackValue(FakePopularTvState());
  });

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>.value(
      value: mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state)
        .thenReturn(PopularTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state)
        .thenReturn( PopularTvHasData([tTv]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

   testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvBloc.state)
        .thenReturn( PopularTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
} 