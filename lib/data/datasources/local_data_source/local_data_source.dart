import 'package:movies/core/hive_storage_provider.dart';
import 'package:movies/data/models/movies_model.dart';
import 'package:movies/domain/repositories/i_local_movie_repositories.dart';

class LocalDataSource implements ILocalMovieRepository {
  final HiveStorage _hiveStorage = HiveStorage();

  @override
  Future<Result> getPreviousSearchMovies() async {
    Result data = await _hiveStorage.getPreviousSearchMovies();
    return data;
  }

  @override
  Future<void> cacheData(Result data) async {
    await _hiveStorage.setPreviousSearchMovies(data);
  }
}
