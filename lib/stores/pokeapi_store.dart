import 'dart:convert';
import 'package:flutter_pokedex_mobx/consts/consts_api.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:flutter_pokedex_mobx/models/pokeapi.dart';
part 'pokeapi_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeAPI _pokeAPI;

  @observable
  Pokemon _pokemonActual;

  @computed
  PokeAPI get pokeAPI => _pokeAPI;

  @computed
  Pokemon get pokemonActual => _pokemonActual;

  @action
  fetchPokemonList() {
    _pokeAPI = null;
    loadPokeAPI().then((pokeList) {
      _pokeAPI = pokeList;
    });
  }

  @action
  getPokemon({int index}) {
    return _pokeAPI.pokemon[index];
  }

  Pokemon get getPokemonActual {
    return _pokemonActual;
  }

  @action
  setPokemonActual({int index}) {
    _pokemonActual = _pokeAPI.pokemon[index];
  }

  // @action
  // Widget getImage({String numero}) {
  //   return CachedNetworkImage(
  //     placeholder: (context, url) => new Container(
  //       color: Colors.transparent,
  //     ),
  //     imageUrl:
  //         'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
  //   );
  // }

  Future<PokeAPI> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsAPI.pokeapiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print('error!!!!!!!!!' + stacktrace.toString());
      return null;
    }
  }
}
