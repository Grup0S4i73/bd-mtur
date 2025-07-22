import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/utils.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/screens/content/content_screen_args_screen.dart';
import 'package:bd_mtur/stores/favoriteStore.dart';
import 'package:flutter/material.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_screens.dart';

class CardContentLong extends StatefulWidget {
  final LearningObjectModel data;
  final bool favorite;
  final Function addFavorite;
  final Function removeFavorite;

  CardContentLong(
      {required this.data,
      required this.favorite,
      required this.addFavorite,
      required this.removeFavorite});

  @override
  State<CardContentLong> createState() => _CardContentLongState();
}

class _CardContentLongState extends State<CardContentLong>
    with TickerProviderStateMixin {
  late AnimationController controller;

  double _currentSliderValue = 20;
  bool selected = false;
  bool _favoritar = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);

    super.initState();
  }

  void _onItemTapped() {
    setState(() {
      _favoritar = !_favoritar;
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Card(
                  borderOnForeground: true,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.data.urlImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 5, 2, 10),
                              child: InkWell(
                                onTap: _onItemTapped,
                                child: Image(
                                  image: AssetImage(
                                    _favoritar
                                        ? AppIcons.favoritarfillicon
                                        : AppIcons.favoritaricon,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(2, 5, 5, 10),
                              child: Image(
                                image: AssetImage(
                                  AppIcons.informacaoicon,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 60),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/content",
                                arguments: ContentArgumentsScreen(
                                    FavoriteStore(widget.data, widget.favorite),
                                    widget.addFavorite,
                                    widget.removeFavorite),
                              );
                            },
                            child: Image(
                              image: AssetImage(
                                AppIcons.clickicon,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 5, 5),
                        child: Text(
                          widget.data.fullName,
                          style: AppTextStyles.labelBoldTextBox,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                      child: Text(
                        "Minitério do Turismo",
                        style: AppTextStyles.bodyGreySubtitle,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                      child: Text(
                        "Progresso 74%",
                        style: AppTextStyles.bodyGreySubtitle,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: getResponsiveWidth(widthScreen) * 0.5,
                      padding: EdgeInsets.all(10),
                      child: LinearProgressIndicator(
                        value: 0.74,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                      child: Text(
                        "24m | 136 MB",
                        style: AppTextStyles.bodyGreySubtitle,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                  child: Row(
                    children: [
                      Button(
                        title: "Remover",
                        backgroundColor: AppColors.colorDark,
                        textColor: Colors.white,
                        fillText: false,
                        onPressed: () {},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Button(
                        title: "Acessar",
                        backgroundColor: AppColors.colorDark,
                        textColor: Colors.white,
                        fillText: false,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
