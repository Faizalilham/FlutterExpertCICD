part of 'recommendation_tv_bloc.dart';

abstract class RecomendationTvState extends Equatable {
  const RecomendationTvState();
  @override
  List<Object> get props => [];

}

class RecomendationTvLoading extends RecomendationTvState {
  @override
  List<Object> get props => [];
}

class RecomendationTvError extends RecomendationTvState {
  final String message;

  RecomendationTvError(this.message);

  @override
  List<Object> get props => [message];
}

class RecomendationTvHasData extends RecomendationTvState {
  final List<Tv> result;

  RecomendationTvHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class RecomendationTvEmpty extends RecomendationTvState {
  @override
  List<Object> get props => [];
}
