import 'package:favoritos_filmes/telas/favorite_movies_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../movie_provider.dart';

/// Tela de lista de filmes
class MovieListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          Consumer<MovieProvider>(
            builder: (context, movieProvider, child) {
              return Text(
                '${movieProvider.favorites.length}',
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FavoriteMoviesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          return ListView.builder(
            itemCount: movieProvider.movies.length,
            itemBuilder: (context, index) {
              final movie = movieProvider.movies[index];
              return ListTile(
                title: Text(movie.title),
                subtitle: Text(movie.description),
                trailing: IconButton(
                  icon: Icon(
                    movieProvider.isFavorite(movie)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: movieProvider.isFavorite(movie) ? Colors.red : null,
                  ),
                  onPressed: () {
                    movieProvider.toggleFavorite(movie);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
