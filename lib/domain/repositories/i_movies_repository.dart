import 'package:movies/data/models/actor_model.dart';
import 'package:movies/data/models/movies_detail_model.dart';
import 'package:movies/data/models/movies_model.dart';

abstract class IMoviesRepository {
  Future<MoviesResult> getTopRatedMovies();

  Future<MoviesResult> getUpcomingMovies();

  Future<MoviesResult> getPopularMovies();

  Future<MovieDetailsPage> getMovieDetails({required int movieId});

  Future<List<ActorModel>> fetchMovieActor({required int movieId});

  Future<MoviesResult> searchMovies({
    required String keyword,
    required int page,
  });
}
