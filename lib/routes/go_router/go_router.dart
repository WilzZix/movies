import 'package:go_router/go_router.dart';
import 'package:movies/presentation/pages/home_page/home_page.dart';
import 'package:movies/presentation/pages/movie_detail_page/movie_detail_page.dart';

class AppRouter {
  AppRouter();

  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const BottomNavigationPage(),
        routes: [
          GoRoute(
            path: MovieDetailPage.tag,
            name: MovieDetailPage.tag,
            builder: (_, state) => MovieDetailPage(
              movieId: state.extra as int,
            ),
          )
        ],
      ),
    ],
  );
}
