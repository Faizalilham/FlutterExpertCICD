// ignore_for_file: override_on_non_overriding_member

part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {}

class NowPlayingMovieLoading extends NowPlayingMovieState {
  @override
  List<Object> get props => [];
}

class NowPlayingMovieError extends NowPlayingMovieState {
  final String message;

  NowPlayingMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMovieHasData extends NowPlayingMovieState {
  final List<Movie> result;

  NowPlayingMovieHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class NowPlayingMovieEmpty extends NowPlayingMovieState {
  @override
  List<Object> get props => [];
}
