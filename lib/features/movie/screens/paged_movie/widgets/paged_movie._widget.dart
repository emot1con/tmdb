import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/features/movie/provider/movies/now_playing_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/popular_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/upcoming_movie.dart';
import 'package:github_tmdb/features/movie/screens/paged_movie/paged_movie.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class PagedMovie extends StatefulWidget {
  const PagedMovie({
    super.key,
    required this.typeMovie,
  });

  final TypeMovie typeMovie;

  @override
  State<PagedMovie> createState() => _PagedMovieState();
}

class _PagedMovieState extends State<PagedMovie> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    switch (widget.typeMovie) {
      case TypeMovie.upcoming:
        _pagingController.addPageRequestListener((pageKey) {
          context.read<UpcomingMovieProvider>().getPagedUpcomingMovie(context,
              pagingController: _pagingController, page: pageKey);
        });
        break;
      case TypeMovie.nowPlaying:
        _pagingController.addPageRequestListener((pageKey) {
          context.read<NowPlayingMovieProvider>().getPagedNowPlayingMovie(
              context,
              pagingController: _pagingController,
              page: pageKey);
        });
        break;
      case TypeMovie.popular:
        _pagingController.addPageRequestListener((pageKey) {
          context.read<PopularMovieProvider>().getPagedPopularMovie(context,
              pagingController: _pagingController, page: pageKey);
        });
        break;
      default:
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<MovieModel>(
        itemBuilder: (context, item, index) {
          return SizedBox(
            height: 170,
            width: 170,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: item.posterPath!.isNotEmpty
                        ? Image.network(
                            '${ApiConstants.imageUrlw500}${item.posterPath}',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 40,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2 / 3,
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
