part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class GetTopRatedMoviesEvent extends MoviesEvent {}

class GetUpcomingMoviesEvent extends MoviesEvent {}
