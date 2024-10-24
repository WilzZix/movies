import 'package:go_router/go_router.dart';
import 'package:movies/presentation/pages/auth_page/auth_page.dart';
import 'package:movies/presentation/pages/auth_page/register_page.dart';
import 'package:movies/presentation/pages/auth_page/web_auth_page.dart';
import 'package:movies/presentation/pages/home_page/home_page.dart';
import 'package:movies/presentation/pages/movie_detail_page/movie_detail_page.dart';
import 'package:movies/presentation/tablet/home_page.dart';

class AppRouter {
  AppRouter();

  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: BottomNavigationPage.tag,
        path: BottomNavigationPage.tag,
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
      GoRoute(
        path: AuthPage.tag,
        name: AuthPage.tag,
        builder: (_, __) => const AuthPage(),
      ),
      GoRoute(
        path: RegisterPage.tag,
        name: RegisterPage.tag,
        builder: (_, __) => const RegisterPage(),
      ),
      GoRoute(
        path: OAuthExample.tag,
        name: OAuthExample.tag,
        builder: (_, __) => OAuthExample(),
      )
    ],
  );

  final tabletRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: TabletHomePage.tag,
        name: TabletHomePage.tag,
        builder: (_, __) => const TabletHomePage(),
      )
    ],
  );
}
