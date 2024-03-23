// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_tv_event.dart';
part 'now_playing_tv_state.dart';

class NowPlayingTvBloc
    extends Bloc<NowPlayingTvEvent, NowPlayingTvState> {
  final GetNowPlayingTv _getNowPlayingTvs;

  NowPlayingTvBloc(this._getNowPlayingTvs)
      : super(NowPlayingTvEmpty()) {
    on<OnNowPlayingTvEvent>(_onNowPlayingTvEvent);
  }

  Future<void> _onNowPlayingTvEvent(
      OnNowPlayingTvEvent event, Emitter<NowPlayingTvState> state) async {
    emit(NowPlayingTvLoading());

    final result = await _getNowPlayingTvs.execute();

    result.fold(
      (failure) {
        emit(NowPlayingTvError(failure.message));
      },
      (nowPlaying) {
        if (nowPlaying.isEmpty) {
          emit(NowPlayingTvEmpty());
        } else {
          emit(NowPlayingTvHasData(nowPlaying));
        }
      },
    );
  }
}

