import 'package:movies/data/models/movies_model.dart';

abstract class IMoviesRepository {
  Future<MoviesResult> getTopRatedMovies();

  Future<MoviesResult> getUpcomingMovies();
}