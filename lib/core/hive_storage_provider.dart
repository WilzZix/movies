import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies/data/models/movies_model.dart';

class HiveStorage {
  static final HiveStorage _instance = HiveStorage._internal();

  factory HiveStorage() {
    return _instance;
  }

  HiveStorage._internal();

  late final Box _mainStorage = Hive.box(HiveBoxNameUtils.mainStorage);

  Future<void> setPreviousSearchMovies(MoviesResult result) async {
    await _mainStorage.put('previous_search', result);
  }

  Future<List<MoviesResult>> getPreviousSearchMovies() async {
    return await _mainStorage.get('previous_search');
  }

  Future<void> clearStorage() async => await _mainStorage.clear();
}

class HiveBoxNameUtils {
  const HiveBoxNameUtils._();

  static const String mainStorage = "movie_hive_storage";
}
