import 'package:flutter/material.dart';
import 'package:pokemon/pokemodel.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokeDetail({this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.cyan,
          title: new Text(pokemon.name),
        ),
        backgroundColor: Colors.cyan,
        body: new Stack(
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 60.0),
                child: new Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: new Container(
                    padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 20.0),
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width - 50,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new SizedBox(height: 5.0,),
                        Text(
                          pokemon.name,
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                        Text("Height: ${pokemon.height}"),
                        Text("Weight: ${pokemon.weight}"),
                        Text(
                          "Types",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: pokemon.type
                                .map((t) => FilterChip(
                                      backgroundColor: Colors.amber,
                                      onSelected: (b) {},
                                      label: Text(t),
                                    ))
                                .toList()),
                        Text(
                          "Weakness",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: pokemon.weaknesses
                              .map((t) => FilterChip(
                                    onSelected: (b) {},
                                    label: Text(
                                      t,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            new Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: pokemon.img,
                child: new Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: NetworkImage(
                      pokemon.img,
                    ),
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            )
          ],
        ));
  }
}
