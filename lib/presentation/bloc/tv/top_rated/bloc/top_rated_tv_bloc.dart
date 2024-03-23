// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc
    extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv _getTopRatedTvs;

  TopRatedTvBloc(this._getTopRatedTvs)
      : super(TopRatedTvEmpty()) {
    on<OnTopRatedTvEvent>(_onTopRatedTvEvent);
  }

  Future<void> _onTopRatedTvEvent(OnTopRatedTvEvent event,
      Emitter<TopRatedTvState> state) async {
    emit(TopRatedTvLoading());

    final result = await _getTopRatedTvs.execute();

    result.fold(
      (failure) {
        emit(TopRatedTvError(failure.message));
      },
      (toRated) {
        if (toRated.isEmpty) {
          emit(TopRatedTvEmpty());
        } else {
          emit(TopRatedTvHasData(toRated));
        }
      },
    );
  }
}

