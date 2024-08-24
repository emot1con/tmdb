import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:github_tmdb/app.dart';
import 'package:github_tmdb/features/authentication/provider/signout/signout_provider.dart';
import 'package:github_tmdb/features/movie/provider/favorite/favorite_movie_provider.dart';
import 'package:github_tmdb/features/movie/provider/movies/detail_movie_provider.dart';
import 'package:github_tmdb/features/movie/provider/movies/discover_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/now_playing_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/popular_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/search_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/upcoming_movie.dart';
import 'package:github_tmdb/features/movie/provider/movies/video_movie_provider.dart';
import 'package:github_tmdb/features/movie/provider/navigations/navigations.dart';
import 'package:github_tmdb/firebase_options.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';
import 'package:provider/provider.dart';

import 'package:github_tmdb/features/authentication/provider/signup/signup_provider.dart';
import 'package:github_tmdb/features/authentication/provider/login/login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => SignOutProvider()),
        ChangeNotifierProvider(create: (context) => NavigationsProvider()),
        
        ChangeNotifierProvider(create: (context) => MovieRepository()),

        ChangeNotifierProvider(create: (context) => SearchMovieProvider()),

        ChangeNotifierProvider(create: (context) => DiscoverMovieProvider()),
        ChangeNotifierProvider(create: (context) => PopularMovieProvider()),
        ChangeNotifierProvider(create: (context) => NowPlayingMovieProvider()),
        ChangeNotifierProvider(create: (context) => UpcomingMovieProvider()),

        ChangeNotifierProvider(create: (context) => FavoriteMovieProvider()),

        ChangeNotifierProvider(create: (context) => DetailMovieProvier()),
        ChangeNotifierProvider(create: (context) => VideoMovieProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const AppScreen(),
      ),
    );
  }
}
