import 'package:flutter/material.dart';

import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/extensions/string.dart';

class PokemonMoves extends StatelessWidget {
  final List<Moves> moves;

  PokemonMoves({this.moves});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final move = moves[index];
          return ListTile(title: Text(move.name.capitalize()));
        },
      ),
    );
  }
}
