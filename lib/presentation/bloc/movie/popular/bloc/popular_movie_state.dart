// ignore_for_file: override_on_non_overriding_member

part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {}

class PopularMovieLoading extends PopularMovieState {
  @override
  List<Object> get props => [];
}

class PopularMovieError extends PopularMovieState {
  final String message;

  PopularMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMovieHasData extends PopularMovieState {
  final List<Movie> result;

  PopularMovieHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class PopularMovieEmpty extends PopularMovieState {
  @override
  List<Object> get props => [];
}
