import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:e_commerce_app/common/widgets/bottom_bar.dart';
import 'package:e_commerce_app/constants/error_handaling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/features/admin/models/sales.dart';
import 'package:e_commerce_app/features/admin/screens/admin_screens.dart';
import 'package:e_commerce_app/features/admin/screens/posts_screen.dart';
import 'package:e_commerce_app/models/order.dart';
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
          Navigator.of(context).pushNamedAndRemoveUntil(
              AdminScreens.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    List<Product> productList = [];
    try {
      var res = await http.get(
        Uri.parse(
          '$uri/admin/get-product',
        ),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': context.read<UserProvider>().user.token,
        },
      );
      // log(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
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
    return productList;
  }

  Future<void> deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    try {
      var res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': context.read<UserProvider>().user.token,
        },
        body: jsonEncode({"id": product.id}),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          showSnackbar(context, res.body);
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    List<Order> orderList = [];
    try {
      var res = await http.get(
        Uri.parse(
          '$uri/admin/get-orders',
        ),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': context.read<UserProvider>().user.token,
        },
      );
      // log(res.body);
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

  Future<void> changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    try {
      var res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': context.read<UserProvider>().user.token,
        },
        body: jsonEncode({
          "id": order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    List<Sales> sales = [];
    num totalEarning = 0;
    try {
      var res = await http.get(
        Uri.parse(
          '$uri/admin/analytics',
        ),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          'x-auth-token': context.read<UserProvider>().user.token,
        },
      );
      // log(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales(label: 'Mobiles', earnings: response['mobileEarnings']),
            Sales(
                label: 'Essentials', earnings: response['essentialsEarnings']),
            Sales(
                label: 'Appliances', earnings: response['appliancesEarnings']),
            Sales(label: 'Books', earnings: response['booksEarnings']),
            Sales(label: 'Fashion', earnings: response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackbar(context, "fetch All ${e.toString()}");
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
