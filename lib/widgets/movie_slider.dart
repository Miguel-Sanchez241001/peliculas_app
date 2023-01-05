import 'package:flutter/material.dart';
import 'package:peliculas_app/models/movie.dart';

class MovieSlider extends StatefulWidget {
  List<Movie> populares;
  String? titulo;
  final Function onNextPage;
  /*  bool visible = true; */

  MovieSlider({
    required this.populares,
    required this.onNextPage,
    this.titulo,
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

// controlador 
final ScrollController scrollController =  ScrollController();

// codigo que se ejecuta al crear el widget
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() { 


      if(scrollController.position.pixels>= scrollController.position.maxScrollExtent -500){
        widget.onNextPage();
        print('aumentar peliulas');
      }
   //   print(scrollController.position.pixels);
   //   print(scrollController.position.maxScrollExtent);
    });    // escucha de eventos 

  }

  // al destruirlo
@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /*  estadoTitulo(){
     if (titulo==null) {
       visible = false;
       titulo = 'chupame la pinga';
     } } */
  @override
  Widget build(BuildContext context) {
/*     estadoTitulo();
 */
    return Container(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          // ignore: prefer_const_constructors

          /*   Visibility(
            visible: visible,
             child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text(
                titulo!,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
                     ),
           ), */
           if(widget.titulo!=null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(widget.titulo!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            // ocupar todo el espacio para dibujar los items de la lista
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.populares.length,
              itemBuilder: (context, index) => _MovieItem(widget.populares[index]),
            ),
          )
        ],
      ),
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movie movie;
  _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
movie.movieHeroId = 'slider-${(movie.id)}';
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments:movie ),
            child: Hero(
              tag: movie.movieHeroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
