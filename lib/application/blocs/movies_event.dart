part of 'movies_bloc.dart';

@immutable
sealed class MoviesEvent {}

class GetPopularMoviesEvent extends MoviesEvent{}
