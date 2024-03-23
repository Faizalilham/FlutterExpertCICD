import 'package:ditonton/domain/entities/tv/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvSeasonModel extends Equatable {
 
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
   final String? airDate;
  final int episodeCount;

  TvSeasonModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.airDate,
    required this.episodeCount,
  });

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) => TvSeasonModel(
       
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
        airDate: json["air_date"],
        episodeCount: json["episode_count"],
      );

  Map<String, dynamic> toJson() => {
        
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "season_number": seasonNumber,
        "air_date": airDate,
        "episode_count": episodeCount,
      };

  TvSeason toEntity() {
    return TvSeason(
     
      id: id,
      name: name,
      overview: overview,
      posterPath: posterPath,
      seasonNumber: seasonNumber,
      airDate: airDate,
      episodeCount: episodeCount,
    );
  }

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
