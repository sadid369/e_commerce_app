// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatefulWidget {
  final double rating;
  const Stars({
    Key? key,
    required this.rating,
  }) : super(key: key);

  @override
  _StarsState createState() => _StarsState();
}

class _StarsState extends State<Stars> {
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5,
      rating: widget.rating,
      itemSize: 15,
      itemBuilder: (context, index) {
        return const Icon(
          Icons.star,
          color: GlobalVariables.secondaryColor,
        );
      },
    );
  }
}
