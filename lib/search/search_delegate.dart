import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: (() => query = ''),
          ),
        ],
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Resultados');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return empyContainer();
    }
    final provider = Provider.of<MovieProvider>(context, listen: false);
    provider.getSearchQuery(query);
    return StreamBuilder(
      stream: provider.sugestionStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return empyContainer();
        final movie = snapshot.data;
        return ListView.builder(
          itemCount: movie!.length,
          itemBuilder: (context, index) => _MovieItem(movie[index]),
        );
      },
    );
  }

  Widget empyContainer() {
    return const Center(
      child: Icon(
        Icons.movie_creation_outlined,
        color: Colors.black38,
        size: 100,
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    movie.movieHeroId = 'search-${(movie.id)}';
    return ListTile(

      leading: Hero(
        tag:  movie.movieHeroId!,
        child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.fullImg),
            width: 50,
            fit: BoxFit.contain),
      ),
        title: Text(movie.title),
        subtitle: Text(movie.originalTitle),
        onTap: () => Navigator.pushNamed(context, 'details',arguments: movie),
    );
  }
}
