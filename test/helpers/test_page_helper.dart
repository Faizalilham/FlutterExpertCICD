import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/presentation/bloc/movie/detail/bloc/detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/bloc/now_playing_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/popular/bloc/popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/recommendation/bloc/recomendation_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/bloc/top_rated_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/detail/bloc/detail_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing/bloc/now_playing_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular/bloc/popular_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/recommendation/bloc/recommendation_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated/bloc/top_rated_tv_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/bloc/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

void main() {
  setUp(() {
    registerFallbackValue(FakeTvListEvent());
    registerFallbackValue(FakeTvListState());
    registerFallbackValue(FakeTvPopularEvent());
    registerFallbackValue(FakeTvPopularState());
    registerFallbackValue(FakeTvTopRatedEvent());
    registerFallbackValue(FakeTvTopRatedState());
    registerFallbackValue(FakeMovieListEvent());
    registerFallbackValue(FakeMovieListState());
    registerFallbackValue(FakePopularMovieEvent());
    registerFallbackValue(FakePopularMovieState());
    registerFallbackValue(FakeTopRatedMovieEvent());
    registerFallbackValue(FakeTopRatedMovieState());
    
    TestWidgetsFlutterBinding.ensureInitialized();
  });
}


class FakeTvListEvent extends Fake implements NowPlayingTvEvent {}
class FakeTvListState extends Fake implements NowPlayingTvState {}
class FakeTvListBloc extends MockBloc<NowPlayingTvEvent, NowPlayingTvState> implements NowPlayingTvBloc {}


class FakeTvPopularEvent extends Fake implements PopularTvEvent {}
class FakeTvPopularState extends Fake implements PopularTvState {}
class FakeTvPopularBloc extends MockBloc<PopularTvEvent, PopularTvState> implements PopularTvBloc {}

class FakeTvTopRatedEvent extends Fake implements TopRatedTvEvent {}
class FakeTvTopRatedState extends Fake implements TopRatedTvState {}
class FakeTvTopRatedBloc extends MockBloc<TopRatedTvEvent, TopRatedTvState> implements TopRatedTvBloc {}

class FakeTvDetailEvent extends Fake implements DetailTvEvent {}
class FakeTvDetailState extends Fake implements DetailTvState {}
class FakeTvDetailBloc extends MockBloc<DetailTvEvent, DetailTvState> implements DetailTvBloc {}

class FakeTvWatchlistEvent extends Fake implements WatchlistTvEvent {}
class FakeTvWatchlistState extends Fake implements WatchlistTvState {}
class FakeTvWatchlistBloc extends MockBloc<WatchlistTvEvent, WatchlistTvState> implements WatchlistTvBloc {}

class FakeTvRecommendationEvent extends Fake implements RecomendationTvEvent {}
class FakeTvRecommendatioState extends Fake implements RecomendationTvState {}
class FakeTvRecommendatioBloc extends MockBloc<RecomendationTvEvent, RecomendationTvState> implements RecomendationTvBloc {}



class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

class FakeTopRatedMoviesEvent extends Fake implements TopRatedMovieEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMovieState {}
class FakeMovieListEvent extends Fake implements NowPlayingMovieEvent {}
class FakeMovieListState extends Fake implements NowPlayingMovieState {}
class FakeMovieListBloc extends MockBloc<NowPlayingMovieEvent, NowPlayingMovieState> implements NowPlayingMovieBloc {}


class FakePopularMovieEvent extends Fake implements PopularMovieEvent {}
class FakePopularMovieState extends Fake implements PopularMovieState {}
class FakePopularMovieBloc extends MockBloc<PopularMovieEvent, PopularMovieState> implements PopularMovieBloc {}


class FakeTopRatedMovieEvent extends Fake implements TopRatedMovieEvent {}
class FakeTopRatedMovieState extends Fake implements TopRatedMovieState {}
class FakeTopRatedMovieBloc extends MockBloc<TopRatedMovieEvent, TopRatedMovieState> implements TopRatedMovieBloc {}

class FakeMovieDetailEvent extends Fake implements DetailMovieEvent {}
class FakeMovieDetailState extends Fake implements DetailMovieState {}
class FakeMovieDetailBloc extends MockBloc<DetailMovieEvent, DetailMovieState> implements DetailMovieBloc {}

class FakeRecommendationMovieEvent extends Fake implements RecomendationMovieEvent {}
class FakeRecommendationMovieState extends Fake implements RecomendationMovieState {}
class FakeRecommendationMovieBloc extends MockBloc<RecomendationMovieEvent, RecomendationMovieState> implements RecomendationMovieBloc {}

class FakeMovieWatchlistEvent extends Fake implements WatchlistMovieEvent {}
class FakeMovieWatchlistState extends Fake implements WatchlistMovieState {}
class FakeMovieWatchlistBloc extends MockBloc<WatchlistMovieEvent, WatchlistMovieState> implements WatchlistMovieBloc {}