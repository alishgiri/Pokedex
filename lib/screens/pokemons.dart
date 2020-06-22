import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pokedex/widgets/search_bar.dart';
import 'package:pokedex/models/pokemon_list.dart';
import 'package:pokedex/utils/url_constants.dart';
import 'package:pokedex/screens/pokemon_info.dart';
import 'package:pokedex/services/pokedex_services.dart';
import 'package:pokedex/widgets/container_with_shadow.dart';

class Pokemons extends StatefulWidget {
  _Pokemons createState() => _Pokemons();
}

class _Pokemons extends State<Pokemons> {
  int _offset = 0;
  int _limit = 964;
  String _searchKey = '';
  bool _searchMode = false;
  final _formKey = GlobalKey<FormState>();

  Future<PokemonList> _getPokemons() async {
    return await PokedexServices().getPokemons(limit: _limit, offset: _offset);
  }

  void _onToggleSearchMode([bool state]) {
    setState(() {
      _searchMode = state ?? !_searchMode;
      if (!_searchMode) _searchKey = '';
    });
  }

  void _displayPokemonInfo(BuildContext context, int pokemonId) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionsBuilder: (context, ani1, ani2, child) {
          final tween = Tween(begin: 0.0, end: 1.0);
          final opacity = ani1.drive(tween);
          return FadeTransition(child: child, opacity: opacity);
        },
        pageBuilder: (context, animation, secondaryAnimation) => PokemonInfo(
          pokemonId: pokemonId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final rowNum = size.width ~/ 150.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Pokedex',
          style: GoogleFonts.acme(fontSize: theme.textTheme.headline4.fontSize),
        ),
        elevation: _searchMode ? 0 : 1,
        actions: <Widget>[
          _searchMode
              ? FlatButton(
                  child: Text(
                    'Advanced Search',
                    style:
                        theme.textTheme.caption.copyWith(color: Colors.white),
                  ),
                  onPressed: () {},
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _onToggleSearchMode,
                )
        ],
      ),
      body: Column(
        children: <Widget>[
          SearchBar(
            formKey: _formKey,
            searchMode: _searchMode,
            onToggleSearchMode: _onToggleSearchMode,
            onChanged: (v) => setState(() => _searchKey = v),
          ),
          Expanded(
            child: FutureBuilder<PokemonList>(
              future: _getPokemons(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong!',
                        textAlign: TextAlign.center),
                  );
                }
                if (!asyncSnapshot.hasData) {
                  return Center(child: Text('Loading pokemons…'));
                }
                final results = asyncSnapshot.data.results;
                final pokemons = results.where((d) {
                  return d.name.toLowerCase().contains(
                        _searchKey.toLowerCase(),
                      );
                }).toList();
                return Scrollbar(
                  child: GridView.builder(
                    itemCount: pokemons.length,
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowNum,
                    ),
                    itemBuilder: (context, index) {
                      final pokemon = pokemons[index];
                      final split = pokemon.url.split('/');
                      final pokemonId = int.parse(split[split.length - 2]);
                      return InkWell(
                        onTap: () => _displayPokemonInfo(context, pokemonId),
                        child: ContainerWithShadow(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 120,
                                height: 120,
                                child: Hero(
                                  tag: pokemonId,
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      apiGetImage(pokemonId),
                                    ),
                                    backgroundColor: Colors.grey.shade100,
                                  ),
                                ),
                              ),
                              Expanded(child: SizedBox()),
                              Text(
                                pokemon.name.toUpperCase(),
                                style: theme.textTheme.subtitle2,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
