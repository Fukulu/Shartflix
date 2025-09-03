class MovieModel {
  final String id;
  final String title;
  final String description;
  final String posterUrl;
  final String year;

  MovieModel({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.year,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"] ?? "",
      title: json["Title"] ?? "",
      description: json["Plot"] ?? "",
      posterUrl: json["Poster"] ?? "",
      year: json["Year"] ?? "",
    );
  }
}
