part of 'popular_bloc.dart';

abstract class PopularTvState extends Equatable {}

class PopularTvLoading extends PopularTvState {
  @override
  List<Object> get props => [];
}

class PopularTvError extends PopularTvState {
  final String message;

  PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvHasData extends PopularTvState {
  final List<Tv> result;

  PopularTvHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class PopularTvEmpty extends PopularTvState {
  @override
  List<Object> get props => [];
}

