import 'package:flutter/material.dart';
import 'package:github_tmdb/constant/colors.dart';
import 'package:github_tmdb/features/authentication/provider/login/login_provider.dart';
import 'package:github_tmdb/features/movie/provider/movies/discover_movie.dart';
import 'package:github_tmdb/features/movie/screens/navigations/bottom_navigation_bar.dart';
import 'package:github_tmdb/repository/movie/movie_repository.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<DiscoverMovieProvider>().getDiscoverMovie(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProvider = LoginProvider();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              loginProvider.logout(context);
            },
            icon: const Icon(
              Iconsax.logout,
            ),
          ),
        ],
      ),
      body: Consumer<DiscoverMovieProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: value.discoverMovies.length,
            itemBuilder: (context, index) {
              final movies = value.discoverMovies[index];
              return ListTile(
                leading: Text(
                  movies.title,
                ),
                trailing: Text(movies.releaseDate.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
