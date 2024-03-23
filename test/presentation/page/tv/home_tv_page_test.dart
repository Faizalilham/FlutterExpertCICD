import 'package:ditonton/presentation/bloc/tv/now_playing/bloc/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular/bloc/popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated/bloc/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/tv_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../helpers/test_page_helper.dart';
void main() {
  late FakeTvListBloc fakeTVListBloc;
  late FakeTvPopularBloc fakeTVPopularBloc;
  late FakeTvTopRatedBloc fakeTVTopBloc;

  setUp(() {
    registerFallbackValue(FakeTvListEvent());
    registerFallbackValue(FakeTvListState());
    fakeTVListBloc = FakeTvListBloc();

    registerFallbackValue(FakeTvPopularEvent());
    registerFallbackValue(FakeTvPopularState());
    fakeTVPopularBloc = FakeTvPopularBloc();

    registerFallbackValue(FakeTvWatchlistEvent());
    registerFallbackValue(FakeTvWatchlistState());
    fakeTVTopBloc = FakeTvTopRatedBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingTvBloc>(
          create: (context) => fakeTVListBloc,
        ),
        BlocProvider<PopularTvBloc>(
          create: (context) => fakeTVPopularBloc,
        ),
        BlocProvider<TopRatedTvBloc>(
          create: (context) => fakeTVTopBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeTVListBloc.state)
        .thenReturn(NowPlayingTvLoading());
    when(() => fakeTVPopularBloc.state)
        .thenReturn(PopularTvLoading());
    when(() => fakeTVTopBloc.state).thenReturn(TopRatedTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget(const TvListPage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview tvlist when hasdata',
      (tester) async {
    when(() => fakeTVListBloc.state)
        .thenReturn(NowPlayingTvHasData(testTvList));
    when(() => fakeTVPopularBloc.state)
        .thenReturn(PopularTvHasData(testTvList));
    when(() => fakeTVTopBloc.state)
        .thenReturn(TopRatedTvHasData(testTvList));

    final listViewFinder = find.byType(ListView);
    final tvListFinder = find.byType(TvList);

    await tester.pumpWidget(_createTestableWidget(const TvListPage()));

    expect(listViewFinder, findsNWidgets(3));
    expect(tvListFinder, findsNWidgets(3));
  });
}