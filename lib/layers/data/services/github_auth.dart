import 'dart:convert';
import 'dart:io';
import 'package:shoplanner/layers/data/services/provider_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shoplanner/consts/variables.dart';
import 'package:http/http.dart' as http;

class GithubAuth implements ProviderAuth {
  @override
  Future<String> handleSignIn() async {
    try {
      // Inicia servidor, caso o token não exista ou não seja válido
      final server = await HttpServer.bind('localhost', 3000);

      //Autorização do Github
      await _gitAuth();

      final request = await server.first;
      final code = request.uri.queryParameters['code'];

      // Responda com uma mensagem simples para indicar que a URL de retorno foi capturada
      request.response.write(
          'Autenticação realizada com sucesso. Você pode fechar esta janela agora');
      await request.response.close();

      // Encerre o servidor HTTP local
      await server.close();

      if (code != null) {
        final urlServerAuth = '${Variables.baseUrl}/register';
        final body = json.encode({'code': code});
        final response = await http.post(Uri.parse(urlServerAuth),
            body: body, headers: {'Content-Type': 'application/json'});
        final tokenResponse = json.decode(response.body);
        if (tokenResponse['token'] != null) {
          String newToken = tokenResponse['token'];
          return newToken;
        } else {
          throw Exception('token in tokenResponse dont exists');
        }
      } else {
        throw Exception('code cannot be null');
      }
    } catch (e) {
      throw Exception('error: $e');
    }
  }

  Future _gitAuth() async {
    final authUrl = Uri.parse(
        'https:/github.com/login/oauth/authorize?client_id=${dotenv.env['GITHUB_CLIENT_ID']}&scope=escopos&redirect_uri=http://localhost:3000/api/auth/callback');
    if (await canLaunchUrl(authUrl)) {
      await launchUrl(
        authUrl,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not lauch $authUrl';
    }
  }
}
