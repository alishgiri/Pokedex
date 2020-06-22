import 'package:pokedex/models/pokemon_list.dart';
import 'package:pokedex/services/base_service.dart';

class PokedexServices {
  PokedexServices._internal();
  final dio = BaseService().dio;
  factory PokedexServices() => _instance;
  static final _instance = PokedexServices._internal();

  Future<PokemonList> getPokemons({int offset, int limit}) async {
    final res = await dio
        .get("https://pokeapi.co/api/v2/pokemon?offset=$offset&limit=$limit");
    return PokemonList.fromJSON(res.data);
  }
}
