import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:e_commerce_app/constants/error_handaling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminServices {
  void sellProduct(
      {required BuildContext context,
      required String name,
      required String description,
      required double quantity,
      required double price,
      required String category,
      required List<File> images}) async {
    try {
      final cloudinary = CloudinaryPublic('dlf9ltucz', "xbcienps");
      List<String> imageUrls = [];
      for (var image in images) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(image.path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      var res = await http.post(
        Uri.parse("$uri/admin/add-product"),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': context.read<UserProvider>().user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackbar(context, 'Product added Successfully');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
