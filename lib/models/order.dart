// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:e_commerce_app/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<num> quantity;
  final String address;
  final String userId;
  final num orderedAt;
  final num status;
  final num totalPrice;
  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.orderedAt,
    required this.status,
    required this.totalPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'orderedAt': orderedAt,
      'status': status,
      'totalPrice': totalPrice,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] as String,
      products: List<Product>.from(
        map['products']?.map(
          (x) => Product.fromMap(x['product']),
        ),
      ),
      quantity: List<num>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      address: map['address'] as String,
      userId: map['userId'] as String,
      orderedAt: map['orderedAt'] as num,
      status: map['status'] as num,
      totalPrice: map['totalPrice'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);
}
