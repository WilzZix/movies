part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

///Popular Movies
class TopRatedMoviesLoadingState extends MoviesState {}

class TopRatedMoviesLoadedState extends MoviesState {
  final MoviesResult data;

  TopRatedMoviesLoadedState(this.data);
}

class TopRatedMoviesLoadingErrorState extends MoviesState {
  final String msg;

  TopRatedMoviesLoadingErrorState(this.msg);
}

///Upcoming movies
class UpcomingMoviesLoadingState extends MoviesState {}

class UpcomingMoviesLoadedState extends MoviesState {
  final MoviesResult data;

  UpcomingMoviesLoadedState(this.data);
}

class UpcomingMoviesLoadError extends MoviesState {
  final String msg;

  UpcomingMoviesLoadError(this.msg);
}
