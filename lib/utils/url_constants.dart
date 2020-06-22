String apiGetPokemons(int offset, int limit) =>
    "pokemon?offset=$offset&limit=$limit";
String apiPokemonInfo(int pokemonId) => "pokemon/$pokemonId";
String apiGetImage(int pokemonId) =>
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png";
