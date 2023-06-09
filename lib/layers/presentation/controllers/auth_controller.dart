import 'dart:async';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoplanner/consts/variables.dart';
import 'package:shoplanner/layers/domain/entities/token_entity.dart';
import 'package:shoplanner/layers/domain/entities/user_entity.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class AuthController {
  static final AuthController _instance = AuthController._internal();
  static UserEntity? _user;
  static late TokenEntity token;

  factory AuthController() {
    return _instance;
  }

  Future<bool> login() async {
    // Verifica se já tem o token antes de prosseguir
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String? salvedToken = prefs.getString('token');

    if (salvedToken != null) {
      //verifica se o token ainda é válido
      final hasExpired = JwtDecoder.isExpired(salvedToken);
      if (hasExpired) {
        await prefs.remove('token');
        return false;
      }

      Map<String, dynamic> decodedToken = JwtDecoder.decode(salvedToken);

      token = TokenEntity.fromMap(decodedToken);

      return !hasExpired;
    }

    // Inicia servidor, caso o token não exista ou não seja válido
    final server = await HttpServer.bind('localhost', 3000);

    //Autorização do Github
    await gitAuth();

    final request = await server.first;
    final code = request.uri.queryParameters['code'];

    // Responda com uma mensagem simples para indicar que a URL de retorno foi capturada
    request.response.write(
        'Autenticação realizada com sucesso. Você pode fechar esta janela agora');
    await request.response.close();

    // Encerre o servidor HTTP local
    await server.close();

    if (code != null) {
      //realize a requisição
      final urlServerAuth = '${Variables.baseUrl}/register';
      final body = json.encode({'code': code});
      final response = await http.post(Uri.parse(urlServerAuth),
          body: body, headers: {'Content-Type': 'application/json'});
      final tokenResponse = json.decode(response.body);
      if (tokenResponse['token'] != null) {
        final newToken = tokenResponse['token'];
        // guardar token com sharedPreference
        await prefs.setString('token', newToken);
        final hasExpired = JwtDecoder.isExpired(newToken);
        Map<String, dynamic> decodedToken = JwtDecoder.decode(newToken);
        token = TokenEntity.fromMap(decodedToken);
        return !hasExpired;
      } else
        print('algo deu errado');
      return false;
    }
    return false;
  }

  Future gitAuth() async {
    final authUrl = Uri.parse(
        'https:/github.com/login/oauth/authorize?client_id=${dotenv.env['GITHUB_CLIENT_ID']}&scope=escopos&redirect_uri=http://localhost:3000/api/auth/callback');
    if (await canLaunchUrl(authUrl)) {
      await launchUrl(authUrl,
          mode: LaunchMode.inAppWebView,
          webViewConfiguration:
              const WebViewConfiguration(enableDomStorage: false));
    } else {
      throw 'Could not lauch $authUrl';
    }
  }

  static UserEntity? get user => _user;

  static String get userId => _user?.id ?? '';

  static void setUser(UserEntity user) {
    _user = user;
  }

  AuthController._internal();
}
