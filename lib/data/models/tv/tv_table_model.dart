import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class TvTableModel extends Equatable{
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;

  TvTableModel({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
  });

  factory TvTableModel.fromEntity(TvDetail tvSeries) => TvTableModel(
        id: tvSeries.id,
        name: tvSeries.name,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
      );

  factory TvTableModel.fromMap(Map<String, dynamic> map) => TvTableModel(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
      };

  Tv toEntity() => Tv.watchlist(
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
      );

      

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        overview,
      ];
}