import 'dart:io';

import 'package:bd_mtur/core/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_widgets.dart';

import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/controllers/topic_interest_controller.dart';
import 'package:bd_mtur/models/topic_interest_model.dart';
import 'package:bd_mtur/screens/home/continue_content_args_screen.dart';
import 'package:bd_mtur/stores/listLearningObjectStore.dart';

class CategoriesResources extends StatefulWidget {
  static const routeName = '/categories';

  const CategoriesResources({Key? key}) : super(key: key);

  @override
  State<CategoriesResources> createState() => _CategoriesResourcesState();
}

class _CategoriesResourcesState extends State<CategoriesResources> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final UserController _userController = new UserController();
  final LearningObjectController _controllerLearningObject =
      new LearningObjectController();
  final TopicInterestController _controllerTopicInterest =
      new TopicInterestController();

  List<LearningObjectModel> listFavorites = [];
  List<ListLearningObjectStore> listLearningObjectTopics = [];
  ListLearningObjectStore listVisited = new ListLearningObjectStore();
  List<TopicInterestModel> listTopics = [];

  getAllTopics() async {
    final list = await _controllerTopicInterest.getAllTopicInterest();
    list.sort(
      (a, b) =>
          a.name.toLowerCase().compareTo(b.name.toLowerCase()) < 0 ? -1 : 1,
    );
    return list;
  }

  getAllFavorites() async {
    try {
      return await _controllerLearningObject.getAllFavorites();
    } on DioException catch (e) {
      errorConection(context, () {
        _refreshIndicatorKey.currentState!.show();
      });
      throw e.error!;
    } on IOException catch (e) {
      errorConection(context, () {
        _refreshIndicatorKey.currentState!.show();
      });
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  getAllVisited() async {
    return await _controllerLearningObject.getAllVisited();
  }

  getAllLearningObjectFromTopic(int id) async {
    return await _controllerLearningObject.getLearningObjectOfTopic(id);
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
          });
          getAllVisited().then((data) {
            listVisited.setList(data, listFavorites, "");
          });
          getAllTopics().then((data) {
            setState(() {
              listTopics = data;
            });
            for (var i = 0; i < listTopics.length; i++) {
              getAllLearningObjectFromTopic(listTopics[i].id).then((data) {
                setState(() {
                  var aux = new ListLearningObjectStore();
                  aux.setList(data, listFavorites, listTopics[i].name);
                  listLearningObjectTopics.add(aux);
                });
              });
            }
          });
        });
      } else {
        getAllTopics().then((data) {
          setState(() {
            listTopics = data;
          });
          for (var i = 0; i < listTopics.length; i++) {
            getAllLearningObjectFromTopic(listTopics[i].id).then((data) {
              setState(() {
                var aux = new ListLearningObjectStore();
                aux.setList(data, listFavorites, listTopics[i].name);
                listLearningObjectTopics.add(aux);
              });
            });
          }
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _refresh() async {
    listVisited.clear();
    listLearningObjectTopics.clear();
    listFavorites.clear();
    listTopics.clear();
    checkLoginStatus().then((isLogged) {
      if (isLogged) {
        getAllFavorites().then((data) async {
          setState(() {
            listFavorites = data;
          });
          getAllVisited().then((data) {
            listVisited.setList(data, listFavorites, "");
          });
          getAllTopics().then((data) {
            setState(() {
              listTopics = data;
            });
            for (var i = 0; i < listTopics.length; i++) {
              getAllLearningObjectFromTopic(listTopics[i].id).then((data) {
                setState(() {
                  var aux = new ListLearningObjectStore();
                  aux.setList(data, listFavorites, listTopics[i].name);
                  listLearningObjectTopics.add(aux);
                });
              });
            }
          });
        });
      } else {
        getAllTopics().then((data) {
          setState(() {
            listTopics = data;
          });
          for (var i = 0; i < listTopics.length; i++) {
            getAllLearningObjectFromTopic(listTopics[i].id).then((data) {
              setState(() {
                var aux = new ListLearningObjectStore();
                aux.setList(data, listFavorites, listTopics[i].name);
                listLearningObjectTopics.add(aux);
              });
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Observer(
          builder: (_) {
            return ListView(
              children:
                  listVisited.listLearningObject.isEmpty &&
                          listFavorites.isEmpty &&
                          listLearningObjectTopics.isEmpty &&
                          listTopics.isEmpty
                      ? [
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(top: 100),
                          child: ProgressBarIndicator(),
                        ),
                      ]
                      : <Widget>[
                        listVisited.listLearningObject.isEmpty
                            ? Center()
                            : Container(
                              child: Column(
                                children: [
                                  Spacing(),
                                  Row(
                                    children: [
                                      Text(
                                        "Continuar conteúdo",
                                        style: TextStyle(
                                          color: AppColors.colorDark,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  StaggeredGrid.count(
                                    crossAxisCount: 5,
                                    crossAxisSpacing: 4,
                                    mainAxisSpacing: 4,
                                    children: [
                                      StaggeredGridTile.count(
                                        crossAxisCellCount: 2,
                                        mainAxisCellCount:
                                            getResponsiveWidth(widthScreen) <
                                                    400
                                                ? 3.8
                                                : 3.5,
                                        child: CardConteudo(
                                          data: listVisited.listLearningObject
                                              .elementAt(0),
                                          addFavorite: () {},
                                          removeFavorite: () {},
                                        ),
                                      ),
                                      StaggeredGridTile.count(
                                        crossAxisCellCount: 2,
                                        mainAxisCellCount:
                                            getResponsiveWidth(widthScreen) <
                                                    400
                                                ? 3.8
                                                : 3.5,
                                        child: CardConteudo(
                                          data: listVisited.listLearningObject
                                              .elementAt(1),
                                          addFavorite: () {},
                                          removeFavorite: () {},
                                        ),
                                      ),
                                      if (listVisited
                                              .listLearningObject
                                              .length >=
                                          3)
                                        StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount:
                                              getResponsiveWidth(widthScreen) <
                                                      400
                                                  ? 3.8
                                                  : 3.5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.add_circle_outline,
                                                  size: 40,
                                                  color: AppColors.colorDark,
                                                ),
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    "/continueContent",
                                                    arguments:
                                                        ContinueContentArgumentsScreen(
                                                          "Continuar Conteúdo",
                                                          listVisited
                                                              .listLearningObject,
                                                        ),
                                                  );
                                                },
                                              ),
                                              Text(
                                                "Ver mais",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.colorDark,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                        for (
                          var i = 0;
                          i < listLearningObjectTopics.length;
                          i++
                        )
                          listLearningObjectTopics.isEmpty ||
                                  listLearningObjectTopics[i]
                                      .listLearningObject
                                      .isEmpty
                              ? Center()
                              : Container(
                                child: Column(
                                  children: [
                                    Spacing(),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            listLearningObjectTopics[i]
                                                .name_topic,
                                            style: TextStyle(
                                              color: AppColors.colorDark,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    listLearningObjectTopics[i]
                                            .listLearningObject
                                            .isEmpty
                                        ? Center()
                                        : StaggeredGrid.count(
                                          crossAxisCount: 5,
                                          crossAxisSpacing: 4,
                                          mainAxisSpacing: 4,
                                          children: [
                                            StaggeredGridTile.count(
                                              crossAxisCellCount: 2,
                                              mainAxisCellCount:
                                                  getResponsiveWidth(
                                                            widthScreen,
                                                          ) <
                                                          400
                                                      ? 4
                                                      : 3.5,
                                              child: CardConteudo(
                                                data:
                                                    listLearningObjectTopics[i]
                                                        .listLearningObject
                                                        .elementAt(0),
                                                addFavorite: () {},
                                                removeFavorite: () {},
                                              ),
                                            ),
                                            if (listLearningObjectTopics[i]
                                                    .listLearningObject
                                                    .length >=
                                                3)
                                              StaggeredGridTile.count(
                                                crossAxisCellCount: 2,
                                                mainAxisCellCount:
                                                    getResponsiveWidth(
                                                              widthScreen,
                                                            ) <
                                                            400
                                                        ? 4
                                                        : 3.5,
                                                child: CardConteudo(
                                                  data:
                                                      listLearningObjectTopics[i]
                                                          .listLearningObject
                                                          .elementAt(1),
                                                  addFavorite: () {},
                                                  removeFavorite: () {},
                                                ),
                                              ),
                                            if (listLearningObjectTopics[i]
                                                    .listLearningObject
                                                    .length >=
                                                3)
                                              StaggeredGridTile.count(
                                                crossAxisCellCount: 1,
                                                mainAxisCellCount:
                                                    getResponsiveWidth(
                                                              widthScreen,
                                                            ) <
                                                            400
                                                        ? 4
                                                        : 3.5,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons
                                                            .add_circle_outline,
                                                        size: 40,
                                                        color:
                                                            AppColors.colorDark,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                          context,
                                                          "/continueContent",
                                                          arguments: ContinueContentArgumentsScreen(
                                                            listLearningObjectTopics[i]
                                                                .name_topic,
                                                            listLearningObjectTopics[i]
                                                                .listLearningObject,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                    Text(
                                                      "Ver mais",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            AppColors.colorDark,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        ),
                                  ],
                                ),
                              ),
                      ],
            );
          },
        ),
      ),
    );
  }

  errorConection(BuildContext context, Function onPressed) {
    PopUpErrorConnection(context, onPressed: onPressed);
  }
}
