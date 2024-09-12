part of 'movies_bloc.dart';

@immutable
sealed class MoviesState {}

final class MoviesInitial extends MoviesState {}

///Top rated Movies
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

///Popular movies
class PopularMoviesLoadingState extends MoviesState {}

class PopularMoviesLoadedState extends MoviesState {
  final MoviesResult data;

  PopularMoviesLoadedState(this.data);
}

class PopularMoviesLoadErrorState extends MoviesState {
  final String msg;

  PopularMoviesLoadErrorState(this.msg);
}

///Movies Details
class MovieDetailsLoadingState extends MoviesState {}

class MovieDetailsLoadedState extends MoviesState {
  final MovieDetailsPage data;

  MovieDetailsLoadedState(this.data);
}

class MoviesDetailsLoadingErrorState extends MoviesState {
  final String msg;

  MoviesDetailsLoadingErrorState(this.msg);
}