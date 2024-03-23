part of 'recomendation_movie_bloc.dart';

abstract class RecomendationMovieEvent extends Equatable {}

class OnRecomendationMovieEvent extends RecomendationMovieEvent {
  final int id;

  OnRecomendationMovieEvent(this.id);

  @override
  List<Object> get props => [id];
}
