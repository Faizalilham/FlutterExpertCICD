// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMovieBloc(this._getNowPlayingMovies)
      : super(NowPlayingMovieEmpty()) {
    on<OnNowPlayingMovieEvent>(_onNowPlayingMovieEvent);
  }

  Future<void> _onNowPlayingMovieEvent(
      OnNowPlayingMovieEvent event, Emitter<NowPlayingMovieState> state) async {
    emit(NowPlayingMovieLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold(
      (failure) {
        emit(NowPlayingMovieError(failure.message));
      },
      (nowPlaying) {
        if (nowPlaying.isEmpty) {
          emit(NowPlayingMovieEmpty());
        } else {
          emit(NowPlayingMovieHasData(nowPlaying));
        }
      },
    );
  }
}
