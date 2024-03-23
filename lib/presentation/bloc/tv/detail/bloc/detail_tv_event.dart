part of 'detail_tv_bloc.dart';

abstract class DetailTvEvent extends Equatable {}

class OnDetailTvEvent extends DetailTvEvent {
  final int id;

  OnDetailTvEvent(this.id);

  @override
  List<Object> get props => [id];
}
