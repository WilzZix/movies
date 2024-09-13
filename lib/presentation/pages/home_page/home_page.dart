import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies/application/blocs/movies_bloc.dart';
import 'package:movies/presentation/pages/favourite_page/favourite_page.dart';
import 'package:movies/presentation/pages/home_page/components/movie_list_item.dart';
import 'package:movies/presentation/pages/home_page/components/popular_movie_item.dart';
import 'package:movies/presentation/pages/home_page/components/see_all_movies_widget.dart';
import 'package:movies/presentation/pages/movie_detail_page/movie_detail_page.dart';
import 'package:movies/presentation/pages/search_page/search_page.dart';
import 'package:movies/presentation/pages/settings_page/settings_page.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    super.key,
  });

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MoviesBloc>(context).add(GetUpcomingMoviesEvent());
    BlocProvider.of<MoviesBloc>(context).add(GetPopularMoviesEvent());
  }

  List<Widget> screens = [
    const HomePage(),
    const SearchPage(),
    const FavouritePage(),
    const SettingsPage(),
  ];
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          selectedItem = value;
          setState(() {});
        },
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.home_outlined,
              size: 35,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.search,
              size: 35,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.list,
              size: 35,
              color: Colors.white,
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.settings,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedItem,
        children: screens,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(MovieDetailPage.tag,
                                  extra: state.data.results![index].id);
                            },
                            child: MovieListItem(
                              moviesResult: state.data.results![index],
                            ),
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
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(MovieDetailPage.tag,
                                  extra: state.data.results![index].id);
                            },
                            child: MovieListItem(
                              moviesResult: state.data.results![index],
                            ),
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
