import 'dart:developer';

import 'package:e_commerce_app/constants/error_handaling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService {
  void signUpUser(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) async {
    try {
      User user = User(
          password: password,
          id: '',
          name: name,
          email: email,
          address: '',
          type: '',
          token: '');
      http.Response res = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackbar(
              context, 'Account created! Login with the same credential');
        },
      );
    } catch (e) {
      showSnackbar(context, "here ${e.toString()}");
    }
  }
}
