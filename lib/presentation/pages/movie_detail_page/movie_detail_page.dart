import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/application/blocs/movies_bloc.dart';
import 'package:movies/core/utils/extensions.dart';
import 'package:movies/presentation/pages/home_page/components/add_to_watch_list_widget.dart';
import 'package:movies/presentation/pages/home_page/components/genre_builder.dart';

import '../home_page/components/text_container_widget.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movieId});

  static const String tag = 'movie-detail-page';
  final int movieId;

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context)
        .add(GetMovieDetailsEvent(widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text(
          'Movie Details',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is MovieDetailsLoadedState) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500${state.data.backdropPath}',
                        ),
                      ),
                    ),
                    child: const Center(
                      child: Icon(Icons.play_circle_outline),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: 100,
                    height: 20,
                    child: ListView.builder(
                      itemCount: state.data.genres!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        return GenreBuilder(
                          genreId: state.data.genres![index].id!,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    state.data.originalTitle!,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      TextContainerWidget(
                        title: !state.data.adult! ? '17+' : 'GP',
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      TextContainerWidget(
                        title: state.data.releaseDate!.formatedYearOfDateTime(),
                      ),
                      const SizedBox(height: 32)
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    state.data.overview!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(
                        6,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Add to watchlist',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Overall Rating',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('8',style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 8,
                          ),
                          StarRatingWidget()
                        ],
                      ),
                      VerticalDivider(
                        color: Colors.white,
                      ),
                      Column(
                        children: [
                          Text('Overall Rating',style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 8,
                          ),
                          Text('8',style: TextStyle(color: Colors.white)),
                          SizedBox(
                            height: 8,
                          ),
                          StarRatingWidget()
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class StarRatingWidget extends StatelessWidget {
  const StarRatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        SizedBox(
          width: 4,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        SizedBox(
          width: 4,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        SizedBox(
          width: 4,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        SizedBox(
          width: 4,
        ),
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        SizedBox(
          width: 4,
        ),
      ],
    );
  }
}
