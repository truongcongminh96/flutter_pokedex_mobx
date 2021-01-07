import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex_mobx/models/species.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapi_store.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapiv2_store.dart';
import 'package:get_it/get_it.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  PokeApiStore _pokemonStore;
  PokeApiV2Store _pokeApiV2Store;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pokeApiV2Store = GetIt.instance<PokeApiV2Store>();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: Observer(
              builder: (context) {
                return TabBar(
                  onTap: (index) {
                    _pageController.animateToPage(index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut);
                  },
                  controller: _tabController,
                  labelStyle: TextStyle(
                      //up to your taste
                      fontWeight: FontWeight.w700),
                  indicatorSize: TabBarIndicatorSize.label,
                  //makes it better
                  labelColor: _pokemonStore.colorPokemon,
                  //Google's sweet blue
                  unselectedLabelColor: Color(0xff5f6368),
                  //niceish grey
                  isScrollable: true,
                  //up to your taste
                  indicator: MD2Indicator(
                      //it begins here
                      indicatorHeight: 4,
                      indicatorColor: _pokemonStore.colorPokemon,
                      indicatorSize: MD2IndicatorSize
                          .normal //3 different modes tiny-normal-full
                      ),
                  tabs: <Widget>[
                    Tab(
                      text: "About",
                    ),
                    Tab(
                      text: "Base Stats",
                    ),
                    Tab(
                      text: "Evolution",
                    ),
                    Tab(
                      text: "Moves",
                    )
                  ],
                );
              },
            )),
      ),
      body: PageView(
        onPageChanged: (index) {
          _tabController.animateTo(index,
              duration: Duration(milliseconds: 300));
        },
        controller: _pageController,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Observer(builder: (context) {
                    Species _species = _pokeApiV2Store.species;
                    return _species != null
                        ? Text(
                            _species.flavorTextEntries
                                .where((item) => item.language.name == 'en')
                                .first
                                .flavorText,
                            style: TextStyle(fontSize: 14.0),
                          )
                        : SizedBox(
                            height: 15.0,
                            width: 15.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  _pokemonStore.colorPokemon),
                            ),
                          );
                  }),
                ],
              ),
            ),
          ),
          Container(color: Colors.blue),
          Container(color: Colors.yellow),
          Container(color: Colors.green)
        ],
      ),
    );
  }
}
