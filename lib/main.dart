import 'package:flutter/material.dart';
import 'package:flutter_pokedex_mobx/pages/home_page/home_page.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapi_store.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapiv2_store.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<PokeApiStore>(PokeApiStore());
  getIt.registerSingleton<PokeApiV2Store>(PokeApiV2Store());
  return runApp(PokeDexApp());
}

class PokeDexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PokeDex APP',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}
