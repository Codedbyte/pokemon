import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pokemodel.dart';
import 'pokedetail.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Pokemon',
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  PokeModel pokemon;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await http.get(url);
    var decoded = jsonDecode(response.body);
    pokemon = PokeModel.fromJson(decoded);
    print(pokemon);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Pokemon'),
          backgroundColor: Colors.cyan,
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: (){})
          ],
        ),
        body: pokemon == null
            ? new Center(
                child: CircularProgressIndicator(),
              )
            : GridView.count(
          padding: const EdgeInsets.all(8.0),
                crossAxisCount: 2,
                children: pokemon.pokemon
                    .map((poke) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PokeDetail(
                                        pokemon: poke,
                                      )));
                            },
                            child: Card(
                              elevation: 3.0,
                              child: new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Hero(
                                    tag: poke.img,
                                    child: new Container(
                                      height: 100.0,
                                      width: 100.0,
                                      decoration: new BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(poke.img))),
                                    ),
                                  ),
                                  new Text(
                                    poke.name,
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ));
  }
}
