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

  Future<ServerResponse> addOne<T extends DataModel>(T data, {String? route, ReturnType returnType = ReturnType.DATAMODEL, dynamic Function(dynamic)? bodyParser}) async {
    try {
      var result = await server.post(Uri.parse(path + (route ?? '')), body: data.toJson(), headers: getHeaders());
      return mountClientResponse(result, returnType, bodyParser);
    } catch (e) {
      print(e);
      throw ServerResponse.errorResponse;
    }
  }

  Future<ServerResponse> getOne<T>({String? route, required T uniqueID, ReturnType returnType = ReturnType.DATAMODEL, dynamic Function(dynamic)? bodyParser}) async {
    try {
      var result = await server.get(Uri.parse(path + (route ?? '') + '/' + uniqueID.toString()));
      return mountClientResponse(result, returnType, bodyParser);
    } catch (e) {
      print(e);
      throw ServerResponse.errorResponse;
    }
  }

  Future<ServerResponse> getMany<T extends DataModel>({String? route, required Filter filter, ReturnType returnType = ReturnType.DATAMODEL, dynamic Function(dynamic)? bodyParser}) async {
    try {
      var result = await server.post(Uri.parse(path + (route ?? '') + generateQueryParameters(map: filter.toMap())));
      return mountClientResponse(result, returnType, bodyParser);
    } catch (e) {
      print(e);
      throw ServerResponse.errorResponse;
    }
  }

  Future<ServerResponse> put<T extends DataModel>(T data, {String? route, required T uniqueID, ReturnType returnType = ReturnType.DATAMODEL, dynamic Function(dynamic)? bodyParser}) async {
    try {
      var result = await server.post(Uri.parse(path + (route ?? '') + '/' + uniqueID.toString()), body: data.toJson());
      return mountClientResponse(result, returnType, bodyParser);
    } catch (e) {
      print(e);
      throw ServerResponse.errorResponse;
    }
  }

  Future<ServerResponse> del<T extends DataModel>(T data, {String? route, ReturnType returnType = ReturnType.DATAMODEL, dynamic Function(dynamic)? bodyParser}) async {
    try {
      var result = await server.post(Uri.parse(path + (route ?? '')), body: data.toJson());
      return mountClientResponse(result, returnType, bodyParser);
    } catch (e) {
      print(e);
      throw ServerResponse.errorResponse;
    }
  }

  String generateQueryParameters({Map<String, dynamic> map = const <String, dynamic>{}}) => map.keys.reduce((value, key) => value == '' ? value += '?$key=${map[key]}' : '&$key=${map[key]}');

  Map<String, String> getHeaders() {
    return {"Accept-Language": "pt-BR", "Content-Type": "application/json", 'Authorization': token };
  }

  Future<ServerResponse> mountClientResponse<T>(Response result, ReturnType returnType, dynamic Function(dynamic)? bodyParser) async {
    try {
      if (returnType == ReturnType.JSON) return ServerResponse.custom(data: result.body);
      if (returnType == ReturnType.MAP) return ServerResponse.custom(data: jsonDecode(result.body));

      if (bodyParser != null) {
        var res = ServerResponse.fromJson(result.body);
        return res.copyWith(data: bodyParser(res.data));
      }

      return ServerResponse.fromJson(result.body);
    } catch (e) {
      return ServerResponse.errorResponse;
    }
  }
}
