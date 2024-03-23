// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc
    extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;

  PopularMovieBloc(this._getPopularMovies)
      : super(PopularMovieEmpty()) {
    on<OnPopularMovieEvent>(_onPopularMovieEvent);
  }

  Future<void> _onPopularMovieEvent(
      OnPopularMovieEvent event, Emitter<PopularMovieState> state) async {
    emit(PopularMovieLoading());

    final result = await _getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(PopularMovieError(failure.message));
      },
      (popular) {
        if (popular.isEmpty) {
          emit(PopularMovieEmpty());
        } else {
          emit(PopularMovieHasData(popular));
        }
      },
    );
  }
}