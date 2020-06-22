class Pokemon {
  int id;
  int weight;
  int height;
  String name;
  List<Stats> stats;
  List<Types> types;
  List<Moves> moves;
  List<Abilities> abilities;

  Pokemon({
    this.id,
    this.name,
    this.types,
    this.stats,
    this.moves,
    this.weight,
    this.height,
    this.abilities,
  });

  factory Pokemon.fromJSON(Map<String, dynamic> data) {
    print(data);
    return Pokemon(
      id: data['id'],
      name: data['name'],
      weight: data['weight'],
      height: data['height'],
      stats: [for (var stat in data['stats']) Stats.fromJSON(stat)],
      moves: [for (var move in data['moves']) Moves.fromJSON(move)],
      types: [for (var slot in data['types']) Types.fromJSON(slot['type'])],
      abilities: [
        for (var ability in data['abilities']) Abilities.fromJSON(ability)
      ],
    );
  }
}

class Types {
  String url;
  String name;

  Types({this.name, this.url});

  factory Types.fromJSON(Map<String, dynamic> data) {
    return Types(name: data['name'], url: data['url']);
  }
}

class Stats {
  String url;
  String name;
  int baseStat;

  Stats({this.name, this.url, this.baseStat});

  factory Stats.fromJSON(Map<String, dynamic> data) {
    return Stats(
      url: data['stat']['url'],
      name: data['stat']['name'],
      baseStat: data['base_stat'],
    );
  }
}

class Abilities {
  String url;
  String name;
  int baseExperience;

  Abilities({this.name, this.url, this.baseExperience});

  factory Abilities.fromJSON(Map<String, dynamic> data) {
    return Abilities(
      url: data['ability']['url'],
      name: data['ability']['name'],
      baseExperience: data['base_experience'],
    );
  }
}

class Moves {
  String url;
  String name;

  Moves({this.name, this.url});

  factory Moves.fromJSON(Map<String, dynamic> data) {
    return Moves(
      url: data['move']['url'],
      name: data['move']['name'],
    );
  }
}
