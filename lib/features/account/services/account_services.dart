import 'dart:convert';

import 'package:e_commerce_app/constants/error_handaling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/order.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrder({required BuildContext context}) async {
    List<Order> orderList = [];
    try {
      var res = await http.get(
        Uri.parse(
          '$uri/api/orders/me',
        ),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': context.read<UserProvider>().user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackbar(context, "fetch All ${e.toString()}");
    }
    return orderList;
  }
}
