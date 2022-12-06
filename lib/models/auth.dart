import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static const url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCR6c-Ks7dqJinCS6LWbjhAiggeajQdgTo';

  Future<void> signup(String email, String password) async {
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );
    print(jsonDecode(response.body));
  }
}
