import 'package:bd_mtur/core/core.dart';
import 'package:flutter/material.dart';

class CardTopicNonSelectable extends StatefulWidget {
  final String image;
  final String title;

  CardTopicNonSelectable({required this.image, required this.title});

  @override
  _CardTopicNonSelectableState createState() => _CardTopicNonSelectableState();
}

class _CardTopicNonSelectableState extends State<CardTopicNonSelectable> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
            child: TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(AppColors.greyLight),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                side: MaterialStateProperty.all(
                  BorderSide(color: AppColors.greyLight),
                ),
                overlayColor: MaterialStateProperty.all(AppColors.greyLight),
              ),
              child: Row(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Image.asset(widget.image, width: 35),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.black),
                  ),
                )
              ]),
              onPressed: () {},
            ),
          )),
    );
  }
}
