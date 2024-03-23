import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv/search/bloc/search_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/search_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_tv.dart';

class MockSearchTvBloc
    extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {}

class FakeSearchTvEvent extends Fake implements SearchTvEvent {}

class FakeSearchTvState extends Fake implements SearchTvState {}

void main() {
  late MockSearchTvBloc mockSearchTvBloc;

  setUpAll(() {
    registerFallbackValue(FakeSearchTvEvent());
    registerFallbackValue(FakeSearchTvState());
  });

  setUp(() {
    mockSearchTvBloc = MockSearchTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvBloc>.value(
      value: mockSearchTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state)
        .thenReturn(SearchTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state)
        .thenReturn( SearchTvHasData([tTv]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state)
        .thenReturn( SearchTvHasData([tTv]));

    final formSearch = find.byType(TextField);
    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

    await tester.enterText(formSearch, 'spiderman');
    await tester.pump();

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display Text when data is empty',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state).thenReturn(SearchTvEmpty());

    final textErrorBarFinder = find.text('Search Not Found');

    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets('Page should display when initial', (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state)
        .thenReturn(SearchTvLoading());

    final textErrorBarFinder = find.byType(Container);

    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

    expect(textErrorBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state)
        .thenReturn( SearchTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

    expect(textFinder, findsOneWidget);
  });
}