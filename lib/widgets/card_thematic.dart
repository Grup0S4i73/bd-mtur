import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/models/topic_interest_model.dart';
import 'package:flutter/material.dart';

class CardThematic extends StatefulWidget {
  final TopicInterestModel data;

  CardThematic({required this.data});

  @override
  _CardThematicState createState() => _CardThematicState();
}

class _CardThematicState extends State<CardThematic> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(0, 20, 0, 20)),
          backgroundColor: MaterialStateProperty.all(
            AppColors.white,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: AppColors.greyDark),
          ),
          overlayColor: MaterialStateProperty.all(
            selected ? AppColors.greyDark : AppColors.yellowStar,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(
                      "",
                    ),
                    width: 35,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      widget.data.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
