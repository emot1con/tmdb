import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/provider/favorite/favorite_movie_provider.dart';
import 'package:github_tmdb/widgets/grid/movie_grid.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
    const FavoriteScreen({super.key});
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<FavoriteMovieProvider>().getAllFavoriteMovies();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoriteMovieProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading || provider.favoriteMovies == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: provider.favoriteMovies!.length,
            itemBuilder: (context, index) {
              final movie = provider.favoriteMovies![index];
              return ListTile(
                title: Text('Movie ID: ${movie.movieId}'),
                subtitle: Text('Poster: ${movie.poster}'),
              );
            },
          );
        },
      ),
    );
  }
}
