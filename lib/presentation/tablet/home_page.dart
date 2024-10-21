import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/application/blocs/movies_bloc.dart';
import 'package:movies/core/utils/colors.dart';
import 'package:movies/presentation/pages/home_page/components/genre_builder.dart';

class TabletHomePage extends StatefulWidget {
  const TabletHomePage({super.key});

  static String tag = '/';

  @override
  State<TabletHomePage> createState() => _TabletHomePageState();
}

class _TabletHomePageState extends State<TabletHomePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(GetPopularMoviesEvent());
    BlocProvider.of<MoviesBloc>(context).add(GetTopRatedMoviesEvent());
    BlocProvider.of<MoviesBloc>(context).add(GetUpcomingMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: size.width / 4,
            color: AppColors.tabletBackground,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      label: Icon(Icons.search),
                      hintText: 'Search Movies',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.tabletCardColor,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            SizedBox(
                              width: 8,
                            ),
                            Text('Top Movies Pick'),
                          ],
                        ),
                        BlocBuilder<MoviesBloc, MoviesState>(
                          buildWhen: (context, state) {
                            return state is TopRatedMoviesLoadedState;
                          },
                          builder: (context, state) {
                            if (state is TopRatedMoviesLoadedState) {
                              return SizedBox(
                                height: 400,
                                child: ListView.builder(
                                  itemCount: state.data.results!.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      height: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500${state.data.results![index].backdropPath}')),
                                        borderRadius: BorderRadius.circular(16),
                                        color: AppColors.tabletCardColor,
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              bottomRight: Radius.circular(16),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  state.data.results![index]
                                                      .originalTitle!,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                const Spacer(),
                                                const Icon(
                                                  Icons.play_circle,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.tabletCardColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Upcoming Movies'),
                        BlocBuilder<MoviesBloc, MoviesState>(
                          buildWhen: (context,state){
                            return state is UpcomingMoviesLoadedState;
                          },
                          builder: (context, state) {
                            if (state is UpcomingMoviesLoadedState) {
                              return SizedBox(
                                height: 348,
                                child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      height: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                'https://image.tmdb.org/t/p/w500${state.data.results![index].backdropPath}')),
                                        borderRadius: BorderRadius.circular(16),
                                        color: AppColors.tabletCardColor,
                                      ),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              bottomLeft: Radius.circular(16),
                                              bottomRight: Radius.circular(16),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  state.data.results![index]
                                                      .originalTitle!,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                const Spacer(),
                                                const Icon(
                                                  Icons.play_circle,
                                                  color: Colors.white,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: (size.width) * 3 / 4,
            color: AppColors.tabletBackground,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: AppColors.tabletHeaderColor,
                            ),
                            child: const Text(
                              'Movies',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.tabletHeaderColor,
                            ),
                            child: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(32),
                              color: const Color(0xFF868584),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nodir Barotov',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      '@nodirbek_barotov',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<MoviesBloc, MoviesState>(
                    buildWhen: (context, state) {
                      return state is PopularMoviesLoadedState;
                    },
                    builder: (context, state) {
                      if (state is PopularMoviesLoadedState) {
                        return CarouselSlider.builder(
                          itemCount: state.data.results!.length,
                          options: CarouselOptions(
                            height: 450,
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
                          itemBuilder:
                              (BuildContext context, int index, int realIndex) {
                            return Container(
                              height: 450,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500${state.data.results![index].backdropPath}',
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),
                                    GenreBuilder(
                                        genreId: state
                                            .data.results![index].genreIds!),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      state.data.results![index].title!,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 36),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      state.data.results![index].originalTitle!,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.play_arrow,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text('Watch')
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 32,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            border:
                                                Border.all(color: Colors.white),
                                          ),
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.file_download_outlined,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Text(
                                                'Download',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 32,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.white),
                                          ),
                                          child: const Icon(
                                            Icons.more_horiz,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.white),
                                          ),
                                          child: const Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 32,
                                            vertical: 16,
                                          ),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.white),
                                          ),
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      const Text(
                        'You might like',
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'See all',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
