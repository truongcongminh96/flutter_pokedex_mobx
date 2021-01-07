import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex_mobx/components/circular_progress.dart';
import 'package:flutter_pokedex_mobx/models/species.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapiv2_store.dart';
import 'package:get_it/get_it.dart';

class AboutDescription extends StatelessWidget {
  final PokeApiV2Store _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Observer(builder: (context) {
              Species _species = _pokeApiV2Store.species;
              return _species != null
                  ? Text(_species.flavorTextEntries
                      .where((element) => element.language.name == 'en')
                      .first
                      .flavorText)
                  : SizedBox(
                height: 15.0,
                  width: 15.0,
                  child: CircularProgress());
            }),
          ],
        ),
      ),
    );
  }
}
