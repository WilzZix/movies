import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/application/blocs/movies_bloc.dart';
import 'package:movies/core/utils/extensions.dart';
import 'package:movies/presentation/pages/home_page/components/add_to_watch_list_widget.dart';
import 'package:movies/presentation/pages/home_page/components/genre_builder.dart';
import 'package:movies/presentation/pages/home_page/components/text_container_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(searchMovie);
  }

  void searchMovie() {
    if (controller.text.isNotEmpty) {
      BlocProvider.of<MoviesBloc>(context)
          .add(SearchMovieEvent(controller.text));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: false,
        actions: const [
          Icon(
            Icons.manage_search_outlined,
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.black,
        title: const Text(
          'Search',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            backgroundColor: Colors.black,
            title: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: 'Search...',
              ),
            ),
          ),
          BlocBuilder<MoviesBloc, MoviesState>(
            builder: (context, state) {
              if (state is SearchMovieLoadingState) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is SearchMovieLoadedState) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: state.data.results!.length, (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 200,
                            width: 100,
                            child:
                                state.data.results![index].backdropPath != null
                                    ? Image(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          'https://image.tmdb.org/t/p/w500${state.data.results![index].posterPath!}',
                                        ),
                                      )
                                    : null,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 20,
                                child: ListView.builder(
                                  itemCount: state
                                      .data.results![index].genreIds!.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GenreBuilder(
                                      genreId:
                                          state.data.results![index].genreIds!,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                state.data.results![index].originalTitle!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  TextContainerWidget(
                                    title: !state.data.results![index].adult!
                                        ? '17+'
                                        : 'GP',
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  TextContainerWidget(
                                    title: state
                                        .data.results![index].releaseDate!
                                        .formatedYearOfDateTime(),
                                  ),
                                  const SizedBox(height: 32)
                                ],
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        '${state.data.results![index].voteAverage!}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const AddToWatchListWidget()
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }),
                );
              }
              return const SliverToBoxAdapter();
            },
          ),
        ],
      ),
    );
  }
}
