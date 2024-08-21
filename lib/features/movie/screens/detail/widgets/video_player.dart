import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/provider/movies/video_movie_provider.dart';
import 'package:github_tmdb/features/movie/screens/detail/widgets/youtube_player_widget.dart';
import 'package:github_tmdb/widgets/shimmer/shimmer_item.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({
    super.key,
    required this.movieId,
  });
  final int movieId;

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<VideoMovieProvider>().getVideoMovie(
            context,
            movieId: widget.movieId,
          );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoMovieProvider>(
      builder: (context, value, child) {
        if (value.videoMovies != null) {
          return SizedBox(
            height: 180,
            width: double.infinity,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final video = value.videoMovies!.results[index];

                return Stack(
                  children: [
                    SizedBox(
                      width: 230,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          YoutubePlayer.getThumbnail(videoId: video.key),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => YoutubePlayerWidget(
                                    youtubeKey: video.key,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              itemCount: value.videoMovies!.results.length,
            ),
          );
        }
        return SizedBox(
          height: 180,
          width: double.infinity,
          child: ListView.separated(
            itemBuilder: (context, index) => const TShimmer(),
            separatorBuilder: (context, index) => const SizedBox(
              width: 10,
            ),
            itemCount: 5,
          ),
        );
      },
    );
  }
}
