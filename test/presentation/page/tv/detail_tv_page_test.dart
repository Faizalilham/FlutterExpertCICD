import 'package:ditonton/presentation/bloc/tv/detail/bloc/detail_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/recommendation/bloc/recommendation_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/pages/tv/detail_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../helpers/test_page_helper.dart';

void main() {
  late FakeTvDetailBloc fakeTvBloc;
  late FakeTvWatchlistBloc fakeWatchlistBloc;
  late FakeTvRecommendatioBloc fakeRecommendationBloc;

  setUpAll(() {
    registerFallbackValue(FakeTvDetailEvent());
    registerFallbackValue(FakeTvDetailState());
    fakeTvBloc = FakeTvDetailBloc();

    registerFallbackValue(FakeTvWatchlistEvent());
    registerFallbackValue(FakeTvWatchlistState());
    fakeWatchlistBloc = FakeTvWatchlistBloc();

    registerFallbackValue(FakeTvRecommendationEvent());
    registerFallbackValue(FakeTvRecommendatioState());
    fakeRecommendationBloc = FakeTvRecommendatioBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvBloc>(
          create: (context) => fakeTvBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<RecomendationTvBloc>(
          create: (context) => fakeRecommendationBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget _makeAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailTvBloc>(
          create: (context) => fakeTvBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (context) => fakeWatchlistBloc,
        ),
        BlocProvider<RecomendationTvBloc>(
          create: (context) => fakeRecommendationBloc,
        ),
      ],
      child: body,
    );
  }

  // ignore: unused_local_variable
  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHome(),
    '/next': (context) =>
        _makeAnotherTestableWidget(DetailTvPage(id: 1)),
    DetailTvPage.ROUTE_NAME: (context) => const FakeDestination(),
  };

  testWidgets('should show circular progress when TV detail is loading',
      (tester) async {
    when(() => fakeTvBloc.state).thenReturn(DetailTvLoading());
    when(() => fakeRecommendationBloc.state).thenReturn(RecomendationTvLoading());
    when(() => fakeWatchlistBloc.state)
        .thenReturn(TvIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(DetailTvPage(id: tTvDetail.id)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show error message progress when TV detail is error',
      (tester) async {
    when(() => fakeTvBloc.state).thenReturn(DetailTvError('error'));
    when(() => fakeRecommendationBloc.state).thenReturn(RecomendationTvLoading());
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(DetailTvPage(id: tTvDetail.id)));

    expect(find.byKey(const Key('error_message')), findsOneWidget);
  });

  testWidgets('should show empty message progress when TV detail is empty',
      (tester) async {
    when(() => fakeTvBloc.state).thenReturn(DetailTvEmpty());
    when(() => fakeRecommendationBloc.state).thenReturn(RecomendationTvLoading());
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    await tester.pumpWidget(
        _makeTestableWidget(DetailTvPage(id: tTvDetail.id)));

    expect(find.byKey(const Key('empty_message')), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when TV not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeTvBloc.state).thenReturn(DetailTvHasData(tTvDetail));
    when(() => fakeRecommendationBloc.state).thenReturn(RecomendationTvHasData(testTvList));
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
        _makeTestableWidget(DetailTvPage(id: tTvDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when TV is added to wathclist',
      (WidgetTester tester) async {
    when(() => fakeTvBloc.state).thenReturn(DetailTvHasData(tTvDetail));
    when(() => fakeRecommendationBloc.state).thenReturn(RecomendationTvHasData(testTvList));
    when(() => fakeWatchlistBloc.state).thenReturn(TvIsAddedToWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(
        _makeTestableWidget(DetailTvPage(id: tTvDetail.id)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}

class FakeHome extends StatelessWidget {
  const FakeHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const Key('fakeHome'),
        onTap: () {
          Navigator.pushNamed(context, '/next');
        },
      ),
      appBar: AppBar(
        title: const Text('fakeHome'),
        leading: const Icon(Icons.menu),
      ),
    );
  }
}

class FakeDestination extends StatelessWidget {
  const FakeDestination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        key: const Key('fakeDestination'),
        onTap: () {
          Navigator.pop(context);
        },
        title: const Text('fake Destination'),
        leading: const Icon(Icons.check),
      ),
    );
  }
}