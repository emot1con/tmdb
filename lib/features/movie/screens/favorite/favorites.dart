import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/features/movie/provider/favorite/favorite_movie_provider.dart';
import 'package:github_tmdb/features/movie/screens/detail/detail.dart';
import 'package:github_tmdb/features/movie/screens/favorite/widgets/favorite_item_widget.dart';
import 'package:github_tmdb/widgets/grid/movie_grid.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(TSizes.defaultSpace - 10,
            TSizes.defaultSpace - 10, TSizes.defaultSpace - 10, 0),
        child: Consumer<FavoriteMovieProvider>(
          builder: (context, provider, child) {
            if (provider.favoriteMovies == null) {
              return const Center(
                child: Text("There's No Favorite Movie Here"),
              );
            }
            if (provider.favoriteMovies!.isEmpty) {
              return const Center(
                child: Text("There's No Favorite Movie Here"),
              );
            }
            if (provider.isLoading) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: const TShimmer(
                      height: 180,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: 5,
              );
            }
            return ListView.separated(
              itemCount: provider.favoriteMovies!.length,
              itemBuilder: (context, index) {
                final movie = provider.favoriteMovies![index];
                return InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailMovie(movieId: movie.movieId),
                    ),
                  ),
                  child: FavoriteItemWidget(movie: movie),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 10,
              ),
            );
          },
        ),
      ),
    );
  }
}
