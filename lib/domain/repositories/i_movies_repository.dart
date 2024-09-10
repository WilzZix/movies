import 'package:movies/data/models/movies_detail_model.dart';
import 'package:movies/data/models/movies_model.dart';

abstract class IMoviesRepository {
  Future<MoviesResult> getTopRatedMovies();

  Future<MoviesResult> getUpcomingMovies();

  Future<MoviesResult> getPopularMovies();

  Future<MovieDetailsPage> getMovieDetails({required int movieId});
}
