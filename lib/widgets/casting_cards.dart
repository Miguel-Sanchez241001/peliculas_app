import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/credits_response.dart';
import 'package:peliculas_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int id;
  CastingCards({required this.id});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);
    return FutureBuilder(
      future: moviesProvider.getParticipantesMovies(id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            //  color: Colors.red,
            child: CupertinoActivityIndicator(),
          );
        }
        final actores = snapshot.data!;
        return Container(
          margin: EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          //  color: Colors.red,
          child: ListView.builder(
            itemCount: actores.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => _CastCard(actores[index]),
          ),
        );
      },
    );
  }
}

class _CastCard extends StatelessWidget {
 final Participante participante;
_CastCard(this.participante); 
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      // color: Colors.green,
      child: Column(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage(participante.fullProfileImg),
            width: 100,
            height: 140,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Actor : ${participante.name}',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        )
      ]),
    );
  }
}
