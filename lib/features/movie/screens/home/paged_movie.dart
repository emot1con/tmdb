import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/features/movie/provider/movies/now_playing_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/popular_movie.dart';
import 'package:github_tmdb/widgets/button/icon_button.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:github_tmdb/constant/api_constants.dart';
import 'package:github_tmdb/constant/sizes.dart';
import 'package:github_tmdb/features/movie/models/movie_models.dart';
import 'package:github_tmdb/features/movie/provider/movies/upcoming_movie.dart';

enum TypeMovie { upcoming, nowPlaying, popular }

class PagedMovieScreen extends StatefulWidget {
  const PagedMovieScreen({
    super.key,
    required this.typeMovie,
  });
  final TypeMovie typeMovie;

  @override
  State<PagedMovieScreen> createState() => _PagedMovieScreenState();
}

class _PagedMovieScreenState extends State<PagedMovieScreen> {
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            TSizes.defaultSpace,
          ),
          child: Stack(
            children: [
              PagedGridView(
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
              ),
              Positioned(
                top: 5,
                left: 5,
                child: TIconButton(
                  onTap: () => Navigator.of(context).pop(),
                  backgroundColor: TColors.colorPrimary,
                  color: Colors.white,
                  padding: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
