import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/movie_list_response.dart';
import '../providers/movie_list_provider.dart';

class MovieListScreen extends ConsumerWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(movieListDataProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movie List'),
        ),
        body: data.when(
            data: (movieData) {
              return showList(movieData);
            },
            error: (err, s) {
              print('Error--> $err');
              return Text(err.toString());
            },
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                )));
  }

  Widget showList(MovieListResponse data) => ListView.separated(
      shrinkWrap: true,
      itemCount: data.items!.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Image.network('https://image.tmdb.org/t/p/w500/${data.items![index].backdropPath}' ?? ''),
          title: Text(data.items![index].title ?? 'No title'),
          subtitle: Text(data.items![index].overview ?? 'No overview'),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 5,
          ));
}
