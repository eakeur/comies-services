import 'package:comies/core.dart';
import 'package:datacontext/datacontext.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'constants.dart' as Constants;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComiesController extends DataContext {
  late SharedPreferences session;
  late Service service;
  late String token;
  late BuildContext context;

  Map<String, dynamic> get operatorProperties => JwtDecoder.decode(token);

  Future<void> loadNewSession(BuildContext context) async {
    context = context;
    var route = '/auth';
    try {
      session = await SharedPreferences.getInstance();
      if (session.getKeys().isEmpty)
        createSession(context);
      else {
        if (true /**session.getBool('SETUP') ?? false */) {
          var token = session.getString('TOKEN');
          if (token == null)
            route = '/auth';
          else if (JwtDecoder.isExpired(token))
            route = '/auth';
          else {
            this.token = token;
            route = '/home';
          }
        } else
          // ignore: dead_code
          route = '/auth'; //rotear para tela de confugurações iniciais
      }
    } catch (e) {
      print(e);
    } finally {
      super.changeOrigin(session.getString('URL') ?? Constants.defaultAPIUrl);
      service = Service(context: context);
      Navigator.pushReplacementNamed(context, route);
    }
  }

  Future<void> createSession(BuildContext context) async {
    try {
      session.setInt('ANIM_DURATION', Constants.defaultAnimationDuration);
      session.setString('URL', Constants.defaultAPIUrl);
      session.setInt('CONN_TYPE', Constants.connectionType.index);
      session.setInt('ANIM_DURATION', Constants.defaultAnimationDuration);
      session.setInt('ANIM_DURATION', Constants.defaultAnimationDuration);
      session.setBool('SETUP', false);
      session.setString('APIKEY', Constants.apiKey);
      service = Service(context: context);
    } catch (e) {}
  }

  String? get operatorName => operatorProperties['unique_name'];

  DataSet<Product> products = DataSet<Product>(Product(), route: '/products');
  DataSet<ProductView> productViews = DataSet<ProductView>(ProductView(id: Constants.guidEmpty, value: 0, code: '', name: ''), route: '/products');

  DataSet<Customer> customers = DataSet<Customer>(Customer(), route: '/customers').addChild('phones', Phone(), '/customers/:parentId/phones');
  DataSet<CustomerView> customerViews = DataSet<CustomerView>(CustomerView(), route: '/customers');

  DataSet<Category> categories = DataSet<Category>(Category(), route: '/categories');
  DataSet<CategoryView> categoryViews = DataSet<CategoryView>(CategoryView(), route: '/categories');

  @override
  String origin = '';

  @override
  void onReceiving(Response result) {
    try {
      print(result.body);
      if ([200, 204, 201].contains(result.statusCode)) {
        return;
      }
      if (result.statusCode == 401) Navigator.of(context).pushNamed('/auth');
      throw result;
    } catch (e) {
      throw e;
    }
  }

  @override
  void onSending(Uri uri, Map<String, String> headers, Map<String, dynamic>? data, DataOperation operation) {
    setHeader("Accept-Language", "pt-BR");
    setHeader("Content-Type", "application/json");
    setHeader("Authorization", 'Bearer $token');
  }
}
