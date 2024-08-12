import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';

class TGridView extends StatelessWidget {
  const TGridView({
    super.key,
    required this.movies,
    this.isMovie = true,
    required this.height,
  });
  final List<MovieModel> movies;
  final bool isMovie;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: movies.length,
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2 / 3,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        if (isMovie) {
          return SizedBox(
            height: height,
            width: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: movie.posterPath.isNotEmpty
                        ? Image.network(
                            '${ApiConstants.imageUrlw500}${movie.posterPath}',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Icon(Icons.broken_image),
                          ),
                  ),
                ],
              ),
            ),
          );
        }
        return TShimmer(height: height);
      },
    );
  }
}
