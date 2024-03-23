
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_top_rated_tv.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated/bloc/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvBloc tvBloc;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    tvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, TopRatedTvEmpty());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'emit loading and hasData when data success',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvEvent()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTv.execute());
      return OnTopRatedTvEvent().props;
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    ' emit loading and error when data unsuccessful',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvEvent()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvError('Server Failure'),
    ],
    verify: (bloc) => TopRatedTvLoading(),
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedTvEvent()),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvEmpty(),
    ],
  );
}