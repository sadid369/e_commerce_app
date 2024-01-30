import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackbar(context, "400 ${jsonDecode(response.body)['msg']}");
      log("400 ${jsonDecode(response.body)['msg']}");
      break;
    case 500:
      showSnackbar(context, "500 ${jsonDecode(response.body)['error']}");
      log("500 ${jsonDecode(response.body)['msg']}");
      break;
    default:
      showSnackbar(context, "default ${response.body}");
      log("default ${response.body}");
  }
}
