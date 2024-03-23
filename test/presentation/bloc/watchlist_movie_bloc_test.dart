import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/bloc/watchlist_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistMovies,
  GetWatchListStatus,
  RemoveWatchlist,
  SaveWatchlist,
])
void main() {
  late MockGetWatchlistMovies getWatchlistMovies;
  late MockGetWatchListStatus getWatchlistStatus;
  late MockRemoveWatchlist removeWatchlist;
  late MockSaveWatchlist saveWatchlist;
  late WatchlistMovieBloc watchlistBloc;

  const watchlistAddSuccessMessage = 'Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  setUp(() {
    getWatchlistMovies = MockGetWatchlistMovies();
    getWatchlistStatus = MockGetWatchListStatus();
    removeWatchlist = MockRemoveWatchlist();
    saveWatchlist = MockSaveWatchlist();
    watchlistBloc = WatchlistMovieBloc(
      getWatchlistMovies,
      getWatchlistStatus,
      removeWatchlist,
      saveWatchlist,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistBloc.state, WatchlistMovieInitial());
  });

  group(
    'this test for get watchlist movies,',
    () {
      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(getWatchlistMovies.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistMovie()),
        expect: () => [
          WatchlistMovieLoading(),
          WatchlistMovieHasData([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(getWatchlistMovies.execute());
          return OnGethWatchlistMovie().props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistMovie()),
        expect: () => [
          WatchlistMovieLoading(),
          WatchlistMovieError('Server Failure'),
        ],
        verify: (bloc) => WatchlistMovieLoading(),
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(getWatchlistMovies.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistMovie()),
        expect: () => [
          WatchlistMovieLoading(),
          WatchlistMovieEmpty(),
        ],
      );
    },
  );

  group(
    'this test for get watchlist status,',
    () {
      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should get true when the watchlist status is true',
        build: () {
          when(getWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testMovieDetail.id)),
        expect: () => [
          MovieIsAddedToWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchlistStatus.execute(testMovieDetail.id));
          return FetchWatchlistStatus(testMovieDetail.id).props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should get false when the watchlist status is false',
        build: () {
          when(getWatchlistStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlistStatus(testMovieDetail.id)),
        expect: () => [
          MovieIsAddedToWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchlistStatus.execute(testMovieDetail.id));
          return FetchWatchlistStatus(testMovieDetail.id).props;
        },
      );
    },
  );

  group(
    'this test for add and remove watchlist,',
    () {
      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should update watchlist status when add watchlist is success',
        build: () {
          when(saveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
        expect: () => [
          WatchlistMovieMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
          return AddMovieToWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should throw failure message status when add watchlist is unsuccessful',
        build: () {
          when(saveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
              Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddMovieToWatchlist(testMovieDetail)),
        expect: () => [
          WatchlistMovieError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveWatchlist.execute(testMovieDetail));
          return AddMovieToWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should update watchlist status when remove watchlist is success',
        build: () {
          when(removeWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
        expect: () => [
          WatchlistMovieMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
          return RemoveMovieFromWatchlist(testMovieDetail).props;
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'should throw failure message status when remove watchlist is unsuccessful',
        build: () {
          when(removeWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
              Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(RemoveMovieFromWatchlist(testMovieDetail)),
        expect: () => [
          WatchlistMovieError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeWatchlist.execute(testMovieDetail));
          return RemoveMovieFromWatchlist(testMovieDetail).props;
        },
      );
    },
  );
}
