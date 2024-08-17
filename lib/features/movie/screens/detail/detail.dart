import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/provider/movies/detail_movie_provider.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
import 'package:provider/provider.dart';

class DetailMovie extends StatefulWidget {
  const DetailMovie({super.key, required this.movieId});
  final int movieId;

  @override
  State<DetailMovie> createState() => _DetailMovieState();
}

class _DetailMovieState extends State<DetailMovie> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DetailMovieProvier>().getDetailMovie(
            context,
            movieId: widget.movieId,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<DetailMovieProvier>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return TShimmer(
            height: 270,
          );
        }
        final movie = value.detailMovies;
        return NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                expandedHeight: 270,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          '${ApiConstants.imageUrlOriginal}${movie.backdropPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                clipBehavior: Clip.none, // Pastikan gambar tidak mengecil
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(movie.title),
                      Row(
                        children: [
                          Text(movie.releaseDate.toString().substring(0, 4)),
                          Row(
                            children:
                                movie.genres.map((e) => Text(e.name)).toList(),
                          ),
                          Text('${movie.runtime} min'),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}
