
import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvsModel = TvModel(
    posterPath: '/path.jpg',
    popularity: 2.3,
    id: 1,
    backdropPath: '/path.jpg',
    voteAverage: 8.0,
    overview: 'Overview',
    firstAirDate: '2022-10-10',
    originCountry: ['en', 'id'],
    genreIds: [1, 2, 3],
    originalLanguage: 'Original Language',
    voteCount: 230,
    name: 'Name',
    originalName: 'Original Name',
  );

  final tTvsResponseModel =
      TvResponse(tvList: <TvModel>[tTvsModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvsResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange
      final expectedJsonMap = {
        "results": [
          {
            "poster_path": "/path.jpg",
            "popularity": 2.3,
            "id": 1,
            "backdrop_path": "/path.jpg",
            "vote_average": 8.0,
            "overview": "Overview",
            "first_air_date": "2022-10-10",
            "origin_country": ["en", "id"],
            "genre_ids": [1, 2, 3],
            "original_language": "Original Language",
            "vote_count": 230,
            "name": "Name",
            "original_name": "Original Name"
          }
        ],
      };
      // act
      final result = tTvsResponseModel.toJson();
      // assert
      expect(result, expectedJsonMap);
    });
  });
}