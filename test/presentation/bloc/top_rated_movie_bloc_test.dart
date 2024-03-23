import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/bloc/top_rated_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../dummy_data/dummy_objects.dart';
import 'top_rated_movie_bloc_test.mocks.dart';


@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMovieBloc movieBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  test('initial state should be empty', () {
    expect(movieBloc.state, TopRatedMovieEmpty());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'emit loading and hasdata when data is success',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(OnTopRatedMovieEvent()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieHasData(testMovieList),
    ],
    verify: (blocAct) {
      verify(mockGetTopRatedMovies.execute());
      return OnTopRatedMovieEvent().props;
    },
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'emit loading and error when data is unsuccess',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(OnTopRatedMovieEvent()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieError('Server Failure'),
    ],
    verify: (blocAct) => TopRatedMovieLoading(),
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'emit loading and empty when data is empty',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return movieBloc;
    },
    act: (blocAct) => blocAct.add(OnTopRatedMovieEvent()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieEmpty(),
    ],
  );
}