import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/models/pokemon_list.dart';
import 'package:pokedex/utils/url_constants.dart';
import 'package:pokedex/services/base_service.dart';

class PokedexServices {
  PokedexServices._internal();
  final dio = BaseService().dio;
  factory PokedexServices() => _instance;
  static final _instance = PokedexServices._internal();

  Future<PokemonList> getPokemons({int offset, int limit}) async {
    final res = await dio.get(apiGetPokemons(offset, limit));
    return PokemonList.fromJSON(res.data);
  }

  Future<Pokemon> getPokemonInfo({int pokemonId}) async {
    final res = await dio.get(apiPokemonInfo(pokemonId));
    return Pokemon.fromJSON(res.data);
  }

}
