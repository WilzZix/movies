import 'package:movies/data/models/movies_model.dart';

abstract class ILocalMovieRepository {
  Future<List<MoviesResult>?> getPreviousSearchMovies();

  Future<void> cacheData(MoviesResult data);
}
