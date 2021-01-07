import 'dart:convert';

import 'package:flutter_pokedex_mobx/consts/consts_api.dart';
import 'package:flutter_pokedex_mobx/models/pokeapiv2.dart';
import 'package:flutter_pokedex_mobx/models/species.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
part 'pokeapiv2_store.g.dart';

class PokeApiV2Store = _PokeApiV2StoreBase with _$PokeApiV2Store;

abstract class _PokeApiV2StoreBase with Store {
  @observable
  Species species;

  @observable
  PokeApiV2 pokeApiV2;

  @action
  Future<void> getInfoPokemon(String name) async{
    try{
      final response = await http.get(ConstsAPI.pokeapiv2URL+name.toLowerCase());
      var decodeJson = jsonDecode(response.body);
      pokeApiV2 = PokeApiV2.fromJson(decodeJson);
    }catch (error, stacktrace) {
      print('error!!!!!!!!!' + stacktrace.toString());
      return null;
    }
  }

  @action
  Future<void> getInfoSpecies(String idPokemon) async{
    try{
      final response = await http.get(ConstsAPI.pokeapiv2EspeciesURL+idPokemon);
      var decodeJson = jsonDecode(response.body);
      var _species = Species.fromJson(decodeJson);
      species = _species;
    }catch (error, stacktrace) {
      print('error!!!!!!!!!' + stacktrace.toString());
      return null;
    }
  }
}