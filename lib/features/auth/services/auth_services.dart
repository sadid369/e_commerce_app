// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/common/widgets/bottom_bar.dart';
import 'package:e_commerce_app/constants/error_handaling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/features/home/screens/home_screens.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  void signInUser(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      User user = User(
          password: password,
          id: '',
          name: '',
          email: email,
          address: '',
          type: '',
          token: '');
      http.Response res = await http.post(
        Uri.parse("$uri/api/signin"),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          context.read<UserProvider>().setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)["token"]);
          Navigator.of(context)
              .pushNamedAndRemoveUntil(BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackbar(context, "here ${e.toString()}");
    }
  }

  Future<void> getUserData({required BuildContext context}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        await prefs.setString('x-auth-token', '');
      }
      http.Response tokenRes = await http.get(
        Uri.parse("$uri/tokenisvalid"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': token!,
        },
      );
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        var userResponse = await http.get(
          Uri.parse("$uri/"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            'x-auth-token': token,
          },
        );
        context.read<UserProvider>().setUser(userResponse.body);
      }
    } catch (e) {
      showSnackbar(context, "here ${e.toString()}");
    }
  }
}
