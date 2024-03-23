import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_wachlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/tv/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/tv/save_watchlist_tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc
    extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetWatchlistTv _getWatchlistTvs;
  final GetWatchListStatusTv _getWatchlistStatus;
  final RemoveWatchlistTv _removeWatchlist;
  final SaveWatchlistTv _saveWatchlist;

  WatchlistTvBloc(
    this._getWatchlistTvs,
    this._getWatchlistStatus,
    this._removeWatchlist,
    this._saveWatchlist,
  ) : super(WatchlistTvInitial()) {
    on<OnGethWatchlistTv>(_onFetchTvWatchlist);
    on<FetchWatchTvlistStatus>(_fetchWatchlistStatus);
    on<AddTvToWatchlist>(_addTvToWatchlist);
    on<RemoveTvFromWatchlist>(_removeTvFromWatchlist);
  }

  Future<void> _onFetchTvWatchlist(
    OnGethWatchlistTv event,
    Emitter<WatchlistTvState> emit,
  ) async {
    emit(WatchlistTvLoading());

    final result = await _getWatchlistTvs.execute();

    result.fold(
      (failure) {
        emit(WatchlistTvError(failure.message));
      },
      (data) {
        data.isEmpty
            ? emit(WatchlistTvEmpty())
            : emit(WatchlistTvHasData(data));
      },
    );
  }

  Future<void> _fetchWatchlistStatus(
    FetchWatchTvlistStatus event,
    Emitter<WatchlistTvState> emit,
  ) async {
    final id = event.id;

    final result = await _getWatchlistStatus.execute(id);

    emit(TvIsAddedToWatchlist(result));
  }

  Future<void> _addTvToWatchlist(
    AddTvToWatchlist event,
    Emitter<WatchlistTvState> emit,
  ) async {
    final tv = event.tv;

    final result = await _saveWatchlist.execute(tv);

    result.fold(
      (failure) {
        emit(WatchlistTvError(failure.message));
      },
      (message) {
        emit(WatchlistTvMessage(message));
      },
    );
  }

  Future<void> _removeTvFromWatchlist(
    RemoveTvFromWatchlist event,
    Emitter<WatchlistTvState> emit,
  ) async {
    final tv = event.tv;

    final result = await _removeWatchlist.execute(tv);

    result.fold(
      (failure) {
        emit(WatchlistTvError(failure.message));
      },
      (message) {
        emit(WatchlistTvMessage(message));
      },
    );
  }
}
