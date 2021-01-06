import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex_mobx/consts/consts_app.dart';
import 'package:flutter_pokedex_mobx/models/pokeapi.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapi_store.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatefulWidget {
  final int index;

  const PokeDetailPage({Key key, this.index}) : super(key: key);

  @override
  _PokeDetailPageState createState() => _PokeDetailPageState();
}

class _PokeDetailPageState extends State<PokeDetailPage> {
  PageController _pageController;
  Pokemon _pokemon;
  PokeApiStore _pokemonStore;
  MultiTrackTween _animation;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokemon = _pokemonStore.getPokemonActual;

    _animation = MultiTrackTween([
      Track("rotation").add(Duration(seconds: 5), Tween(begin: 0.0, end: 6.0),
          curve: Curves.linear)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Observer(builder: (BuildContext context) {
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
              backgroundColor: _pokemonStore.colorPokemon,
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
              return Container(
                color: _pokemonStore.colorPokemon,
              );
            }),
            Container(
              height: MediaQuery.of(context).size.height / 3,
            ),
            SlidingSheet(
              elevation: 0,
              cornerRadius: 30,
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
              padding: EdgeInsets.only(top: 60.0),
              child: SizedBox(
                  height: 200.0,
                  child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        _pokemonStore.setPokemonActual(index: index);
                      },
                      itemCount: _pokemonStore.pokeAPI.pokemon.length,
                      itemBuilder: (BuildContext context, int index) {
                        Pokemon _pokemonItem =
                            _pokemonStore.getPokemon(index: index);
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            ControlledAnimation(
                              playback: Playback.LOOP,
                              duration: _animation.duration,
                              tween: _animation,
                              builder: (context, animation) {
                                return Transform.rotate(
                                    child: Hero(
                                      tag: index.toString(),
                                      child: Opacity(
                                        child: Image.asset(
                                          ConstsApp.whitePokeball,
                                          height: 270.0,
                                          width: 270.0,
                                        ),
                                        opacity: 0.2,
                                      ),
                                    ),
                                    angle: animation['rotation']);
                              },
                            ),
                            Observer(builder: (context) {
                              return AnimatedPadding(
                                  child: CachedNetworkImage(
                                    height: 160.0,
                                    width: 160.0,
                                    placeholder: (context, url) =>
                                        new Container(
                                      color: Colors.transparent,
                                    ),
                                    color: index == _pokemonStore.positionAcutal
                                        ? null
                                        : Colors.black.withOpacity(0.5),
                                    imageUrl:
                                        'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/${_pokemonItem.num}.png',
                                  ),
                                  padding: EdgeInsets.all(
                                      index == _pokemonStore.positionAcutal
                                          ? 0
                                          : 60),
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.bounceInOut);
                            })
                          ],
                        );
                      })),
            )
          ],
        ),
      );
    });
  }
}
