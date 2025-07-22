import 'package:bd_mtur/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../screens/home/home_screen.dart';

class NavBarTop extends StatefulWidget {
  final String title;
  final bool action;
  final String actions;
  Function? actionsPressed;
  final String? page;

  NavBarTop({
    required this.title,
    this.action = false,
    this.actions = '',
    this.actionsPressed,
    this.page,
  });

  @override
  State<NavBarTop> createState() => _NavBarTopState();
}

class _NavBarTopState extends State<NavBarTop> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.colorDark,
      centerTitle: true,
      foregroundColor: AppColors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          if (widget.page == null) {
            Navigator.of(context, rootNavigator: false).pop(context);
          } else {
            Navigator.pushNamed(context, widget.page!);
          }
        },
      ),
      title: Text(
        widget.title,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
      ),
      actions: widget.action
          ? [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.greyLight, backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: () {
                  if (widget.actionsPressed != null) {
                    widget.actionsPressed!();
                  }
                },
                child: Text(
                  widget.actions,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ]
          : [],
    );
  }
}
