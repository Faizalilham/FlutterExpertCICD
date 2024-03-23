
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_popular_tv.dart';
import 'package:ditonton/presentation/bloc/tv/popular/bloc/popular_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc tvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    tvBloc = PopularTvBloc(mockGetPopularTv);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, PopularTvEmpty());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'emit loading and hasData when data success',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvEvent()),
    expect: () => [
      PopularTvLoading(),
      PopularTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
      return OnPopularTvEvent().props;
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    ' emit loading and error when data unsuccessful',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvEvent()),
    expect: () => [
      PopularTvLoading(),
      PopularTvError('Server Failure'),
    ],
    verify: (bloc) => PopularTvLoading(),
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnPopularTvEvent()),
    expect: () => [
      PopularTvLoading(),
      PopularTvEmpty(),
    ],
  );
}