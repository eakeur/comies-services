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

  Future<ServerResponse> addOne<T extends DataModel>(T data, {String? route}) async {
    try {
      var result = await server.post(Uri.parse(path + (route ?? '')), body: data.toJson());
      return mountClientResponse(result);
    } catch (e) {
      print(e);
      throw ServerResponse.errorResponse;
    }
  }

  Future<ServerResponse> getOne<T>({String? route, required T uniqueID}) async {
    try {
      var result = await server.get(Uri.parse(path + (route ?? '') + '/' + uniqueID.toString()));
      return mountClientResponse(result);
    } catch (e) {
      print(e);
      throw ServerResponse.errorResponse;
    }
  }

  Future<ServerResponse> getMany<T extends DataModel>({String? route, required Filter filter}) async {
    try {
      var result = await server.post(Uri.parse(path + (route ?? '') + generateQueryParameters(map: filter.toMap())));
      return mountClientResponse(result);
    } catch (e) {
      print(e);
      throw ServerResponse.errorResponse;
    }
  }

  Future<ServerResponse> put<T extends DataModel>(T data, {String? route, required T uniqueID}) async {
    try {
      var result = await server.post(Uri.parse(path + (route ?? '') + '/' + uniqueID.toString()), body: data.toJson());
      return mountClientResponse(result);
    } catch (e) {
      print(e);
      throw ServerResponse.errorResponse;
    }
  }

  Future<ServerResponse> del<T extends DataModel>(T data, {String? route}) async {
    try {
      var result = await server.post(Uri.parse(path + (route ?? '')), body: data.toJson());
      return mountClientResponse(result);
    } catch (e) {
      print(e);
      throw ServerResponse.errorResponse;
    }
  }

  String generateQueryParameters({Map<String, dynamic> map = const <String, dynamic>{}}) => map.keys.reduce((value, key) => value == '' ? value += '?$key=${map[key]}' : '&$key=${map[key]}');

  Future<ServerResponse> mountClientResponse<T>(Response result) async {
    try {
      Map<String, dynamic> map = jsonDecode(result.body);
      return ServerResponse.fromMap(map);
    } catch (e) {
      return ServerResponse.errorResponse;
    }
  }
}
