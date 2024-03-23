// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:equatable/equatable.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularTvBloc
    extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv _getPopularTvs;

  PopularTvBloc(this._getPopularTvs)
      : super(PopularTvEmpty()) {
    on<OnPopularTvEvent>(_onPopularTvEvent);
  }

  Future<void> _onPopularTvEvent(
      OnPopularTvEvent event, Emitter<PopularTvState> state) async {
    emit(PopularTvLoading());

    final result = await _getPopularTvs.execute();

    result.fold(
      (failure) {
        emit(PopularTvError(failure.message));
      },
      (popular) {
        if (popular.isEmpty) {
          emit(PopularTvEmpty());
        } else {
          emit(PopularTvHasData(popular));
        }
      },
    );
  }
}
