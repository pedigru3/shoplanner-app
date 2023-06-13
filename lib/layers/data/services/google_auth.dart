import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoplanner/layers/data/services/http_imp.dart';
import 'package:shoplanner/layers/data/services/provider_auth.dart';

class GoogleAuth implements ProviderAuth {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final http = HttpServiceImp();

  @override
  Future<String> handleSignIn() async {
    try {
      final result = await _googleSignIn.signIn();
      final googleOauth = await result!.authentication;
      final idToken = googleOauth.idToken;
      final response = await http.post(
        slugUrl: '/register/google',
        body: {'idToken': idToken},
      );
      final token = json.decode(response);
      return token['token'];
    } catch (e) {
      throw Exception('error: $e');
    }
  }
}
