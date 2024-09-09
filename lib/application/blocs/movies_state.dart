part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

class PopularMoviesLoadingState extends MoviesState {}

class PopularMoviesLoadedState extends MoviesState {
  final MoviesResult data;

  PopularMoviesLoadedState(this.data);
}

class PopularMoviesLoadingErrorState extends MoviesState {
  final String msg;

  PopularMoviesLoadingErrorState(this.msg);
}
