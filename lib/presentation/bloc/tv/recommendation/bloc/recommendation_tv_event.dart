part of 'recommendation_tv_bloc.dart';


abstract class RecomendationTvEvent extends Equatable {}

class OnRecomendationTvEvent extends RecomendationTvEvent {
  final int id;

  OnRecomendationTvEvent(this.id);

  @override
  List<Object> get props => [id];
}
