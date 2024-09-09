import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/application/blocs/movies_bloc.dart';
import 'package:movies/core/utils/extensions.dart';
import 'package:movies/data/models/movies_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(GetUpcomingMoviesEvent());
    BlocProvider.of<MoviesBloc>(context).add(GetPopularMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        actions: [
          Stack(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  shape: BoxShape.rectangle,
                ),
              ),
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
              )
            ],
          )
        ],
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back',
              style: TextStyle(color: Colors.white),
            ),
            Text(
              'John David.',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (context, state) {
                  return state is PopularMoviesLoadedState;
                },
                builder: (context, state) {
                  if (state is PopularMoviesLoadedState) {
                    return CarouselSlider.builder(
                      itemCount: state.data.results!.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) {
                        return PopularMovieItem(
                          movieResult: state.data.results![itemIndex],
                        );
                      },
                      options: CarouselOptions(
                        height: 200,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  }
                  if (state is PopularMoviesLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  if (state is PopularMoviesLoadErrorState) {
                    return Center(
                      child: Text(
                        state.msg,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              SeeAllMoviesListWidget(
                title: 'Top Movies Pick',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (context, state) {
                  return state is TopRatedMoviesLoadedState;
                },
                builder: (context, state) {
                  if (state is TopRatedMoviesLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  if (state is TopRatedMoviesLoadingErrorState) {
                    return Center(
                      child: Text(
                        state.msg,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  if (state is TopRatedMoviesLoadedState) {
                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        itemCount: state.data.results!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return MovieListItem(
                            moviesResult: state.data.results![index],
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              SeeAllMoviesListWidget(
                title: 'Upcoming Movies',
                onTap: () {},
              ),
              const SizedBox(height: 16),
              BlocBuilder<MoviesBloc, MoviesState>(
                buildWhen: (context, state) {
                  return state is UpcomingMoviesLoadedState;
                },
                builder: (context, state) {
                  if (state is UpcomingMoviesLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  if (state is UpcomingMoviesLoadedState) {
                    return SizedBox(
                      height: 250,
                      child: ListView.builder(
                        itemCount: state.data.results!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return MovieListItem(
                            moviesResult: state.data.results![index],
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PopularMovieItem extends StatelessWidget {
  const PopularMovieItem({
    super.key,
    required this.movieResult,
  });

  final Results movieResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            'https://image.tmdb.org/t/p/w500${movieResult.backdropPath}',
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieRatingWidget(
            ratingPoint: movieResult.voteAverage!.toString(),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movieResult.originalTitle! ?? '',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 100,
                      height: 20,
                      child: ListView.builder(
                        itemCount: movieResult.genreIds!.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return GenreBuilder(
                            genreId: movieResult.genreIds![index],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        TextContainerWidget(
                          title: !movieResult.adult! ? '17+' : 'GP',
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        TextContainerWidget(
                          title:
                              movieResult.releaseDate!.formatedYearOfDateTime(),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                const AddToWatchListWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GenreBuilder extends StatelessWidget {
  const GenreBuilder({
    super.key,
    required this.genreId,
  });

  final int genreId;

  @override
  Widget build(BuildContext context) {
    switch (genreId) {
      case 28:
        return const Text(
          'Action',
          style: TextStyle(color: Colors.white),
        );
      case 12:
        return const Text(
          'Adventure',
          style: TextStyle(color: Colors.white),
        );
      case 16:
        return const Text(
          'Animation',
          style: TextStyle(color: Colors.white),
        );
      case 35:
        return const Text(
          'Comedy',
          style: TextStyle(color: Colors.white),
        );
      case 80:
        return const Text(
          'Crime',
          style: TextStyle(color: Colors.white),
        );
      case 99:
        return const Text(
          'Documentary',
          style: TextStyle(color: Colors.white),
        );
      case 18:
        return const Text(
          'Drama',
          style: TextStyle(color: Colors.white),
        );
      case 10751:
        return const Text(
          'Family',
          style: TextStyle(color: Colors.white),
        );
      case 14:
        return const Text(
          'Fantasy',
          style: TextStyle(color: Colors.white),
        );
      case 36:
        return const Text(
          'History',
          style: TextStyle(color: Colors.white),
        );
      case 27:
        return const Text(
          'Horror',
          style: TextStyle(color: Colors.white),
        );
      case 10402:
        return const Text(
          'Music',
          style: TextStyle(color: Colors.white),
        );
      case 9648:
        return const Text(
          'Mystery',
          style: TextStyle(color: Colors.white),
        );
      case 10749:
        return const Text(
          'Romance',
          style: TextStyle(color: Colors.white),
        );
      case 878:
        return const Text(
          'Science Fiction',
          style: TextStyle(color: Colors.white),
        );
      case 10770:
        return const Text(
          'TV Movie',
          style: TextStyle(color: Colors.white),
        );
      case 53:
        return const Text(
          'Thriller',
          style: TextStyle(color: Colors.white),
        );
      case 10752:
        return const Text(
          'War',
          style: TextStyle(color: Colors.white),
        );
      case 37:
        return const Text(
          'Western',
          style: TextStyle(color: Colors.white),
        );
      default:
        return const SizedBox();
    }
  }
}

class MovieListItem extends StatelessWidget {
  const MovieListItem({
    super.key,
    required this.moviesResult,
  });

  final Results moviesResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: Image.network(
              'https://image.tmdb.org/t/p/w500${moviesResult.backdropPath!}',
              width: 150,
              height: 198,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            moviesResult.originalTitle!,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                moviesResult.releaseDate!.formatedYearOfDateTime(),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 4),
              const Text(
                '·',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 4),
              Text(
                moviesResult.adult! ? "17+" : "PG",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 4),
              const Text(
                '·',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 4),
            ],
          )
        ],
      ),
    );
  }
}

class SeeAllMoviesListWidget extends StatelessWidget {
  const SeeAllMoviesListWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            'See all',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}

class MovieRatingWidget extends StatelessWidget {
  const MovieRatingWidget({
    super.key,
    required this.ratingPoint,
  });

  final String ratingPoint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.all(4.0),
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star,
              color: Colors.white,
              size: 16,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              ratingPoint,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class AddToWatchListWidget extends StatelessWidget {
  const AddToWatchListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(
          6,
        ),
      ),
      child: const Text(
        'Add to watchlist',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class TextContainerWidget extends StatelessWidget {
  const TextContainerWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
