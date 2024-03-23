part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {}

class WatchlistMovieInitial extends WatchlistMovieState {
  @override
  List<Object> get props => [];
}

class WatchlistMovieEmpty extends WatchlistMovieState {
  @override
  List<Object> get props => [];
}

class WatchlistMovieLoading extends WatchlistMovieState {
  @override
  List<Object> get props => [];
}

class WatchlistMovieError extends WatchlistMovieState {
  final String message;

  WatchlistMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieHasData extends WatchlistMovieState {
  final List<Movie> result;

  WatchlistMovieHasData(this.result);

  @override
  List<Object> get props => [result];
}

class MovieIsAddedToWatchlist extends WatchlistMovieState {
  final bool isAdded;

  MovieIsAddedToWatchlist(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class WatchlistMovieMessage extends WatchlistMovieState {
  final String message;

  WatchlistMovieMessage(this.message);

  @override
  List<Object> get props => [message];
}
