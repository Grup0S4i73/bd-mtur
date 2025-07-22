import 'dart:io';

import 'package:bd_mtur/core/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bd_mtur/screens/home/continue_content_args_screen.dart';
import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/core.dart';

class ContinueContent extends StatefulWidget {
  static const routeName = '/continueContent';

  const ContinueContent({
    Key? key,
  }) : super(key: key);

  @override
  State<ContinueContent> createState() => _ContinueContentState();
}

class _ContinueContentState extends State<ContinueContent> {
  final UserController _userController = new UserController();
  final LearningObjectController _controller = new LearningObjectController();

  List<LearningObjectModel> listFavorites = [];

  bool selected = false;
  bool _favoritar = false;

  void _onItemTapped() {
    setState(() {
      _favoritar = !_favoritar;
    });
  }

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
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    final arguments = ModalRoute.of(context)!.settings.arguments
        as ContinueContentArgumentsScreen;

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          NavBarTop(
            title: arguments.title,
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      if (arguments.listLearningObject.length == 0) {
                        return Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Nenhum objeto educacional encontrado",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.greyDark,
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: StaggeredGrid.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 2,
                            mainAxisSpacing: getResponsiveWidth(widthScreen) < 400 ? 4 : 3,
                            children: arguments.listLearningObject.map(
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
                        );
                      }
                    },
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
              ),
            ),
          ),
        ],
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
