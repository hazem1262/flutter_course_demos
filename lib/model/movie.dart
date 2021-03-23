// To parse this JSON data, do
//
//     final movie = movieFromJson(jsonString);

import 'dart:convert';

List<Movie> movieFromJson(String str) => List<Movie>.from(json.decode(str).map((x) => Movie.fromJson(x)));

String movieToJson(List<Movie> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Movie {
  Movie({
    this.title,
    this.image,
    this.rating,
    this.releaseYear,
    this.genre,
  });

  String title;
  String image;
  double rating;
  int releaseYear;
  List<String> genre;

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    title: json["title"],
    image: json["image"],
    rating: json["rating"].toDouble(),
    releaseYear: json["releaseYear"],
    genre: List<String>.from(json["genre"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "rating": rating,
    "releaseYear": releaseYear,
    "genre": List<dynamic>.from(genre.map((x) => x)),
  };
}