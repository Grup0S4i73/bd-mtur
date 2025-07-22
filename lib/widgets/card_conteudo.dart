// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'package:bd_mtur/core/utils.dart';
import 'package:bd_mtur/screens/content/content_screen_args_screen.dart';
import 'package:bd_mtur/stores/favoriteStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:bd_mtur/core/core.dart';

class CardConteudo extends StatefulWidget {
  final FavoriteStore data;
  final Function? addFavorite;
  final Function? removeFavorite;

  CardConteudo({
    Key? key,
    required this.data,
    this.removeFavorite = null,
    this.addFavorite = null,
  }) : super(key: key);

  @override
  State<CardConteudo> createState() => _CardConteudoState();
}

class _CardConteudoState extends State<CardConteudo> {
  bool selected = false;

  _objectTypeSelect(int object_type) {
    if (object_type == 1) return AppIcons.pdf_resource;
    if (object_type == 2) return AppIcons.ebook_resource;
    if (object_type == 3) return AppIcons.game_case_resource;
    if (object_type == 4) return AppIcons.infographic_resource;
    if (object_type == 5) return AppIcons.audiotrack_resource;
    if (object_type == 6) return AppIcons.video_resource;
    if (object_type == 7) return AppIcons.multimidia_resource;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => _navigateToContent(),
        child: Card(
          borderOnForeground: true,
          color: AppColors.colorVeryLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              _imageSection(),
              _starScoreSection(),
              _resourceTitleSection(),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToContent() {
    Navigator.pushNamed(
      context,
      "/content",
      arguments: ContentArgumentsScreen(
        widget.data,
        widget.addFavorite ?? () {},
        widget.removeFavorite ?? () {},
      ),
    ).then((_) {
      setState(() {});
    });
  }

  _favoriteIcon() {
    var border = BorderRadius.only(
      topLeft: Radius.circular(8),
      bottomLeft: Radius.circular(8),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
          child: Observer(
            builder: (_) {
              return Container(
                decoration: BoxDecoration(
                  color:
                      widget.data.isFavorite
                          ? AppColors.greyDark
                          : Colors.transparent,
                  borderRadius: border,
                ),
                child: Icon(
                  Icons.favorite,
                  color:
                      widget.data.isFavorite
                          ? AppColors.redError
                          : Colors.transparent,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  _imageSection() {
    var decorate = BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(8),
        topLeft: Radius.circular(8),
      ),
      image: DecorationImage(
        image: NetworkImage(widget.data.learningObject.urlImage),
        fit: BoxFit.cover,
      ),
    );

    return Container(
      height: 100,
      decoration: decorate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _favoriteIcon(),
          Padding(
            padding: EdgeInsets.all(0),
            child: Image(image: AssetImage(AppIcons.clickicon)),
          ),
        ],
      ),
    );
  }

  _starScoreSection() {
    var learningObjectTypeIcon = Column(
      children: [
        ImageIcon(
          AssetImage(
            _objectTypeSelect(widget.data.learningObject.objectTypeId),
          ),
          color: AppColors.colorDark,
          size: 20,
        ),
      ],
    );

    var starIcon = Image(
      width: 20,
      image: AssetImage(AppImages.staravaliationfill),
    );

    var averageGrade = Padding(
      padding: EdgeInsets.only(left: 4),
      child: Text(
        widget.data.learningObject.averageGrade.toStringAsFixed(2),
        style: TextStyle(
          color: AppColors.greyDark,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(children: [starIcon, averageGrade]),
            ],
          ),
          learningObjectTypeIcon,
        ],
      ),
    );
  }

  _fontSize(String shortName) {
    final widthScreen = MediaQuery.of(context).size.width;

    if (getResponsiveWidth(widthScreen) < 350) {
      if (shortName.length > 20) {
        return 12.0;
      } else {
        return 14.0;
      }
    } else {
      return 16.0;
    }
  }

  _resourceTitleSection() {
    final shortName = widget.data.learningObject.shortName;

    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              shortName,
              textAlign: TextAlign.center,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: AppColors.greyDark,
                fontSize: _fontSize(shortName),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
