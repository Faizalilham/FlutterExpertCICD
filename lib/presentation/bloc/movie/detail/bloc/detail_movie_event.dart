part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {}

class OnDetailMovieEvent extends DetailMovieEvent {
  final int id;

  OnDetailMovieEvent(this.id);

  @override
  List<Object> get props => [id];
}
