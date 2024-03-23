part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {}

class OnGethWatchlistMovie extends WatchlistMovieEvent {
  @override
  List<Object> get props => [];
}

class FetchWatchlistStatus extends WatchlistMovieEvent {
  final int id;

  FetchWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
class AddMovieToWatchlist extends WatchlistMovieEvent {
  final MovieDetail movie;

  AddMovieToWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}

class RemoveMovieFromWatchlist extends WatchlistMovieEvent {
  final MovieDetail movie;

  RemoveMovieFromWatchlist(this.movie);

  @override
  List<Object> get props => [movie];
}
