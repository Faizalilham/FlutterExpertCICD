part of 'detail_tv_bloc.dart';

abstract class DetailTvState extends Equatable {
  const DetailTvState();
  @override
  List<Object> get props => [];

}

class DetailTvLoading extends DetailTvState {
  @override
  List<Object> get props => [];
}

class DetailTvError extends DetailTvState {
  final String message;

  DetailTvError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTvHasData extends DetailTvState {
  final TvDetail result;

  DetailTvHasData(this.result);
  
  @override
  List<Object> get props => [result];
}

class DetailTvEmpty extends DetailTvState {
  @override
  List<Object> get props => [];
}
