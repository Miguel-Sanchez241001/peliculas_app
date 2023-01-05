import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movie_provider.dart';
import 'package:peliculas_app/search/search_delegate.dart';
import 'package:peliculas_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    // como en el appstate tenemos una instancia de movierpovider traera esta 
    final peliculasProvider = Provider.of<MovieProvider>(context);
    //print(peliculasProvider.peliculas);



    return Scaffold(
        appBar: AppBar(
          title:  SizedBox(
            width: 312,
            child: Text('Peliculas en cine',textAlign: TextAlign.center,)),
          elevation: 0,
          actions: [
            IconButton(
                icon: const Icon(Icons.search_outlined),
                onPressed: ()=> showSearch(context: context, delegate: MovieSearchDelegate()),)
          ],
        ),
        // ignore: prefer_const_literals_to_create_immutables
        body: SingleChildScrollView( // scroll vertical en una pantalla
          child: Column(children:  [
            
            CardSwiper( peliculas: peliculasProvider.peliculas),
            MovieSlider(populares: peliculasProvider.populares , titulo: 'Las peliculas de mayores vistas',
            onNextPage: ()=> peliculasProvider.getPopularMovies(),
            ),
          ]),
        ));
  }
}
