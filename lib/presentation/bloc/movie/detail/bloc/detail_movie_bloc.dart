// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getDetailMovies;

  DetailMovieBloc(this._getDetailMovies) : super(DetailMovieEmpty()) {
    on<OnDetailMovieEvent>(_onDetailMovieEvent);
  }

  Future<void> _onDetailMovieEvent(
      OnDetailMovieEvent event, Emitter<DetailMovieState> state) async {
    final id = event.id;
    emit(DetailMovieLoading());

    final result = await _getDetailMovies.execute(id);

    result.fold(
      (failure) {
        emit(DetailMovieError(failure.message));
      },
      (detail) {
        emit(DetailMovieHasData(detail));
      },
    );
  }
}
