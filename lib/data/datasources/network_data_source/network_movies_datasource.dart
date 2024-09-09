import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:movies/core/network_provider.dart';
import 'package:movies/data/models/movies_model.dart';
import 'package:movies/domain/repositories/i_movies_repository.dart';

class NetworkMoviesDataSource implements IMoviesRepository {
  @override
  Future<MoviesResult> getTopMovies() async {
    final Response response =
        await NetworkProvider.dio.get(IRoutes.popularMovies);
    return MoviesResult.fromJson(response.data ?? {});
  }
}
