import 'package:cloud_firestore/cloud_firestore.dart';

class ListMovieModel {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  ListMovieModel({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory ListMovieModel.fromJson(Map<String, dynamic> json) => ListMovieModel(
        page: json["page"],
        results: List<MovieModel>.from(
            json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class MovieModel {
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String? posterPath;
  final DateTime? releaseDate;
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieModel({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        backdropPath: json["backdrop_path"] ?? '',
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        posterPath: json["poster_path"] ?? '',
        releaseDate: _parseDate(json["release_date"]),
        title: json["title"],
        voteAverage: json["vote_average"]?.toDouble() ?? 0.0,
        voteCount: json["vote_count"] ?? 0,
      );

  static DateTime? _parseDate(String? date) {
    if (date == null || date.isEmpty) {
      return null;
    }
    try {
      return DateTime.parse(date);
    } catch (e) {
      return null; // or handle the exception as needed
    }
  }

  List<String> getGenres() {
    return genreIds.map((id) => genreMap[id] ?? "Unknown").toList();
  }
}

const Map<int, String> genreMap = {
  28: "Action",
  12: "Adventure",
  16: "Animation",
  35: "Comedy",
  80: "Crime",
  99: "Documentary",
  18: "Drama",
  10751: "Family",
  14: "Fantasy",
  36: "History",
  27: "Horror",
  10402: "Music",
  9648: "Mystery",
  10749: "Romance",
  878: "Science Fiction",
  10770: "TV Movie",
  53: "Thriller",
  10752: "War",
  37: "Western",
};

class ListFavoriteModel {
  ListFavoriteModel({required this.listFavoriteModel});

  final List<FavoriteMovieModel> listFavoriteModel;

  factory ListFavoriteModel.fromJson(
          QuerySnapshot<FavoriteMovieModel> snapshot) =>
      ListFavoriteModel(
        listFavoriteModel: List<FavoriteMovieModel>.from(
          snapshot.docs.map(
            (x) => FavoriteMovieModel.fromJson(x),
          ),
        ),
      );
}

class FavoriteMovieModel {
  FavoriteMovieModel({
    required this.tagline,
    required this.voteCount,
    required this.voteAverage,
    required this.movieId,
    required this.poster,
    required this.title,
  });
  final int movieId;
  final String poster;
  final String tagline;
  final int voteCount;
  final double voteAverage;
  final String title;

  factory FavoriteMovieModel.fromJson(DocumentSnapshot snapshot) =>
      FavoriteMovieModel(
        movieId: snapshot['movieId'],
        poster: snapshot['poster'],
        tagline: snapshot['tagline'],
        voteCount: snapshot['voteCount'],
        voteAverage: snapshot['voteAverage'],
        title: snapshot['title'],
      );

  
}
