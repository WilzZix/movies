import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/application/actors/actors_bloc.dart';
import 'package:movies/application/blocs/movies_bloc.dart';
import 'package:movies/core/network_provider.dart';
import 'package:movies/presentation/pages/home_page/home_page.dart';
import 'package:movies/routes/go_router/go_router.dart';

void main() {
  NetworkProvider.initApp();
  Bloc.observer = MyGlobalObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MoviesBloc()..add(GetTopRatedMoviesEvent()),
        ),
        BlocProvider(
          create: (context) => ActorsBloc(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
        theme: ThemeData(),
      ),
    );
  }
}

class MyGlobalObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('${bloc.runtimeType} $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}
