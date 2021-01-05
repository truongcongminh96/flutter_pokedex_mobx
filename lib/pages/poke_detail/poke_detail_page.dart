import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex_mobx/consts/consts_app.dart';
import 'package:flutter_pokedex_mobx/models/pokeapi.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatelessWidget {
  final int index;
  final String name;

  const PokeDetailPage({Key key, this.index, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeApiStore>(context);
    Pokemon _pokemon = _pokemonStore.getPokemonActual;
    Color _colorPokemon = ConstsApp.getColorType(type: _pokemon.type[0]);

    return Observer(builder: (BuildContext context) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Observer(builder: (BuildContext context) {
            _colorPokemon = ConstsApp.getColorType(
                type: _pokemonStore.pokemonActual.type[0]);
            return AppBar(
              title: Opacity(
                  child: Text(
                    _pokemon.name,
                    style: TextStyle(
                        fontFamily: 'Google',
                        fontWeight: FontWeight.bold,
                        fontSize: 21.0),
                  ),
                  opacity: 0.0),
              elevation: 0,
              backgroundColor: _colorPokemon,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ],
            );
          }),
        ),
        body: Stack(
          children: [
            Observer(builder: (context) {
              _colorPokemon = ConstsApp.getColorType(
                  type: _pokemonStore.pokemonActual.type[0]);
              return Container(
                color: _colorPokemon,
              );
            }),
            Container(
              height: MediaQuery.of(context).size.height / 3,
            ),
            SlidingSheet(
              elevation: 0,
              cornerRadius: 20,
              snapSpec: const SnapSpec(
                // Enable snapping. This is true by default.
                snap: true,
                // Set custom snapping points.
                snappings: [0.7, 1.0],
                // Define to what the snappings relate to. In this case,
                // the total available space that the sheet can expand to.
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),
              // body: Center(
              //   child: Text('This widget is below the SlidingSheet'),
              // ),
              builder: (context, state) {
                // This is the content of the sheet that will get
                // scrolled, if the content is bigger than the available
                // height of the sheet.
                return Container(height: MediaQuery.of(context).size.height);
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: SizedBox(
                  height: 150.0,
                  child: PageView.builder(
                      onPageChanged: (index) {
                        _pokemonStore.setPokemonActual(index: index);
                      },
                      itemCount: _pokemonStore.pokeAPI.pokemon.length,
                      itemBuilder: (BuildContext context, int count) {
                        Pokemon _pokemonItem =
                            _pokemonStore.getPokemon(index: count);
                        return CachedNetworkImage(
                          height: 60.0,
                          width: 60.0,
                          placeholder: (context, url) => new Container(
                            color: Colors.transparent,
                          ),
                          imageUrl:
                              'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokemonItem.num}.png',
                        );
                      })),
            )
          ],
        ),
      );
    });
  }
}
