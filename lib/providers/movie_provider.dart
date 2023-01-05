


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/helpers/debouncer.dart';
import 'package:peliculas_app/models/credits_response.dart';
import 'package:peliculas_app/models/models.dart';
import 'package:peliculas_app/models/popular_movies.dart';
import 'package:peliculas_app/models/search_movies.dart';

class MovieProvider extends ChangeNotifier{
 final String _apiKey ='3acffbe1d331e817ef989df9ce8abc32';
 final String _baseUrl = 'api.themoviedb.org';
final String _language = 'es-Es';
 List<Movie> peliculas = [];
 List<Movie> populares = [];
 
final StreamController<List<Movie>> _streamController = StreamController.broadcast(); 
Stream<List<Movie>> get sugestionStream => this._streamController.stream;

final debouncer = Debouncer(duration: Duration(milliseconds: 500),

);

 Map<int,List<Participante>> actores = {};
 int _page = 0;
  MovieProvider(){
   // print('Movie provider inicializada');
  getOnDisplayMovie();
  getPopularMovies();
  }


Future<String> getJsonData( String endPoint,[int page = 1]) async{
 var url = Uri.https(_baseUrl, endPoint, 
      {
        'api_key': _apiKey,
        'language' : _language,
        'page': '$page'
        });

  // Await the http get response, then decode the json-formatted response.
  final response = await http.get(url);
  return response.body;
}

getOnDisplayMovie() async {
  final jsonData = await getJsonData('3/movie/now_playing');
  final peliculasCarteleraActual = NowPlayingResponse.fromJson(jsonData);

  
 // print(peliculasCarteleraActual.results[1].title);
  peliculas = peliculasCarteleraActual.results;
// notifica cambio a los widgets que necesitan redibujarse por cambios en la data
  notifyListeners();
}

getPopularMovies() async {
  _page++;
  final jsonData = await getJsonData('3/movie/popular',_page); 
  final peliculasPopulares = PopularResponse.fromJson(jsonData); 
 // print(peliculasCarteleraActual.results[1].title);
  populares = [...populares,...peliculasPopulares.results]; // seguir agrupando peliculas populars en el mismo arreglo
// notifica cambio a los widgets que necesitan redibujarse por cambios en la data
  notifyListeners();
}

Future<List<Participante>> getParticipantesMovies(int movieId) async {
  if(actores.containsKey(movieId)) return actores[movieId]!; 
  print('pidiendo datos');// verifica que ya existan los actores en el mapa y los envia
  final jsonData = await getJsonData('3/movie/$movieId/credits'); 
  final participantesMovie = CreditsResponse.fromJson(jsonData); 
  actores[movieId] = participantesMovie.cast;
  return participantesMovie.cast;
}

Future<List<Movie>> searchmovie(String query) async {
final url = Uri.https(_baseUrl, '3/search/movie', 
      {
        'api_key': _apiKey,
        'language' : _language,
        'query': query
        });
  final response = await http.get(url);
  final busquedaQuery = SearchResponse.fromJson(response.body); 
 return busquedaQuery.results;
}

  void getSearchQuery(String query){
    debouncer.value = '';
    debouncer.onValue=(value) async{
      final result = await this.searchmovie(value);
    this._streamController.add(result);


    };
   // espera un tiempo para asignar la busqueda al debouncer
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });
Future.delayed(Duration(milliseconds: 305)).then((_) => timer.cancel());
      }
}