// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Spacing extends StatelessWidget {
  final double padding;
  Spacing({
    Key? key,
    this.padding = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: padding,
    );
  }
}
