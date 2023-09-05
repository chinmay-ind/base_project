import 'package:base_project/data/movie_list_response.dart';
import 'package:base_project/services/api_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/api_path.dart';

class MyRepo {
  var apiProvider = ApiProvider();
  Future<MovieListResponse> getMovieList() async {
    var response = await apiProvider.getRequest(endpoint: 'list/10402?$apiKey');
    return MovieListResponse.fromJson(response);
  }

}

final repoProvider = Provider<MyRepo>((ref) => MyRepo());
