import 'package:movies/data/models/actor_model.dart';
import 'package:movies/data/models/movies_detail_model.dart';
import 'package:movies/data/models/movies_model.dart';

import '../../data/models/movie_videos.dart';

abstract class IMoviesRepository {
  Future<MoviesResult> getTopRatedMovies();

  Future<MoviesResult> getUpcomingMovies();

  Future<MoviesResult> getPopularMovies();

  Future<MovieDetailsPage> getMovieDetails({required int movieId});

  Future<List<MovieVideos>> getMovieVideos({required int movieId});

  Future<List<ActorModel>> fetchMovieActor({required int movieId});

  Future<MoviesResult> searchMovies({
    required String keyword,
    required int page,
  });
}
