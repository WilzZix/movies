import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movies/core/utils/interceptor.dart';

class NetworkProvider {
  static late Dio dio;

  static Future<void> initApp() async {
    dio = Dio(
      BaseOptions(
        baseUrl: IRoutes.baseUrl,
        headers: {
          'Authorization':
              ' Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyNmY2MmM3YmIxNTczNTM0ZjU4MWQwNDdlMjUwNjllOCIsIm5iZiI6MTcyNTY4MDEyMi43MDIyMjIsInN1YiI6IjVmODA5NzBiMDIxY2VlMDAzNTM5ZjQxOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ccmjcAH00ac6jdcsg_IkK3IiG9yrHOSEOh7otuwcScE',
          'accept': 'application-json',
        },
        queryParameters: {'language': 'en-EN', 'page': 1},
      ),
    )..interceptors.addAll(
        [
          DioInterceptor(),
          if (kDebugMode)
            LogInterceptor(
              responseHeader: true,
              responseBody: true,
              requestBody: true,
              logPrint: (error) => log(
                error.toString(),
              ),
            ),
        ],
      );
  }
}

class IRoutes {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String topRated = '/movie/top_rated';
  static const String popularMovies = '/movie/popular';
  static const String upcomingMovies = '/movie/upcoming';
  static const String search = '/search';
}
