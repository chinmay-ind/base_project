import 'package:base_project/data/movie_list_response.dart';
import 'package:base_project/repository/my_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final movieListDataProvider = FutureProvider<MovieListResponse>((ref) async {
  var response = ref.watch(repoProvider).getMovieList();
    return response;
});
