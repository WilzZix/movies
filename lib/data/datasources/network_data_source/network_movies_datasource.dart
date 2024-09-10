import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies/core/network_provider.dart';
import 'package:movies/data/models/movies_detail_model.dart';
import 'package:movies/data/models/movies_model.dart';
import 'package:movies/domain/repositories/i_movies_repository.dart';

class NetworkMoviesDataSource implements IMoviesRepository {
  @override
  Future<MoviesResult> getTopRatedMovies() async {
    final Response response = await NetworkProvider.dio.get(IRoutes.topRated);
    return MoviesResult.fromJson(response.data ?? {});
  }

  @override
  Future<MoviesResult> getUpcomingMovies() async {
    final Response response =
        await NetworkProvider.dio.get(IRoutes.upcomingMovies);
    return MoviesResult.fromJson(response.data ?? {});
  }

  @override
  Future<MoviesResult> getPopularMovies() async {
    final Response response =
        await NetworkProvider.dio.get(IRoutes.popularMovies);
    return MoviesResult.fromJson(response.data ?? {});
  }

  @override
  Future<MovieDetailsPage> getMovieDetails({required int movieId}) async {
    final Response response = await NetworkProvider.dio.get('/$movieId');
    return MovieDetailsPage.fromJson(response.data ?? {});
  }
}
