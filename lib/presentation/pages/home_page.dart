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
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://img.freepik.com/free-psd/interior-design-landing-page-template_23-2148663724.jpg?w=1380&t=st=1725283615~exp=1725284215~hmac=bdfcbae6fea688c789a3f7322eae28ba6fda82e8d9f9066067eff271d06dedf7',
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const MovieRatingWidget(
                      ratingPoint: '8,7',
                    ),
                    const Spacer(),
                    Container(
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
                      child: const Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Oppenheimer',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'History Thriller Drama Mystery',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  TextContainerWidget(
                                    title: '17+',
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  TextContainerWidget(
                                    title: '2023',
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  TextContainerWidget(
                                    title: '3 hours',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 32,
                          ),
                          AddToWatchListWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
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
                buildWhen: (context,state){
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
