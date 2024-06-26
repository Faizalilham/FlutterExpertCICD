import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

abstract class TvRepository{


  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id);

  Future<Either<Failure, List<Tv>>> searchTv(String query);

  Future<Either<Failure, String>> saveWatchlist(TvDetail tvSeries);

  Future<Either<Failure, String>> removeWatchlist(TvDetail movie);

  Future<Either<Failure, TvDetail>> getTvDetail(int id);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<Tv>>> getWatchlistTv();

  Future<Either<Failure, List<Tv>>> getNowPlayingTv();

  Future<Either<Failure, List<Tv>>> getTopRatedTv();

  Future<Either<Failure, List<Tv>>> getPopularTv();
}

