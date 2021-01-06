import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex_mobx/consts/consts_app.dart';

class PokeItem extends StatelessWidget {
  final String name;
  final int index;
  final Color color;
  final String num;
  final List<String> types;

  const PokeItem(
      {Key key, this.name, this.index, this.color, this.num, this.types})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                      child: Text(
                        name,
                        style: TextStyle(
                            fontFamily: 'Google',
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: setTypes(),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Hero(
                    tag: name + 'rotation',
                    child: Opacity(
                      child: Image.asset(
                        ConstsApp.whitePokeball,
                        height: 80.0,
                        width: 80.0,
                      ),
                      opacity: 0.2,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Hero(
                    tag: name,
                    child: CachedNetworkImage(
                      alignment: Alignment.bottomRight,
                      height: 80.0,
                      width: 80.0,
                      placeholder: (context, url) => new Container(
                        color: Colors.transparent,
                      ),
                      imageUrl:
                          'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$num.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
              color: ConstsApp.getColorType(type: types[0]),
              borderRadius: BorderRadius.circular(20.0))),
    );
  }

  Widget setTypes() {
    List<Widget> listName = [];
    types.forEach((name) {
      listName.add(
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color.fromARGB(80, 255, 255, 255)),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  name.trim(),
                  style: TextStyle(
                      fontFamily: 'Google',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      );
    });
    return Column(
      children: listName,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
