import 'package:bd_mtur/core/app_icons.dart';
import 'package:flutter/material.dart';

import 'package:bd_mtur/core/app_colors.dart';

class CardResourcesObjectType extends StatefulWidget {
  final String tipo;
  final int quantidade;
  final Function onPressed;

  CardResourcesObjectType({
    Key? key,
    required this.tipo,
    required this.quantidade,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CardResourcesObjectType> createState() => _CardResourcesObjectTypeState();
}

class _CardResourcesObjectTypeState extends State<CardResourcesObjectType> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.colorLight,
      child: InkWell(
        onTap: () {
          widget.onPressed();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.colorVeryDark,
                  ),
                  child: ImageIcon(
                    AssetImage(
                      objectTypeSelect(widget.tipo),
                    ),
                    color: AppColors.white,
                    size: 15,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.tipo,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                      color: AppColors.colorDark,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.quantidade.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.colorDark,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  objectTypeSelect(String object_type) {
    if (object_type == "PDF") return AppIcons.pdf_resource;
    if (object_type == "Podcast") return AppIcons.audiotrack_resource;
    if (object_type == "EBook" ||
        object_type == "Ebook" ||
        object_type == "E-book") return AppIcons.ebook_resource;
    if (object_type == "Game Case") return AppIcons.game_case_resource;
    if (object_type == "Infográfico") return AppIcons.infographic_resource;
    if (object_type == "Vídeo") return AppIcons.video_resource;
    if (object_type == "Recurso Multimídia") return AppIcons.multimidia_resource;
  }
}
