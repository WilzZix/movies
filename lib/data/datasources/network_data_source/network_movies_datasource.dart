import 'package:dio/dio.dart';
import 'package:movies/core/network_provider.dart';
import 'package:movies/data/models/actor_model.dart';
import 'package:movies/data/models/movie_videos.dart';
import 'package:movies/data/models/movies_detail_model.dart';
import 'package:movies/data/models/movies_model.dart';
import 'package:movies/domain/repositories/i_movies_repository.dart';

import '../../../core/utils/error_to_user_message.dart';

class NetworkMoviesDataSource implements IMoviesRepository {
  @override
  Future<MoviesResult> getTopRatedMovies() async {
    try {
      final Response response = await NetworkProvider.dio.get(IRoutes.topRated);
      return MoviesResult.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<MoviesResult> getUpcomingMovies() async {
    try {
      final Response response =
          await NetworkProvider.dio.get(IRoutes.upcomingMovies);
      return MoviesResult.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<MoviesResult> getPopularMovies() async {
    try {
      final Response response =
          await NetworkProvider.dio.get(IRoutes.popularMovies);
      return MoviesResult.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<MovieDetailsPage> getMovieDetails({required int movieId}) async {
    try {
      final Response response =
          await NetworkProvider.dio.get('/movie/$movieId');
      return MovieDetailsPage.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<List<ActorModel>> fetchMovieActor({required int movieId}) async {
    try {
      final Response response =
          await NetworkProvider.dio.get('/movie/$movieId/credits');
      return ActorModel.fetchData(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<MoviesResult> searchMovies({
    required String keyword,
    required int page,
  }) async {
    try {
      Map<String, dynamic> queryParams = {'page': page};
      final Response response = await NetworkProvider.dio.get(
          '${IRoutes.search}/movie?query=$keyword&include_adult=false',
          queryParameters: queryParams);
      return MoviesResult.fromJson(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }

  @override
  Future<List<MovieVideos>> getMovieVideos({required int movieId}) async {
    try {
      final Response response =
          await NetworkProvider.dio.get('/movie/$movieId/videos');
      return MovieVideos.fetchData(response.data ?? {});
    } on DioExceptions catch (e) {
      throw e.getServerError;
    }
  }
}
