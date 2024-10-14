import 'package:flutter/material.dart';
import 'classe/movie.dart';

class MovieProvider with ChangeNotifier {
  final List<Movie> _movies = [
    Movie(
        title: 'Inception',
        description: 'A mind-bending thriller by Christopher Nolan.'),
    Movie(
        title: 'Interstellar',
        description: 'A journey through space and time.'),
    Movie(
        title: 'The Matrix',
        description: 'A hacker discovers the true nature of reality.'),
    Movie(
        title: 'The Matrix Reloaded',
        description: 'A hacker discovers the true nature of reality.'),
    Movie(
        title: 'The Matrix Revolutions',
        description: 'A hacker discovers the true nature of reality.'),
  ];

  final List<Movie> _favorites = [];

  List<Movie> get movies => _movies;
  List<Movie> get favorites => _favorites;

  void toggleFavorite(Movie movie) {
    if (_favorites.contains(movie)) {
      _favorites.remove(movie);
    } else {
      _favorites.add(movie);
    }
    notifyListeners();
  }

  bool isFavorite(Movie movie) {
    return _favorites.contains(movie);
  }
}
