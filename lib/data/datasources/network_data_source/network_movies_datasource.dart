import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies/core/network_provider.dart';
import 'package:movies/data/models/movies_model.dart';
import 'package:movies/domain/repositories/i_movies_repository.dart';

class NetworkMoviesDataSource implements IMoviesRepository {
  @override
  Future<MoviesResult> getTopRatedMovies() async {
    final Response response =
        await NetworkProvider.dio.get(IRoutes.topRated);
    return MoviesResult.fromJson(response.data ?? {});
  }

  @override
  Future<MoviesResult> getUpcomingMovies() async {
    final Response response =
        await NetworkProvider.dio.get(IRoutes.upcomingMovies);
    return MoviesResult.fromJson(response.data ?? {});
  }
}
