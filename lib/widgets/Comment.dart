import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_text_styles.dart';
import 'package:bd_mtur/models/comment_model.dart';
import 'package:bd_mtur/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Comment extends StatefulWidget {
  final CommentModel comment;
  final String avatar;

  Comment({required this.avatar, required this.comment});

  @override
  State<Comment> createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  UserController userController = new UserController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Image(
                                image: AssetImage(widget.avatar),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.comment.userName,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColors.greyLightMedium,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Em " + dateFormat(widget.comment.created_at),
                                  style: TextStyle(
                                    color: AppColors.greyLightMedium,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.comment.description,
                                    style: TextStyle(
                                      color: AppColors.greyDark,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            height: 2,
            color: const Color(0xFFf2f4f5),
          ),
        )
      ],
    );
  }

  String dateFormat(DateTime datetime) {
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(datetime);
    return formattedDate;
  }
}
