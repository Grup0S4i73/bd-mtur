import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/main.dart';
import 'package:flutter/material.dart';

import '../models/topic_interest_model.dart';

class CardTopic extends StatefulWidget {
  final TopicInterestModel data;
  final Function saved;
  final Function removed;

  const CardTopic(
      {Key? key,
      required this.data,
      required this.saved,
      required this.removed})
      : super(key: key);

  @override
  _CardTopicState createState() => _CardTopicState();
}

class _CardTopicState extends State<CardTopic> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(0, 20, 0, 20)),
          backgroundColor: MaterialStateProperty.all(
            selected ? AppColors.yellowStar : AppColors.yellowStar,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: AppColors.greyLight),
          ),
          overlayColor: MaterialStateProperty.all(
            selected ? AppColors.greyLight : AppColors.yellowStar,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Image(
                image: AssetImage(
                  "",
                ),
                width: 35,
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
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
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            selected = !selected;
          });
          if (selected)
            widget.saved();
          else
            widget.removed();
        },
      ),
    );
  }
}
