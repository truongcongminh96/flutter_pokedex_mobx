// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapiv2_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeApiV2Store on _PokeApiV2StoreBase, Store {
  final _$speciesAtom = Atom(name: '_PokeApiV2StoreBase.species');

  @override
  Species get species {
    _$speciesAtom.reportRead();
    return super.species;
  }

  @override
  set species(Species value) {
    _$speciesAtom.reportWrite(value, super.species, () {
      super.species = value;
    });
  }

  final _$pokeApiV2Atom = Atom(name: '_PokeApiV2StoreBase.pokeApiV2');

  @override
  PokeApiV2 get pokeApiV2 {
    _$pokeApiV2Atom.reportRead();
    return super.pokeApiV2;
  }

  @override
  set pokeApiV2(PokeApiV2 value) {
    _$pokeApiV2Atom.reportWrite(value, super.pokeApiV2, () {
      super.pokeApiV2 = value;
    });
  }

  final _$getInfoPokemonAsyncAction =
      AsyncAction('_PokeApiV2StoreBase.getInfoPokemon');

  @override
  Future<void> getInfoPokemon(String name) {
    return _$getInfoPokemonAsyncAction.run(() => super.getInfoPokemon(name));
  }

  final _$getInfoSpeciesAsyncAction =
      AsyncAction('_PokeApiV2StoreBase.getInfoSpecies');

  @override
  Future<void> getInfoSpecies(String idPokemon) {
    return _$getInfoSpeciesAsyncAction
        .run(() => super.getInfoSpecies(idPokemon));
  }

  @override
  String toString() {
    return '''
species: ${species},
pokeApiV2: ${pokeApiV2}
    ''';
  }
}
