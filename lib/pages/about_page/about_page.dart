import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_pokedex_mobx/pages/about_page/widgets/about_description.dart';
import 'package:flutter_pokedex_mobx/stores/pokeapi_store.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController _pageController;
  PokeApiStore _pokemonStore;
  ReactionDisposer _disposer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _pokemonStore = GetIt.instance<PokeApiStore>();
    _pageController = PageController(initialPage: 0);

    _disposer = reaction(
          (f) => _pokemonStore.pokemonActual,
          (r) => _pageController.animateToPage(0,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _disposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Observer(builder: (context) {
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
              indicatorSize: TabBarIndicatorSize.label, //makes it better
              labelColor: _pokemonStore.colorPokemon, //Google's sweet blue
              unselectedLabelColor: Color(0xff5f6368), //niceish grey
              isScrollable: true, //up to your taste
              indicator: MD2Indicator(
                //it begins here
                  indicatorHeight: 4,
                  indicatorColor: _pokemonStore.colorPokemon,
                  indicatorSize: MD2IndicatorSize
                      .normal //3 different modes tiny-normal-full
              ),
              tabs: <Widget>[
                Tab(
                  text: "Description",
                ),
                Tab(
                  text: "Base stats",
                ),
                Tab(
                  text: "Evolution",
                ),
                Tab(
                  text: "Moves",
                ),
              ],
            );
          }),
        ),
      ),
      body: PageView(
        onPageChanged: (index) {
          _tabController.animateTo(index,
              duration: Duration(milliseconds: 300));
        },
        controller: _pageController,
        children: <Widget>[
          AboutDescription(),
          Container(
            width: 10.0,
            height: 10.0,
          ),
          Container(
            width: 10.0,
            height: 10.0,
          ),
          Container(
            width: 10.0,
            height: 10.0,
          )
        ],
      ),
    );
  }
}