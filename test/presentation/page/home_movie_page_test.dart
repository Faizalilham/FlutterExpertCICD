import 'package:ditonton/presentation/bloc/movie/now_playing/bloc/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular/bloc/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/bloc/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_page_helper.dart';

void main() {
  late FakeMovieListBloc fakeMovieListBloc;
  late FakePopularMovieBloc fakeMoviePopularBloc;
  late FakeTopRatedMovieBloc fakeMovieTopBloc;

  setUp(() {
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());
    fakeMovieListBloc = FakeMovieListBloc();

    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
    fakeMoviePopularBloc = FakePopularMovieBloc();

    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());
    fakeMovieTopBloc = FakeTopRatedMovieBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget _createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
          create: (context) => fakeMovieListBloc,
        ),
        BlocProvider<PopularMovieBloc>(
          create: (context) => fakeMoviePopularBloc,
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (context) => fakeMovieTopBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(NowPlayingMovieLoading());
    when(() => fakeMoviePopularBloc.state).thenReturn(PopularMovieLoading());
    when(() => fakeMovieTopBloc.state).thenReturn(TopRatedMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_createTestableWidget( HomeMoviePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets('Page should display listview tvlist when hasdata',
      (tester) async {
    when(() => fakeMovieListBloc.state)
        .thenReturn(NowPlayingMovieHasData(testMovieList));
    when(() => fakeMoviePopularBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));
    when(() => fakeMovieTopBloc.state)
        .thenReturn(TopRatedMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);
    final tvListFinder = find.byType(MovieList);

    await tester.pumpWidget(_createTestableWidget( HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
    expect(tvListFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(NowPlayingMovieError('error'));
    when(() => fakeMoviePopularBloc.state)
        .thenReturn(PopularMovieError('error'));
    when(() => fakeMovieTopBloc.state).thenReturn(TopRatedMovieError('error'));

    await tester.pumpWidget(_createTestableWidget( HomeMoviePage()));

    expect(find.byKey(const Key('error_message')), findsNWidgets(3));
  });

  testWidgets('Page should display empty text when empty', (tester) async {
    when(() => fakeMovieListBloc.state).thenReturn(NowPlayingMovieEmpty());
    when(() => fakeMoviePopularBloc.state).thenReturn(PopularMovieEmpty());
    when(() => fakeMovieTopBloc.state).thenReturn(TopRatedMovieEmpty());

    await tester.pumpWidget(_createTestableWidget( HomeMoviePage()));

    expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  });
}