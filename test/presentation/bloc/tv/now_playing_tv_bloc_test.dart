
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv/get_now_playing_tv.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing/bloc/now_playing_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTv])
void main() {
  late MockGetNowPlayingTv mockGetNowPlayingTv;
  late NowPlayingTvBloc tvBloc;

  setUp(() {
    mockGetNowPlayingTv = MockGetNowPlayingTv();
    tvBloc = NowPlayingTvBloc(mockGetNowPlayingTv);
  });

  test('initial state should be empty', () {
    expect(tvBloc.state, NowPlayingTvEmpty());
  });

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'emit loading and hasData when data success',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvEvent()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTv.execute());
      return OnNowPlayingTvEvent().props;
    },
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    ' emit loading and error when data unsuccessful',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async =>  Left(ServerFailure('Server Failure')));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvEvent()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingTvLoading(),
  );

  blocTest<NowPlayingTvBloc, NowPlayingTvState>(
    'emit loading and empty when data empty',
    build: () {
      when(mockGetNowPlayingTv.execute())
          .thenAnswer((_) async => const Right([]));
      return tvBloc;
    },
    act: (bloc) => bloc.add(OnNowPlayingTvEvent()),
    expect: () => [
      NowPlayingTvLoading(),
      NowPlayingTvEmpty(),
    ],
  );
}