import 'dart:developer';

import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '', name: name, email: email, address: '', type: '', token: '');
      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      log(res.body);
    } catch (e) {
      log(e.toString());
    }
  }
}
