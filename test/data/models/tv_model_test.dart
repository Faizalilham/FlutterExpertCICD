
import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    final tTv = Tv(
    posterPath: 'posterPath',
    popularity: 2.3,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );

  final tTvModel = TvModel(
    posterPath: 'posterPath',
    popularity: 2.3,
    id: 1,
    backdropPath: 'backdropPath',
    voteAverage: 8.1,
    overview: 'overview',
    firstAirDate: 'firstAirDate',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'originalLanguage',
    voteCount: 123,
    name: 'name',
    originalName: 'originalName',
  );


  test('should be a subclass of TV Series entity', () {
    final result = tTvModel.toEntity();
    expect(result, tTv);
  });
}