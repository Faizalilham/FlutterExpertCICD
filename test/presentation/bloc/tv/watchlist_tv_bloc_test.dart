import 'package:bloc_test/bloc_test.dart';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_wachlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/bloc/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTv,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv,
])
void main() {
  const watchlistAddSuccessMessage = 'Successfully Added to Watchlist';
  const watchlistRemoveSuccessMessage = 'Successfully Removed from Watchlist';

  late MockGetWatchlistTv getWatchlistTv;
  late MockGetWatchListStatusTv getWatchlistTvStatus;
  late MockSaveWatchlistTv saveTvWatchList;
  late MockRemoveWatchlistTv removeTvWatchlist;
  late WatchlistTvBloc watchlistBloc;

  setUp(() {
    getWatchlistTv = MockGetWatchlistTv();
    getWatchlistTvStatus = MockGetWatchListStatusTv();
    saveTvWatchList = MockSaveWatchlistTv();
    removeTvWatchlist = MockRemoveWatchlistTv();
    watchlistBloc = WatchlistTvBloc(
      getWatchlistTv,
      getWatchlistTvStatus,
      removeTvWatchlist,
      saveTvWatchList,
    );
  });

  test('initial state should be initial state', () {
    expect(watchlistBloc.state, WatchlistTvInitial());
  });

  group(
    'this test for get watchlist tv , ',
    () {
      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should emit [Loading, HasData] when watchlist data is gotten succesfully',
        build: () {
          when(getWatchlistTv.execute())
              .thenAnswer((_) async => Right([tWatchlistTv]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistTv()),
        expect: () => [
          WatchlistTvLoading(),
          WatchlistTvHasData([tWatchlistTv]),
        ],
        verify: (bloc) {
          verify(getWatchlistTv.execute());
          return OnGethWatchlistTv().props;
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should emit [Loading, Error] when watchlist data is unsuccessful',
        build: () {
          when(getWatchlistTv.execute()).thenAnswer(
              (_) async =>  Left(ServerFailure('Server Failure')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistTv()),
        expect: () => [
          WatchlistTvLoading(),
          WatchlistTvError('Server Failure'),
        ],
        verify: (bloc) => WatchlistTvLoading(),
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should emit [Loading, Empty] when get watchlist data is empty',
        build: () {
          when(getWatchlistTv.execute())
              .thenAnswer((_) async => const Right([]));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(OnGethWatchlistTv()),
        expect: () => [
          WatchlistTvLoading(),
          WatchlistTvEmpty(),
        ],
      );
    },
  );

  group(
    'this test for get tv  watchlist status,',
    () {
      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should get true when the watchlist status is true',
        build: () {
          when(getWatchlistTvStatus.execute(tTvDetail.id))
              .thenAnswer((_) async => true);
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(FetchWatchTvlistStatus(tTvDetail.id)),
        expect: () => [
          TvIsAddedToWatchlist(true),
        ],
        verify: (bloc) {
          verify(getWatchlistTvStatus.execute(tTvDetail.id));
          return FetchWatchTvlistStatus(tTvDetail.id).props;
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should get false when the watchlist status is false',
        build: () {
          when(getWatchlistTvStatus.execute(tTvDetail.id))
              .thenAnswer((_) async => false);
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(FetchWatchTvlistStatus(tTvDetail.id)),
        expect: () => [
          TvIsAddedToWatchlist(false),
        ],
        verify: (bloc) {
          verify(getWatchlistTvStatus.execute(tTvDetail.id));
          return FetchWatchTvlistStatus(tTvDetail.id).props;
        },
      );
    },
  );

  group(
    'this test for add and remove tv  watchlist,',
    () {
      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should update watchlist status when add watchlist is success',
        build: () {
          when(saveTvWatchList.execute(tTvDetail))
              .thenAnswer((_) async => const Right(watchlistAddSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddTvToWatchlist(tTvDetail)),
        expect: () => [
          WatchlistTvMessage(watchlistAddSuccessMessage),
        ],
        verify: (bloc) {
          verify(saveTvWatchList.execute(tTvDetail));
          return AddTvToWatchlist(tTvDetail).props;
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should throw failure message status when add watchlist is unsuccessful',
        build: () {
          when(saveTvWatchList.execute(tTvDetail)).thenAnswer(
              (_) async =>
                   Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(AddTvToWatchlist(tTvDetail)),
        expect: () => [
          WatchlistTvError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(saveTvWatchList.execute(tTvDetail));
          return AddTvToWatchlist(tTvDetail).props;
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should update watchlist status when remove watchlist is success',
        build: () {
          when(removeTvWatchlist.execute(tTvDetail)).thenAnswer(
              (_) async => const Right(watchlistRemoveSuccessMessage));
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(RemoveTvFromWatchlist(tTvDetail)),
        expect: () => [
          WatchlistTvMessage(watchlistRemoveSuccessMessage),
        ],
        verify: (bloc) {
          verify(removeTvWatchlist.execute(tTvDetail));
          return RemoveTvFromWatchlist(tTvDetail).props;
        },
      );

      blocTest<WatchlistTvBloc, WatchlistTvState>(
        'should throw failure message status when remove watchlist is unsuccessful',
        build: () {
          when(removeTvWatchlist.execute(tTvDetail)).thenAnswer(
              (_) async =>
                  Left(DatabaseFailure('cannot add data to watchlist')));
          return watchlistBloc;
        },
        act: (bloc) =>
            bloc.add(RemoveTvFromWatchlist(tTvDetail)),
        expect: () => [
          WatchlistTvError('cannot add data to watchlist'),
        ],
        verify: (bloc) {
          verify(removeTvWatchlist.execute(tTvDetail));
          return RemoveTvFromWatchlist(tTvDetail).props;
        },
      );
    },
  );
}
