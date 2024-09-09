import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies/data/datasources/network_data_source/network_movies_datasource.dart';
import 'package:movies/data/models/movies_model.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial()) {
    on<GetPopularMoviesEvent>(_getPopularMovies);
  }

  NetworkMoviesDataSource dataSource = NetworkMoviesDataSource();

  FutureOr<void> _getPopularMovies(
      GetPopularMoviesEvent event, Emitter<MoviesState> emit) async {
    emit(PopularMoviesLoadingState());
    try {
      final result = await dataSource.getTopMovies();
      emit(PopularMoviesLoadedState(result));
    } catch (e) {
      emit(PopularMoviesLoadingErrorState(e.toString()));
    }
  }
}
