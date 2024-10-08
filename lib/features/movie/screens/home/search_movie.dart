import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/features/movie/provider/movies/search_movie.dart';
import 'package:github_tmdb/widgets/grid/movie_grid.dart';

class SearchScreen extends SearchDelegate<MovieModel> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<SearchMovieProvider>().getSearchMovie(context, query);
      });
    }
    return Consumer<SearchMovieProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: value.searchMovies.isNotEmpty
              ? TMovieGrid(
                  movies: value.searchMovies,
                  height: 150,
                  isSearch: true,
                )
              : const Center(
                  child: Text('No Movie Found'),
                ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
