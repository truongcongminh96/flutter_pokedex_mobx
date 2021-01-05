import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex_mobx/consts/consts_app.dart';
import 'package:flutter_pokedex_mobx/models/pokeapi.dart';
import 'package:flutter_pokedex_mobx/pages/home_page/widgets/app_bar_home.dart';
import 'package:flutter_pokedex_mobx/pages/home_page/widgets/poke_item.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapi_store.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeApiStore pokeApiStore;
  @override
  void initState() {
    super.initState();
    pokeApiStore = PokeApiStore();
    pokeApiStore.fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double statusWidth = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top - 240 / 2.9,
            left: screenWidth - (240 / 1.6),
            child: Opacity(
              child: Image.asset(
                ConstsApp.blackPokeball,
                height: 240,
                width: 240,
              ),
              opacity: 0.1,
            ),
          ),
          Container(
            child: Column(
              children: [
                Container(
                  height: statusWidth,
                ),
                AppBarHome(),
                Expanded(
                    child: Container(
                        child: Observer(
                  name: 'ListHomePage',
                  builder: (BuildContext context) {
                    return (pokeApiStore.pokeAPI != null)
                        ? AnimationLimiter(
                            child: GridView.builder(
                              physics: BouncingScrollPhysics(),
                              padding: EdgeInsets.all(12),
                              addAutomaticKeepAlives: true,
                              gridDelegate:
                                  new SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: pokeApiStore.pokeAPI.pokemon.length,
                              itemBuilder: (context, index) {
                                Pokemon pokemon =
                                    pokeApiStore.getPokemon(index: index);
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: 2,
                                  child: ScaleAnimation(
                                    child: GestureDetector(
                                      child: PokeItem(
                                        types: pokemon.type,
                                        index: index,
                                        name: pokemon.name,
                                        num: pokemon.num,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                Container(),
                                            //         PokeDetailPage(
                                            //   index: index,
                                            // ),
                                            fullscreenDialog: true,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
