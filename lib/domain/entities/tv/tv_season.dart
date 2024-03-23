import 'package:equatable/equatable.dart';

class TvSeason extends Equatable {
  
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final String? airDate;
  final int episodeCount;

  TvSeason({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.airDate,
    required this.episodeCount,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        airDate,
        episodeCount,
      ];
}