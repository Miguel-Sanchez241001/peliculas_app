import 'package:flutter/material.dart';
import 'package:peliculas_app/models/credits_response.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/providers/movie_provider.dart';
import 'package:peliculas_app/widgets/widget.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Recibiendo el argumento que viene 5de homePage
    final movie = ModalRoute.of(context)?.settings.arguments
        as Movie; // sintacis para que movie siempre tenga un valor recibiendo el string
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(movie),
          SliverList(
              delegate: SliverChildListDelegate(
                  [_PosterAndTitle(movie), _Overview(movie), CastingCards(id:movie.id)]))
        ], // recibe solo slivers
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  _CustomAppBar(this.movie);
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true, // para que no desaparezca del todo
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Container(
          width: double.infinity,
          color: Colors.black12,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 2,right: 10,left: 10),
          child: Text(movie.title, style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fulBackPathImg),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;

  _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final size = MediaQuery.of(context).size;
    print('${movie.id} ${movie.title}');
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.movieHeroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullImg),
                height: 150,
              ),
            ),
          ),
          SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*  SizedBox(  solucion manual
                  width: 200,
                  child: Text(movie.title ,style:textTheme.headline5,
                  overflow: TextOverflow.ellipsis,  // si el texto pasa de las 2 lineas activas puntos
                  maxLines: 3,)
                ) , */
                Text(
                  movie.title, style: textTheme.headline5,
                  overflow: TextOverflow
                      .ellipsis, // si el texto pasa de las 2 lineas activas puntos
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle, style: textTheme.subtitle1,
                  overflow: TextOverflow
                      .ellipsis, // si el texto pasa de las 2 lineas activas puntos
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '${movie.voteAverage}', style: textTheme.caption,
                      overflow: TextOverflow
                          .ellipsis, // si el texto pasa de las 2 lineas activas puntos
                      maxLines: 2,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;
  _Overview(this.movie);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: textTheme.subtitle1,
      ),
    );
  }
}
