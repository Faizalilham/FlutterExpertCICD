// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc
    extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;

  TopRatedMovieBloc(this._getTopRatedMovies)
      : super(TopRatedMovieEmpty()) {
    on<OnTopRatedMovieEvent>(_onTopRatedMovieEvent);
  }

  Future<void> _onTopRatedMovieEvent(
      OnTopRatedMovieEvent event, Emitter<TopRatedMovieState> state) async {
    emit(TopRatedMovieLoading());

    final result = await _getTopRatedMovies.execute();

    result.fold(
      (failure) {
        emit(TopRatedMovieError(failure.message));
      },
      (toRated) {
        if (toRated.isEmpty) {
          emit(TopRatedMovieEmpty());
        } else {
          emit(TopRatedMovieHasData(toRated));
        }
      },
    );
  }
}