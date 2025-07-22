import 'package:bd_mtur/core/utils.dart';
import 'package:bd_mtur/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/models/course_model.dart';

class CardCourse extends StatefulWidget {
  final CourseModel course;
  final Function page;

  const CardCourse({
    Key? key,
    required this.course,
    required this.page,
  }) : super(key: key);

  @override
  State<CardCourse> createState() => _CardCourseState();
}

class _CardCourseState extends State<CardCourse> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 110,
                width: getResponsiveWidth(widthScreen) - 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8), bottom: Radius.zero),
                  image: DecorationImage(
                    image: NetworkImage(widget.course.urlImage),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.zero,
                              bottom: Radius.circular(5),
                            ),
                          ),
                          color: const Color.fromARGB(180, 255, 255, 255),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                            child: Text(
                              dateFormat(widget.course.releaseDate),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          margin: EdgeInsets.all(0),
                          color: AppColors.colorDark,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(0),
                                right: Radius.circular(8)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
                            child: Text(
                              "Curso",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(
                    widget.course.name,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                    maxLines: 3,
                    style: TextStyle(
                      color: AppColors.greyDark,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Text(widget.course.numberOfResources.toString() +
                          " recursos"),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Text(widget.course.workload.toString() + " horas"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Button(
                      title: "Ver Detalhes",
                      backgroundColor: AppColors.colorDark,
                      textColor: AppColors.white,
                      fillText: false,
                      onPressed: () => widget.page(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String dateFormat(DateTime datetime) {
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(datetime);
    return formattedDate;
  }
}
