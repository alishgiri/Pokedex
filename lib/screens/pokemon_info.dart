import 'package:flutter/material.dart';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/extensions/string.dart';
import 'package:pokedex/utils/url_constants.dart';
import 'package:pokedex/widgets/value_displayer.dart';
import 'package:pokedex/services/pokedex_services.dart';
import 'package:pokedex/widgets/pokemon_info/games.dart';
import 'package:pokedex/widgets/pokemon_info/moves.dart';
import 'package:pokedex/widgets/container_with_shadow.dart';
import 'package:pokedex/widgets/pokemon_info/locations.dart';
import 'package:pokedex/widgets/pokemon_info/evolutions.dart';

class PokemonInfo extends StatefulWidget {
  final int pokemonId;
  PokemonInfo({this.pokemonId});
  _PokemonInfo createState() => _PokemonInfo();
}

class _PokemonInfo extends State<PokemonInfo> {
  int _pokemonId;
  Future getPokemonInfo;

  @override
  void initState() {
    super.initState();
    _pokemonId = widget.pokemonId;
    getPokemonInfo = _getPokemoninfo();
  }

  Future<Pokemon> _getPokemoninfo() async {
    return await PokedexServices().getPokemonInfo(pokemonId: _pokemonId);
  }

  Function _slideUpScreen(BuildContext context, String title, Widget child) =>
      () {
        final theme = Theme.of(context);
        final size = MediaQuery.of(context).size;
        showBottomSheet(
          elevation: 20,
          context: context,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              width: size.width,
              height: size.height * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    trailing: CloseButton(color: Colors.black),
                    title: Text(
                      title,
                      style: theme.textTheme.headline5
                          .copyWith(color: theme.primaryColor),
                    ),
                  ),
                  Divider(height: 0),
                  Expanded(child: child),
                ],
              ),
            );
          },
        );
      };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Hero(
                  tag: _pokemonId,
                  child: Image.network(
                    apiGetImage(_pokemonId),
                    width: size.width,
                    fit: BoxFit.cover,
                    height: size.height * 0.4,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<Pokemon>(
                  future: _getPokemoninfo(),
                  builder: (context, asyncSnapshot) {
                    if (asyncSnapshot.hasError) {
                      return Center(
                        child: Text('Something went wrong!',
                            textAlign: TextAlign.center),
                      );
                    }
                    if (!asyncSnapshot.hasData) {
                      return Center(child: Text('Getting info…'));
                    }
                    final pokemon = asyncSnapshot.data;
                    String abilities = '';
                    for (var a in pokemon.abilities) {
                      final separator = pokemon.abilities.indexOf(a) ==
                              pokemon.abilities.length - 1
                          ? '.'
                          : ', ';
                      abilities += a.name.capitalize() + separator;
                    }
                    return ContainerWithShadow(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            trailing: Text(
                              '#${pokemon.id}',
                              style: theme.textTheme.headline5.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            title: Text(
                              pokemon.name.capitalize(),
                              style: theme.textTheme.headline4,
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: <Widget>[
                                  for (var type in pokemon.types)
                                    ContainerWithShadow(
                                      padding: EdgeInsets.all(10),
                                      color: Colors.blue.shade600,
                                      child: Text(
                                        type.name.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: ValueDisplayer(
                                  label: "Height",
                                  value: "${pokemon.height / 10} m",
                                ),
                              ),
                              Expanded(
                                child: ValueDisplayer(
                                  label: "Weight",
                                  value: "${pokemon.weight / 10} kg",
                                ),
                              ),
                            ],
                          ),
                          ValueDisplayer(
                            label: "Abilities",
                            value: abilities,
                            mainAxisAlignment: MainAxisAlignment.start,
                          ),
                          Divider(),
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.all(20),
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                RaisedButton(
                                  shape: StadiumBorder(),
                                  color: Colors.lightBlue.shade100,
                                  onPressed: _slideUpScreen(
                                    context,
                                    "Moves (${pokemon.moves.length})",
                                    PokemonMoves(moves: pokemon.moves),
                                  ),
                                  child: Text(
                                    "Moves",
                                    style: theme.textTheme.subtitle1.copyWith(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                RaisedButton(
                                  shape: StadiumBorder(),
                                  color: Colors.lightBlue.shade100,
                                  onPressed: _slideUpScreen(
                                    context,
                                    "Evolutions",
                                    PokemonEvolutions(),
                                  ),
                                  child: Text(
                                    "Evolutions",
                                    style: theme.textTheme.subtitle1.copyWith(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                RaisedButton(
                                  shape: StadiumBorder(),
                                  color: Colors.lightBlue.shade100,
                                  onPressed: _slideUpScreen(
                                    context,
                                    "Locations",
                                    PokemonLocations(),
                                  ),
                                  child: Text(
                                    "Locations",
                                    style: theme.textTheme.subtitle1.copyWith(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                                RaisedButton(
                                  shape: StadiumBorder(),
                                  color: Colors.lightBlue.shade100,
                                  onPressed: _slideUpScreen(
                                    context,
                                    "Games",
                                    PokemonGames(),
                                  ),
                                  child: Text(
                                    "Games",
                                    style: theme.textTheme.subtitle1.copyWith(
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          )
        ],
      ),
    );
  }
}
