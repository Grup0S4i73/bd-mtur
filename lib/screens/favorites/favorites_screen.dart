import 'dart:io';

import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/core/utils.dart';
import 'package:bd_mtur/stores/listLearningObjectStore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  final _formKey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  bool? isLoggedHere;
  bool controllPage = false;

  final UserController userController = new UserController();
  final LearningObjectController _controllerLearningObject =
      new LearningObjectController();

  ListLearningObjectStore listFavoritesStore = new ListLearningObjectStore();
  ListLearningObjectStore filteredFavoritesStore =
      new ListLearningObjectStore();

  String filterBy = "Todos";
  String orderBy = "Avaliação";
  List<String> filters = [
    "Todos",
    "PDF",
    "Infográfico",
    "Ebook",
  ];

  List<String> orders = [
    "Avaliação",
    "Nome",
  ];

  getLearningObject() async {
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

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');

    var verifyToken = await userController.verifyToken();

    return token != null && verifyToken;
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus().then((isLogged) {
      if (isLogged) {
        setState(() {
          isLoggedHere = true;
        });
        getLearningObject().then((data) async {
          listFavoritesStore.setFavorites(data);
          filteredFavoritesStore.setFavorites(data);
          filteredFavoritesStore.listLearningObject =
              filteredFavoritesStore.search("", filterBy, orderBy);
          setState(() {
            controllPage = true;
          });
        });
      } else {
        setState(() {
          isLoggedHere = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _refresh() async {
    listFavoritesStore.clear();
    filteredFavoritesStore.clear();
    checkLoginStatus().then((isLogged) {
      if (isLogged) {
        setState(() {
          isLoggedHere = true;
        });
        getLearningObject().then((data) async {
          listFavoritesStore.setFavorites(data);
          filteredFavoritesStore.setFavorites(data);
          filteredFavoritesStore.listLearningObject =
              filteredFavoritesStore.search("", filterBy, orderBy);
          setState(() {
            controllPage = true;
          });
        });
      } else {
        setState(() {
          isLoggedHere = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresh,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
            child: Observer(builder: (_) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Filtrar por",
                                    style: TextStyle(
                                      color: AppColors.colorDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              InputFieldSelect(
                                initialValue: filterBy,
                                title: "",
                                onChanged: (String value) {
                                  setState(() {
                                    filterBy = value;
                                  });
                                },
                                list: filters.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: AppColors.greyLightMedium,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Ordenar por",
                                    style: TextStyle(
                                      color: AppColors.colorDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              InputFieldSelect(
                                initialValue: orderBy,
                                title: "",
                                onChanged: (String value) {
                                  setState(() {
                                    orderBy = value;
                                  });
                                },
                                list: orders.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                        color: AppColors.greyLightMedium,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacing(
                    padding: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "Pesquisar por",
                        style: TextStyle(
                          color: AppColors.colorDark,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            hintText: "Todos os recursos",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: AppColors.greyLightMedium,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.greyLight,
                                width: 1.2,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.greyLight, width: 0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.greyLight,
                                width: 1.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppColors.greyLight, width: 0),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.close),
                              onPressed: () {
                                searchController.text = "";
                                setState(() {
                                  searchController.text = "";
                                });
                              },
                              color: AppColors.greyLight,
                            ),
                            contentPadding: EdgeInsets.all(20.0),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Button(
                        title: "Buscar",
                        backgroundColor: AppColors.colorDark,
                        textColor: AppColors.white,
                        fillText: false,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            filteredFavoritesStore.listLearningObject =
                                listFavoritesStore.search(
                                    searchController.text.trim(),
                                    filterBy,
                                    orderBy);
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  isLoggedHere != null
                      ? isLoggedHere!
                          ? controllPage
                              ? Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          "Mostrando ${filteredFavoritesStore.listLearningObject.length} de ${listFavoritesStore.listLearningObject.length} recursos disponíveis",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: AppColors.greyDark,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: 200),
                                  child: ProgressBarIndicator(),
                                )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  child: Center(),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Faça login para acessar essa parte",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.greyDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Button(
                                  title: "Fazer Login",
                                  backgroundColor: AppColors.colorDark,
                                  textColor: AppColors.white,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const Login(),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )
                      : const Padding(
                          padding: EdgeInsets.only(top: 200),
                          child: ProgressBarIndicator(),
                        ),
                  controllPage
                      ? filteredFavoritesStore.listLearningObject.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: StaggeredGrid.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: getResponsiveWidth(widthScreen) < 400 ? 4 : 3,
                                children: filteredFavoritesStore
                                    .listLearningObject
                                    .map(
                                  (learningObject) {
                                    return StaggeredGridTile.count(
                                      crossAxisCellCount: 1,
                                      mainAxisCellCount:
                                          getResponsiveWidth(widthScreen) < 400 ? 1.8 : 1.5,
                                      child: CardConteudo(
                                        data: learningObject,
                                        addFavorite: () {
                                          filteredFavoritesStore
                                              .add(learningObject);
                                        },
                                        removeFavorite: () {
                                          filteredFavoritesStore
                                              .remove(learningObject);
                                        },
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(60),
                                    child: Text(
                                      filteredFavoritesStore
                                              .listLearningObject.isEmpty
                                          ? "Você não possui nenhum recurso na sua lista de favoritos."
                                          : "Não há resultados para os filtros aplicados.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.greyDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                      : Center(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  errorConection(BuildContext context, Function onPressed) {
    PopUpErrorConnection(context, onPressed: onPressed);
  }
}
