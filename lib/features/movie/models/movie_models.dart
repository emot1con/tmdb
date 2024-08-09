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
        results: List<MovieModel>.from(json["results"].map((x) => MovieModel.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

   
}

class MovieModel {
    final String backdropPath;
    final List<int> genreIds;
    final int id;
    final String posterPath;
    final DateTime releaseDate;
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
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        posterPath: json["poster_path"],
        releaseDate: DateTime.parse(json["release_date"]),
        title: json["title"],
        voteAverage: json["vote_average"]?.toDouble(),
        voteCount: json["vote_count"],
    );

   
}

