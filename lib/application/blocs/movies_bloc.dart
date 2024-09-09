import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movies/data/models/movies_model.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<GetTopRatedMoviesEvent>(_getTopRatedMovies);
    on<GetUpcomingMoviesEvent>(_getUpcomingMovies);
  }

  NetworkMoviesDataSource dataSource = NetworkMoviesDataSource();

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
}
