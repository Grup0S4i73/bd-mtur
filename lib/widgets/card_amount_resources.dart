import 'package:flutter/material.dart';

import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_icons.dart';

class CardAmountResources extends StatefulWidget {
  final String descricao;
  final Color textColor;
  final Color backgroundColor;
  final Function onPressed;

  CardAmountResources({
    Key? key,
    required this.descricao,
    required this.textColor,
    required this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CardAmountResources> createState() => _CardAmountResourcesState();
}

class _CardAmountResourcesState extends State<CardAmountResources> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        color: widget.backgroundColor,
        child: InkWell(
          onTap: () {
            widget.onPressed();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  widget.descricao,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: widget.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
