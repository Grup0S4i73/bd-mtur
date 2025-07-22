import 'dart:io';
import 'package:bd_mtur/core/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/stores/listLearningObjectStore.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/core/app_widgets.dart';

class Topics extends StatefulWidget {
  static final routeName = "/topics";

  Topics();

  @override
  State<Topics> createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<LearningObjectModel> listFavorites = [];
  ListLearningObjectStore listLearningObjectStore =
      new ListLearningObjectStore();

  final UserController _userController = new UserController();
  LearningObjectController _controller = new LearningObjectController();

  getAllFavorites() async {
    try {
      return await _controller.getAllFavorites();
    } on DioException catch (e) {
      errorConection(context);
      throw e.error!;
    } on IOException catch (e) {
      errorConection(context);
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  getAllLearningObject(int id) async {
    return await _controller.getLearningObjectOfTopic(id);
  }

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    var verifyToken = await _userController.verifyToken();

    return token != null && verifyToken;
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus().then((isLogged) {
      if (isLogged) {
        getAllFavorites().then((data) async {
          setState(() {
            listFavorites = data;
            final arguments = ModalRoute.of(context)!.settings.arguments
                as TopicsArgumentsScreen;
            getAllLearningObject(arguments.id).then((data) async {
              listLearningObjectStore.setList(data, listFavorites, "");
            });
          });
        });
      } else {
        final arguments =
            ModalRoute.of(context)!.settings.arguments as TopicsArgumentsScreen;
        getAllLearningObject(arguments.id).then((data) async {
          listLearningObjectStore.setList(data, listFavorites, "");
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _refresh() {
    listLearningObjectStore.clear();
    return checkLoginStatus().then((isLogged) {
      if (isLogged) {
        getAllFavorites().then((data) async {
          setState(() {
            listFavorites = data;
            final arguments = ModalRoute.of(context)!.settings.arguments
                as TopicsArgumentsScreen;
            getAllLearningObject(arguments.id).then((data) async {
              listLearningObjectStore.setList(data, listFavorites, "");
            });
          });
        });
      } else {
        final arguments =
            ModalRoute.of(context)!.settings.arguments as TopicsArgumentsScreen;
        getAllLearningObject(arguments.id).then((data) async {
          listLearningObjectStore.setList(data, listFavorites, "");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    final arguments =
        ModalRoute.of(context)!.settings.arguments as TopicsArgumentsScreen;

    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            NavBarTop(
              title: arguments.title,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Observer(builder: (_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      listLearningObjectStore.listLearningObject.isEmpty
                          ? Center(
                              child: ProgressBarIndicator(),
                            )
                          : listLearningObjectStore.listLearningObject.isEmpty
                              ? Container(
                                  alignment: Alignment.center,
                                  padding:
                                      EdgeInsets.only(top: 100, bottom: 100),
                                  child: Text(
                                    "Nenhum objeto educacional encontrado",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.greyDark,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                  child: StaggeredGrid.count(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: getResponsiveWidth(widthScreen) < 400 ? 4 : 3,
                                    children: listLearningObjectStore
                                        .listLearningObject
                                        .map(
                                      (learningObject) {
                                        return StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount:
                                              getResponsiveWidth(widthScreen) < 400 ? 1.6 : 1.2,
                                          child: CardConteudo(
                                            data: learningObject,
                                            addFavorite: () {},
                                            removeFavorite: () {},
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Button(
                              title: "Voltar",
                              backgroundColor: AppColors.colorDark,
                              textColor: AppColors.white,
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(context);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isFavorite(List<LearningObjectModel> listFavorites,
      LearningObjectModel learningObject) {
    for (LearningObjectModel learningObjectAux in listFavorites) {
      if (learningObjectAux.id == learningObject.id) return true;
    }
    return false;
  }
}
