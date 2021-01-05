// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeApiStore on _PokeApiStoreBase, Store {
  Computed<PokeAPI> _$pokeAPIComputed;

  @override
  PokeAPI get pokeAPI =>
      (_$pokeAPIComputed ??= Computed<PokeAPI>(() => super.pokeAPI,
              name: '_PokeApiStoreBase.pokeAPI'))
          .value;
  Computed<Pokemon> _$pokemonActualComputed;

  @override
  Pokemon get pokemonActual =>
      (_$pokemonActualComputed ??= Computed<Pokemon>(() => super.pokemonActual,
              name: '_PokeApiStoreBase.pokemonActual'))
          .value;

  final _$_pokeAPIAtom = Atom(name: '_PokeApiStoreBase._pokeAPI');

  @override
  PokeAPI get _pokeAPI {
    _$_pokeAPIAtom.reportRead();
    return super._pokeAPI;
  }

  @override
  set _pokeAPI(PokeAPI value) {
    _$_pokeAPIAtom.reportWrite(value, super._pokeAPI, () {
      super._pokeAPI = value;
    });
  }

  final _$_pokemonActualAtom = Atom(name: '_PokeApiStoreBase._pokemonActual');

  @override
  Pokemon get _pokemonActual {
    _$_pokemonActualAtom.reportRead();
    return super._pokemonActual;
  }

  @override
  set _pokemonActual(Pokemon value) {
    _$_pokemonActualAtom.reportWrite(value, super._pokemonActual, () {
      super._pokemonActual = value;
    });
  }

  final _$colorPokemonAtom = Atom(name: '_PokeApiStoreBase.colorPokemon');

  @override
  Color get colorPokemon {
    _$colorPokemonAtom.reportRead();
    return super.colorPokemon;
  }

  @override
  set colorPokemon(Color value) {
    _$colorPokemonAtom.reportWrite(value, super.colorPokemon, () {
      super.colorPokemon = value;
    });
  }

  final _$_PokeApiStoreBaseActionController =
      ActionController(name: '_PokeApiStoreBase');

  @override
  dynamic fetchPokemonList() {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.fetchPokemonList');
    try {
      return super.fetchPokemonList();
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPokemonActual({int index}) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.setPokemonActual');
    try {
      return super.setPokemonActual(index: index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
colorPokemon: ${colorPokemon},
pokeAPI: ${pokeAPI},
pokemonActual: ${pokemonActual}
    ''';
  }
}
