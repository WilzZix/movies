import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:movies/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movies/data/models/movies_detail_model.dart';
import 'package:movies/data/models/movies_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
    on<GetUpcomingMoviesEvent>(_getUpcomingMovies);
    on<GetPopularMoviesEvent>(_getPopularMovies);
    on<GetMovieDetailsEvent>(_getMovieDetails);
    on<SearchMovieEvent>(_searchMovie);
    on<LoadMoreEvent>(_loadMore);
    on<GetPreviousSearchResult>(_getPreviousSearchResult);
    on<EddMovieToPreviousSearchResult>(
        _addSearchResultMovieToPreviousSearchResult);
  }

  NetworkMoviesDataSource dataSource = NetworkMoviesDataSource();

  int page = 1;
  String keyword = '';
  List<Result>? results = [];

  FutureOr<void> _getTopRatedMovies(
      GetTopRatedMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(TopRatedMoviesLoadingState());
    try {
      final result = await dataSource.getTopRatedMovies();
      emit(TopRatedMoviesLoadedState(result));
    } catch (e) {
      emit(TopRatedMoviesLoadingErrorState(e.toString()));
    }
  }

  FutureOr<void> _getUpcomingMovies(
      GetUpcomingMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(UpcomingMoviesLoadingState());
    try {
      final result = await dataSource.getUpcomingMovies();
      emit(UpcomingMoviesLoadedState(result));
    } catch (e) {
      emit(UpcomingMoviesLoadError(e.toString()));
    }
  }

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(PopularMoviesLoadingState());
    try {
      final result = await dataSource.getPopularMovies();
      emit(PopularMoviesLoadedState(result));
    } catch (e) {
      emit(PopularMoviesLoadErrorState(e.toString()));
    }
  }

  FutureOr<void> _getMovieDetails(
      GetMovieDetailsEvent event, Emitter<MoviesState> emit) async {
    emit(MovieDetailsLoadingState());
    try {
      final result = await dataSource.getMovieDetails(movieId: event.movieId);
      emit(MovieDetailsLoadedState(result));
    } catch (e) {
      emit(MoviesDetailsLoadingErrorState(e.toString()));
    }
  }

  FutureOr<void> _searchMovie(
      SearchMovieEvent event, Emitter<MoviesState> emit) async {
    results!.clear();
    emit(SearchMovieLoadingState());
    try {
      keyword = event.keyword;
      final result = await dataSource.searchMovies(
        keyword: event.keyword,
        page: page,
      );
      results!.addAll(result.results!);
      emit(SearchMovieLoadedState(MoviesResult(results: results)));
    } catch (e) {
      emit(SearchMovieLoadErrorState(e.toString()));
    }
  }

  FutureOr<void> _loadMore(
      LoadMoreEvent event, Emitter<MoviesState> emit) async {
    final result = await dataSource.searchMovies(
      keyword: keyword,
      page: ++page,
    );
    results!.addAll(result.results!);
    emit(SearchMovieLoadedState(MoviesResult(results: results)));
  }

  FutureOr<void> _getPreviousSearchResult(
      GetPreviousSearchResult event, Emitter<MoviesState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? movieJsonList =
        prefs.getStringList('movie_results')!.reversed.toList();

    emit(LastSearchedMovieLoadedState(movieJsonList
        .map((movieJson) => Result.fromJson(jsonDecode(movieJson)))
        .toList()));
  }

  Future<void> _addSearchResultMovieToPreviousSearchResult(
      EddMovieToPreviousSearchResult event, Emitter<MoviesState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String> movieJsonList = prefs.getStringList('movie_results') ?? [];
      movieJsonList.add(jsonEncode(event.searchedMovie.toJson()));
      await prefs.setStringList('movie_results', movieJsonList);
    } catch (e) {
      log(e.toString());
    }
  }
}
