import 'package:flutter/material.dart';
import 'package:github_tmdb/features/movie/provider/movies/discover_movie.dart';
import 'package:github_tmdb/features/movie/screens/favorite/favorites.dart';
import 'package:github_tmdb/features/movie/screens/home/home.dart';
import 'package:github_tmdb/features/movie/screens/profile/profile.dart';
import 'package:provider/provider.dart';

class NavigationsProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;
  final List<Widget> listWidgets = [
    const HomeScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  void selectIndex(int index) async {
    _selectedIndex = index;
    notifyListeners();
  }
}
