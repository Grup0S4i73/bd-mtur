// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables
// todo: favoritar com bug, ciclo de download, timer avaliação
import 'package:bd_mtur/screens/content/content_screen_args_screen.dart';
import 'package:bd_mtur/stores/favoriteStore.dart';
import 'package:flutter/material.dart';

import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/models/learning_object_model.dart';

class Content extends StatefulWidget {
  static const routeName = "/content";
  Content();

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ContentArgumentsScreen;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              NavBarTop(
                  title: arguments.learningObject.learningObject.shortName),
              TabBar(
                  indicatorColor: AppColors.colorDark,
                  labelColor: AppColors.colorDark,
                  unselectedLabelColor: AppColors.greyDark,
                  labelStyle: AppTextStyles.labelTabControllerActive,
                  unselectedLabelStyle: AppTextStyles.labelTabController,
                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                  tabs: const [
                    Tab(
                      text: "Detalhes",
                    ),
                    Tab(
                      text: "Avaliação",
                    ),
                    // Tab(
                    //   text: "Anotações",
                    // )
                  ]),
              Expanded(
                child: TabBarView(
                  children: [
                    Details(
                      arguments.learningObject,
                      arguments.addFavorite!,
                      arguments.removeFavorite!,
                    ),
                    Avaliation(arguments.learningObject.learningObject),
                    // Notes(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: todo
  //TODO: criar popup de acesso ao recurso

}
