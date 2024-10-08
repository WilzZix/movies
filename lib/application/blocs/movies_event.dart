part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class GetTopRatedMoviesEvent extends MoviesEvent {}

class GetUpcomingMoviesEvent extends MoviesEvent {}

class GetPopularMoviesEvent extends MoviesEvent {}

class GetMovieDetailsEvent extends MoviesEvent {
  final int movieId;

  GetMovieDetailsEvent(this.movieId);
}

///Search movie
class SearchMovieEvent extends MoviesEvent {
  final String keyword;

  SearchMovieEvent(this.keyword);
}

class EddMovieToPreviousSearchResult extends MoviesEvent {
  final Result searchedMovie;

  EddMovieToPreviousSearchResult(this.searchedMovie);
}

class GetPreviousSearchResult extends MoviesEvent {}

///Load more
class LoadMoreEvent extends MoviesEvent {}
