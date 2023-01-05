import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movie_provider.dart';
import 'package:peliculas_app/screens/screens.dart';
import 'package:provider/provider.dart';


void main() {
  runApp( AppState());
}

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => MovieProvider(), lazy: false,)
    ],
    child: MyApp(),
    );
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'peliculas App',
     initialRoute: 'home',
     routes: {
      'home':(_) =>  HomePage(),
      'details' :(_) =>   DetailScreen(),
     },
     theme: ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        color: Colors.indigo
      )
     ),
      
    );
  }
}
