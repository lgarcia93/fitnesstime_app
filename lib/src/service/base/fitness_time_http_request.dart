import 'package:fitness_time/src/service/http_method.dart';

abstract class FitnessTimeHttpRequest {
  final String _baseUrl = 'http://192.168.31.191:8080';

  String get endpoint => null;

  Map<String, dynamic> get headers => {};

  Map<String, dynamic> get parameters => null;

  Map<String, dynamic> get body => null;

  HttpMethod get method => HttpMethod.get;

  String get url {
    return '$_baseUrl/$endpoint';
  }

  bool get authorized => true;
}
