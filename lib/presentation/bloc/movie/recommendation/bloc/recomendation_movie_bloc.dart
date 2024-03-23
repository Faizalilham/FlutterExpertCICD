// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'recomendation_movie_event.dart';
part 'recomendation_movie_state.dart';

class RecomendationMovieBloc
    extends Bloc<RecomendationMovieEvent, RecomendationMovieState> {
  final GetMovieRecommendations _getRecomendationMovies;

  RecomendationMovieBloc(this._getRecomendationMovies)
      : super(RecomendationMovieEmpty()) {
    on<OnRecomendationMovieEvent>(_onRecomendationMovieEvent);
  }

  Future<void> _onRecomendationMovieEvent(OnRecomendationMovieEvent event,
      Emitter<RecomendationMovieState> state) async {
    final id = event.id;
    emit(RecomendationMovieLoading());

    final result = await _getRecomendationMovies.execute(id);

    result.fold(
      (failure) {
        emit(RecomendationMovieError(failure.message));
      },
      (recomendation) {
        if (recomendation.isEmpty) {
          emit(RecomendationMovieEmpty());
        } else {
          emit(RecomendationMovieHasData(recomendation));
        }
      },
    );
  }
}
