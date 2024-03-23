// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:equatable/equatable.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvDetail _getDetailTv;

  DetailTvBloc(this._getDetailTv) : super(DetailTvEmpty()) {
    on<OnDetailTvEvent>(_onDetailTvEvent);
  }

  Future<void> _onDetailTvEvent(
      OnDetailTvEvent event, Emitter<DetailTvState> state) async {
    final id = event.id;
    emit(DetailTvLoading());

    final result = await _getDetailTv.execute(id);

    result.fold(
      (failure) {
        emit(DetailTvError(failure.message));
      },
      (detail) {
        emit(DetailTvHasData(detail));
      },
    );
  }
}
