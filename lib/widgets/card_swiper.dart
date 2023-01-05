import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/movie.dart';


class CardSwiper extends StatelessWidget {
  final List<Movie> peliculas;

  const CardSwiper({
    Key? key,
     required this.peliculas}
     ):super(key: key);

  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height *0.5,
      child: Swiper( // importado para el carrusel de imagenes
        itemCount: peliculas.length, // cambiando de 10
        
        layout: SwiperLayout.STACK,
        itemWidth: size.width*0.6,
        itemHeight: size.height*0.4,
        itemBuilder: (_, int index) {
          final movie = peliculas[index];
          //print(movie.fullImg);
           movie.movieHeroId = 'swiper-${(movie.id)}'; 
            return GestureDetector( // atento a toques en la imagen
              onTap: () => Navigator.pushNamed(context, 'details',arguments:movie ),
              child: Hero(
                tag: movie.movieHeroId!,
                child: ClipRRect( // recordar para border
                  borderRadius: BorderRadius.circular(20),
                  child:  FadeInImage(
                    placeholder: AssetImage('assets/no-image.jpg'),
                   image: NetworkImage(movie.fullImg),
                   fit: BoxFit.cover
                   ),
                  
                ),
              ),
            );
        },
      ),
    );
  }
}