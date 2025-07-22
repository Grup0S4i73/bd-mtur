import 'dart:io';
import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/core/utils.dart';
import 'package:diacritic/diacritic.dart';
import 'package:bd_mtur/controllers/sponsor_controller.dart';
import 'package:bd_mtur/controllers/topic_interest_controller.dart';
import 'package:bd_mtur/models/sponsor_model.dart';
import 'package:bd_mtur/models/topic_interest_model.dart';
import 'package:bd_mtur/stores/listLearningObjectStore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final UserController _userController = new UserController();
  final SponsorController _controllerSponsor = new SponsorController();
  final TopicInterestController _controllerTopics =
      new TopicInterestController();
  final LearningObjectController _controllerLearningObject =
      new LearningObjectController();

  List<LearningObjectModel> listFavorites = [];
  List<Map<String, dynamic>> listObjectsOfTopics = [];
  List<SponsorModel> listSponsors = [];
  ListLearningObjectStore listLearningObject = ListLearningObjectStore();

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

  getSponsors() async {
    return await _controllerSponsor.getSponsors();
  }

  getTopFiveEducationalObjects() async {
    return await _controllerLearningObject.getTopFiveEducationalObjects();
  }

  Future<List<TopicInterestModel>> getAllTopics() async {
    return await _controllerTopics.getAllTopicInterest();
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
          getTopFiveEducationalObjects().then((data) async {
            listLearningObject.setList(data, listFavorites, "");
          });
        });
      } else {
        getTopFiveEducationalObjects().then((data) async {
          listLearningObject.setList(data, listFavorites, "");
        });
      }
    });
    getSponsors().then((data) async {
      setState(() {
        listSponsors = data;
      });
    });
    getAllTopics().then((topics) {
      topics.forEach((topic) async {
        _controllerLearningObject.getLearningObjectOfTopic(topic.id).then((
          list,
        ) {
          if (list.isNotEmpty) {
            setState(() {
              listObjectsOfTopics.add({
                'id': topic.id,
                'tipo': topic.name,
                'list': list,
              });

              listObjectsOfTopics.sort(
                (a, b) =>
                    removeDiacritics(a['tipo'].toLowerCase()).compareTo(
                              removeDiacritics(b['tipo'].toLowerCase()),
                            ) <
                            0
                        ? -1
                        : 1,
              );
            });
          }
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _refresh() async {
    listFavorites.clear();
    listLearningObject.clear();
    listObjectsOfTopics.clear();
    listSponsors.clear();
    checkLoginStatus().then((isLogged) {
      if (isLogged) {
        getAllFavorites().then((data) async {
          setState(() {
            listFavorites = data;
          });
          getTopFiveEducationalObjects().then((data) async {
            listLearningObject.setList(data, listFavorites, "");
          });
        });
      } else {
        getTopFiveEducationalObjects().then((data) async {
          listLearningObject.setList(data, listFavorites, "");
        });
      }
    });
    getSponsors().then((data) async {
      setState(() {
        listSponsors = data;
      });
    });
    getAllTopics().then((topics) {
      topics.forEach((topic) async {
        _controllerLearningObject.getLearningObjectOfTopic(topic.id).then((
          list,
        ) {
          if (list.isNotEmpty) {
            setState(() {
              listObjectsOfTopics.add({
                'id': topic.id,
                'tipo': topic.name,
                'list': list,
              });

              listObjectsOfTopics.sort(
                (a, b) =>
                    removeDiacritics(a['tipo'].toLowerCase()).compareTo(
                              removeDiacritics(b['tipo'].toLowerCase()),
                            ) <
                            0
                        ? -1
                        : 1,
              );
            });
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "Turismo Acessível",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.colorDark,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacing(),
                Row(
                  children: [
                    Container(
                      height: 160,
                      width: getResponsiveWidth(widthScreen) - 40,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              Image.asset(
                                AppImages.banner,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Icon(Icons.error),
                              ).image,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacing(),
                Row(
                  children: [
                    Text(
                      "Descrição",
                      style: TextStyle(
                        color: AppColors.colorDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Spacing(padding: 10),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Nesta biblioteca você encontrará recursos que abordam aspectos sobre políticas públicas de inclusão e acessibilidade fundamentadas na diversidade e turismo acessível voltado para pessoas com deficiência e ou com mobilidade reduzida.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: AppColors.greyDark,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacing(),
                listObjectsOfTopics.isEmpty
                    ? const ProgressBarIndicator()
                    : Row(
                      children: [
                        Text(
                          "Materiais Disponíveis",
                          style: TextStyle(
                            color: AppColors.colorDark,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                Spacing(padding: 10),
                listObjectsOfTopics.isEmpty
                    ? const Center()
                    : Column(
                      children:
                          listObjectsOfTopics.map((objectType) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: CardAmountResources(
                                    descricao: objectType['tipo'],
                                    textColor: AppColors.colorDark,
                                    backgroundColor: AppColors.colorLight,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Topics.routeName,
                                        arguments: TopicsArgumentsScreen(
                                          objectType['id'],
                                          objectType['tipo'],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: CardAmountResources(
                                    descricao:
                                        objectType['list'].isNotEmpty
                                            ? objectType['list'].length
                                                .toString()
                                            : "0",
                                    textColor: AppColors.white,
                                    backgroundColor: AppColors.colorDark,
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        Topics.routeName,
                                        arguments: TopicsArgumentsScreen(
                                          objectType['id'],
                                          objectType['tipo'],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                Spacing(),
                listSponsors.isEmpty
                    ? const Center()
                    : Row(
                      children: [
                        Text(
                          "Apoio Institucional",
                          style: TextStyle(
                            color: AppColors.colorDark,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                listSponsors.isEmpty
                    ? const Center()
                    : StaggeredGrid.count(
                      crossAxisCount: 1,
                      crossAxisSpacing: 1,
                      children:
                          listSponsors.map((sponsor) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Text(
                                    sponsor.name,
                                    style: AppTextStyles.labelContentText,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      backgroundColor: AppColors.colorDark,
                                    ),
                                    onPressed: () {
                                      popUpApoio(sponsor.url);
                                    },
                                    child: Text(
                                      "Ver Mais",
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                    ),
                Spacing(),
                listObjectsOfTopics.isEmpty
                    ? const Center()
                    : Row(
                      children: [
                        Text(
                          "Top 5 Recursos",
                          style: TextStyle(
                            color: AppColors.colorDark,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                Spacing(padding: 10),
                Observer(
                  builder: (_) {
                    return listLearningObject.listLearningObject.isEmpty
                        ? Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Nenhum recurso até agora foi avaliado",
                                style: TextStyle(
                                  color: AppColors.greyDark,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                        : Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: StaggeredGrid.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: widthScreen < 400 ? 4 : 3,
                            children:
                                listLearningObject.listLearningObject.map((
                                  learningObject,
                                ) {
                                  return StaggeredGridTile.count(
                                    crossAxisCellCount: 1,
                                    mainAxisCellCount:
                                        widthScreen < 400 ? 1.6 : 1.2,
                                    child: CardConteudo(
                                      data: learningObject,
                                      addFavorite: () {},
                                      removeFavorite: () {},
                                    ),
                                  );
                                }).toList(),
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  popUpApoio(String url) async {
    return PopUpAccess(
      context: context,
      title: "Abrir link externo",
      message:
          "Você está prestes a sair do aplicativo e visitar um link externo. Tem certeza que deseja sair desta tela para acessar o link?",
      url: url,
    );
  }

  errorConection(BuildContext context, Function onPressed) {
    PopUpErrorConnection(context, onPressed: onPressed);
  }
}
