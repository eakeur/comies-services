import 'dart:convert';
import 'package:comies/core.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:http/http.dart' show Client, Response;

class Service {
  final Client server = Client();
  final BuildContext context;
  late String path;
  late String token;

  Service({required this.context}) {
    path = getProvider(context).session.getString('URL') ?? '';
    token = getProvider(context).session.getString('TOKEN') ?? '';
  }

  Future<ServerResponse> addOne<T extends DataModel>(T data, {String? route, dynamic Function(dynamic)? bodyParser}) async {
    try {
      var result = await server.post(Uri.parse(path + (route ?? '')), body: data.toJson(), headers: getHeaders());
      return mountClientResponse(result, bodyParser);
    } catch (e) {
      print(e);
      if (e is ServerResponse)
        throw e;
      else
        throw ServerResponse.error();
    }
  }

  Future<ServerResponse> getOne<T>({String? route, required T uniqueID, dynamic Function(dynamic)? bodyParser}) async {
    try {
      var result = await server.get(Uri.parse(path + (route ?? '') + '/' + uniqueID.toString()), headers: getHeaders());
      return mountClientResponse(result, bodyParser);
    } catch (e) {
      print(e);
      if (e is ServerResponse)
        throw e;
      else
        throw ServerResponse.error();
    }
  }

  Future<ServerResponse> getMany<T extends DataModel>({String? route, required Filter filter, dynamic Function(dynamic)? bodyParser}) async {
    try {
      var result = await server.get(Uri.parse(path + (route ?? '') + generateQueryParameters(map: filter.toMap())), headers: getHeaders());
      return mountClientResponse(result, bodyParser);
    } catch (e) {
      print(e);
      if (e is ServerResponse)
        throw e;
      else
        throw ServerResponse.error();
    }
  }

  Future<ServerResponse> put<T extends DataModel>(T data, {String? route, required Object uniqueID, dynamic Function(dynamic)? bodyParser}) async {
    try {
      var result = await server.put(Uri.parse(path + (route ?? '') + '/' + uniqueID.toString()), body: data.toJson(), headers: getHeaders());
      return mountClientResponse(result, bodyParser);
    } catch (e) {
      print(e);
      if (e is ServerResponse)
        throw e;
      else
        throw ServerResponse.error();
    }
  }

  Future<ServerResponse> del<T extends DataModel>(T data, {String? route, dynamic Function(dynamic)? bodyParser}) async {
    try {
      var result = await server.post(Uri.parse(path + (route ?? '')), body: data.toJson(), headers: getHeaders());
      return mountClientResponse(result, bodyParser);
    } catch (e) {
      print(e);
      if (e is ServerResponse)
        throw e;
      else
        throw ServerResponse.error();
    }
  }

  String generateQueryParameters({Map<String, dynamic> map = const <String, dynamic>{}}) => map.keys.reduce((value, key) {
        if (map[key] != null) {
          return value == '' ? value += '?$key=${map[key]}' : '&$key=${map[key]}';
        } else
          return '';
      });

  Map<String, String> getHeaders() {
    return {"Accept-Language": "pt-BR", "Content-Type": "application/json", 'Authorization': 'Bearer $token'};
  }

  Future<ServerResponse> mountClientResponse<T>(Response result, dynamic Function(dynamic)? bodyParser) async {
    try {
      bool success = true;
      print(result.body);
      if (okStatuses.contains(result.statusCode)) {
        if (result.statusCode == 204) {
          return ServerResponse(success: success, message: 'Oba! A operação foi realizada com sucesso!', token: result.headers['Authorization'] ?? result.headers['authorization']);
        } else {
          var body = bodyParser != null ? bodyParser(result.body) : jsonDecode(result.body);
          return ServerResponse(
              path: Uri.tryParse(result.headers['Location'] ?? ''),
              success: success,
              data: body,
              message: result.statusCode == 201 ? 'Oba! Item adicionado com sucesso!' : null,
              records: int.tryParse(result.headers['x-total-count'] ?? '0'));
        }
      }
      throw ServerResponse.error();
    } catch (e) {
      throw ServerResponse.error();
    }
  }

  List<int> get okStatuses => [200, 204, 201];
}
