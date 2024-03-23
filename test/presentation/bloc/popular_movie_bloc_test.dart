
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/movie/popular/bloc/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc movieBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    movieBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('initial state should be empty', () {
    expect(movieBloc.state, PopularMovieEmpty());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emit loading and hasdata when data is success',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(OnPopularMovieEvent()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieHasData(testMovieList),
    ],
    verify: (blocAct) {
      verify(mockGetPopularMovies.execute());
      return OnPopularMovieEvent().props;
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emit loading and error when get data unsuccess',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(OnPopularMovieEvent()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieError('Server Failure'),
    ],
    verify: (blocAct) => PopularMovieLoading(),
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'emit loading and empty when data is empty',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(OnPopularMovieEvent()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieEmpty(),
    ],
  );
}