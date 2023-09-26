import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitness_time/src/service/http_method.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fitness_time_http_request.dart';

class BaseService {
  Future<Response> execute(FitnessTimeHttpRequest request) async {
    Response response;

    switch (request.method) {
      case HttpMethod.get:
        {
          return await _runGet(request);
        }
      case HttpMethod.post:
        {
          return await _runPost(request);
        }
      case HttpMethod.put:
        return await _runPut(request);
        break;
      case HttpMethod.delete:
        break;
    }
    return null;
  }

  Future<Response> _runGet(FitnessTimeHttpRequest request) async {
    print(request.headers);
    return Dio().get(
      request.url,
      queryParameters: request.parameters,
      options: Options(
        headers: request.authorized
            ? await getTokenizedHeader(request.headers)
            : request.headers,
      ),
    );
  }

  Future<Response> _runPost(FitnessTimeHttpRequest request) async {
    print(request.headers);
    return Dio().post(
      request.url,
      data: json.encode(request.body),
      options: Options(
        headers: request.authorized
            ? await getTokenizedHeader(request.headers)
            : request.headers,
      ),
    );
  }

  Future<Response> _runPut(FitnessTimeHttpRequest request) async {
    return Dio().put(
      request.url,
      data: json.encode(request.body),
      queryParameters: request.parameters,
      options: Options(
        headers: request.authorized
            ? await getTokenizedHeader(request.headers)
            : request.headers,
      ),
    );
  }

  Map<String, dynamic> decode(Response response) {
    return json.decode(response.data.toString());
  }

  Future<Map<String, dynamic>> getTokenizedHeader(
      Map<String, dynamic> inputMap) async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('Authorization');

    return inputMap
      ..addAll(
        <String, dynamic>{
          ''
              'Authorization': token,
        },
      );
  }
}
