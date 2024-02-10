// import 'dart:convert';

// // ignore_for_file: public_member_api_docs, sort_constructors_first
// class Product {
//   final String name;
//   final String description;
//   final double quantity;
//   final List<String> images;
//   final String category;
//   final double price;
//   final String? id;
//   Product({
//     required this.name,
//     required this.description,
//     required this.quantity,
//     required this.images,
//     required this.category,
//     required this.price,
//     this.id,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'name': name,
//       'description': description,
//       'quantity': quantity,
//       'images': images,
//       'category': category,
//       'price': price,
//       'id': id,
//     };
//   }

// factory Product.fromMap(Map<String, dynamic> map) {
//   return Product(
//     name: map['name'] as String,
//     description: map['description'] as String,
//     quantity: map['quantity'] as double,
//     images: List<String>.from(map['images']),
//     category: map['category'] as String,
//     price: map['price'] as double,
//     id: map['_id'] != null ? map['_id'] as String : null,
//   );
// }

//   String toJson() => json.encode(toMap());

//   factory Product.fromJson(String source) =>
//       Product.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'Product(name: $name, description: $description, quantity: $quantity, images: $images, category: $category, price: $price, id: $id)';
//   }
// }
import 'dart:convert';

class Product {
  final String name;
  final String description;
  final num quantity;
  final List<String> images;
  final String category;
  final num price;
  final String? id;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] as num,
      images: List<String>.from(map['images']),
      category: map['category'] ?? '',
      price: map['price'] as num,
      id: map['_id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
