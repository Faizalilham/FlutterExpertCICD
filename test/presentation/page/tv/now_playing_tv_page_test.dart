import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing/bloc/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/now_playing_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_tv.dart';

class MockNowPlayingTvBloc
    extends MockBloc<NowPlayingTvEvent, NowPlayingTvState>
    implements NowPlayingTvBloc {}

class FakeNowPlayingTvEvent extends Fake
    implements NowPlayingTvEvent {}

class FakeNowPlayingTvState extends Fake
    implements NowPlayingTvState {}

void main() {
  late MockNowPlayingTvBloc mockNowPlayingTvBloc;

  setUpAll(() {
    registerFallbackValue(FakeNowPlayingTvEvent());
    registerFallbackValue(FakeNowPlayingTvState());
  });

  setUp(() {
    mockNowPlayingTvBloc = MockNowPlayingTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingTvBloc>.value(
      value: mockNowPlayingTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvBloc.state)
        .thenReturn(NowPlayingTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(NowPlayingTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvBloc.state)
        .thenReturn( NowPlayingTvHasData([tTv]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(NowPlayingTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingTvBloc.state)
        .thenReturn( NowPlayingTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(NowPlayingTvPage()));

    expect(textFinder, findsOneWidget);
  });
}