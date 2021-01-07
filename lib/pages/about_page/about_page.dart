import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapi_store.dart';
import 'package:get_it/get_it.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PokeApiStore _pokemonStore;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 4, vsync: this);
    _pokemonStore = GetIt.instance<PokeApiStore>();
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
    );
  }
}
