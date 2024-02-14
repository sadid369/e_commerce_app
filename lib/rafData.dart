import 'dart:convert';
import 'dart:developer';

import 'package:e_commerce_app/models/rating.dart';

dynamic ratingMap =
    '[{"userId":"123","rating":4},{ "userId":"125","rating":3}]';

List<Rating> rating = List<Rating>.from(
    (jsonDecode(ratingMap) as List<dynamic>).map((e) => Rating.fromMap(e)));

void main(List<String> args) {
  print(rating.toString());
}
