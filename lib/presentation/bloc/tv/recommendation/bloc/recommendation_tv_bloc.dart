// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendation.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecomendationTvBloc
    extends Bloc<RecomendationTvEvent, RecomendationTvState> {
  final GetTvRecommendations _getRecomendationTvs;

  RecomendationTvBloc(this._getRecomendationTvs)
      : super(RecomendationTvEmpty()) {
    on<OnRecomendationTvEvent>(_onRecomendationTvEvent);
  }

  Future<void> _onRecomendationTvEvent(OnRecomendationTvEvent event,
      Emitter<RecomendationTvState> state) async {
    final id = event.id;
    emit(RecomendationTvLoading());

    final result = await _getRecomendationTvs.execute(id);

    result.fold(
      (failure) {
        emit(RecomendationTvError(failure.message));
      },
      (recomendation) {
        if (recomendation.isEmpty) {
          emit(RecomendationTvEmpty());
        } else {
          emit(RecomendationTvHasData(recomendation));
        }
      },
    );
  }
}

