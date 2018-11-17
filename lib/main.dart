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
PokeModel pokemon;

class _HomeState extends State<Home> {
  final String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

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
        floatingActionButton: new FloatingActionButton(
            backgroundColor: Colors.cyan,
            child: new Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            onPressed: () {
              fetchData();
            }),
        backgroundColor: Colors.white70.withAlpha(220),
        appBar: new AppBar(
          title: new Text('Pokemon'),
          backgroundColor: Colors.cyan,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {showSearch(context: context, delegate: DataSearch());},
            )
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

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      new IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    final pokemons = [];
    final pokeIcon = [];
    for(int i = 0; i < pokemon.pokemon.length; i++){
      pokemons.add(pokemon.pokemon[i].name);
      pokeIcon.add(pokemon.pokemon[i].img);

    }
    final suggestion = pokemons.where((p)=>p.toString().toLowerCase().startsWith(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: suggestion.length,
        itemBuilder: (context,i){
        return ListTile(
          leading: new Container(
            height: 50.0,
            width: 50.0, 
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(pokeIcon[i]))
              ),
          ),
          title: new Text(suggestion[i]),
        );
        });
  }
}
