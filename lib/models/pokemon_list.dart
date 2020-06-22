class PokemonList {
  int count;
  String nextUrl;
  List<Results> results;

  PokemonList({this.results, this.count, this.nextUrl});

  factory PokemonList.fromJSON(Map<String, dynamic> data) {
    return PokemonList(
      count: data['count'],
      nextUrl: data['next'],
      results: [for (var result in data['results']) Results.fromJSON(result)],
    );
  }
}

class Results {
  String url;
  String name;

  Results({this.name, this.url});

  factory Results.fromJSON(Map<String, dynamic> data) {
    return Results(name: data['name'], url: data['url']);
  }
}
