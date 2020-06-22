import 'package:dio/dio.dart';

class BaseService {
  Dio _dio;
  Dio get dio => _dio;
  factory BaseService() => _instance;
  static final _instance = BaseService._internal();

  BaseService._internal() {
    _dio = Dio(BaseOptions(baseUrl: 'https://pokeapi.co/api/v2'));
  }
}
