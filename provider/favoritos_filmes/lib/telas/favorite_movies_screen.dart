import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../movie_provider.dart';

/// Tela de favoritos
class FavoriteMoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Consumer<MovieProvider>(
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
          ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.favorites.isEmpty) {
            return const Center(
              child: Text('No favorite movies yet.'),
            );
          }
          return ListView.builder(
            itemCount: movieProvider.favorites.length,
            itemBuilder: (context, index) {
              final movie = movieProvider.favorites[index];
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
