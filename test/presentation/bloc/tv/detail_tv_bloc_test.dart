
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv/get_tv_recommendation.dart';
import 'package:ditonton/presentation/bloc/tv/detail/bloc/detail_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
])
void main() {
  late MockGetTvDetail mockGetTvDetail;
  late DetailTvBloc tvBloc;

  const tId = 1;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvBloc = DetailTvBloc(mockGetTvDetail);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, DetailTvEmpty());
  });

   blocTest<DetailTvBloc, DetailTvState>(
    'when data success emit loading and hasData state',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async =>  Right(tTvDetail));
      return tvBloc;
    },
    act: (blocAct) => blocAct.add(OnDetailTvEvent(tId)),
    expect: () => [
      DetailTvLoading(),
      DetailTvHasData(tTvDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
      return OnDetailTvEvent(tId).props;
    },
  );

  blocTest<DetailTvBloc, DetailTvState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (blocAct) => blocAct.add(OnDetailTvEvent(tId)),
    expect: () => [
      DetailTvLoading(),
      DetailTvError('Server Failure'),
    ],
    verify: (blocAct) => DetailTvLoading(),
  );
}