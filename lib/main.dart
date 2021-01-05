import 'package:flutter/material.dart';
import 'package:flutter_pokedex_mobx/pages/home_page/home_page.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(PokeDexApp());
}

class PokeDexApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider<PokeApiStore>(
          create: (_) => PokeApiStore(),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: true,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: HomePage()),
    );
  }
}
