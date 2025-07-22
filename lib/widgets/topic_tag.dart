import 'package:bd_mtur/core/utils.dart';
import 'package:flutter/material.dart';

import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_screens.dart';

class TopicTag extends StatelessWidget {
  final int id;
  final String textTag;

  TopicTag({required this.id, required this.textTag});

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white30, backgroundColor: AppColors.colorDark,
        fixedSize:
            Size(getResponsiveWidth(widthScreen) - 40, double.infinity),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, Topics.routeName,
            arguments: TopicsArgumentsScreen(id, textTag));
      },
      child: Text(
        textTag,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
