// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:e_commerce_app/constants/error_handaling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/user.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    try {
      var res = await http.post(
        Uri.parse("$uri/api/save-user-address"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': context.read<UserProvider>().user.token,
        },
        body: jsonEncode({'address': address}),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = context
              .read<UserProvider>()
              .user
              .copyWith(address: jsonDecode(res.body)['address']);
          context.read<UserProvider>().setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
