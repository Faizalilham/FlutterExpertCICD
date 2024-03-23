import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/tv/tv_table_model.dart';

abstract class TvLocalDataSource {

  Future<TvTableModel?> getTvById(int id);

  Future<String> insertWatchlist(TvTableModel tv);

  Future<String> removeWatchlist(TvTableModel tv);
  
  Future<List<TvTableModel>> getWatchlistTv();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(TvTableModel tv) async {
    try {
      await databaseHelper.insertTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvTableModel tv) async {
    try {
      await databaseHelper.removeWatchlistTv(tv);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTableModel?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);
    if (result != null) {
      return TvTableModel.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvTableModel>> getWatchlistTv() async {
    final result = await databaseHelper.getWatchlistTv();
    return result.map((data) => TvTableModel.fromMap(data)).toList();
  }
}