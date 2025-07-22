import 'dart:io';

import 'package:bd_mtur/controllers/theme_controller.dart';
import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/core/utils.dart';
import 'package:bd_mtur/stores/favoriteStore.dart';
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

import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:bd_mtur/controllers/course_controller.dart';
import 'package:bd_mtur/models/course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllResources extends StatefulWidget {
  final String? format;
  const AllResources({Key? key, required this.format}) : super(key: key);

  @override
  State<AllResources> createState() => _AllResourcesState();
}

class _AllResourcesState extends State<AllResources> {
  final _formKey = GlobalKey<FormState>();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final searchController = TextEditingController();

  final UserController _userController = new UserController();
  final LearningObjectController _controllerLearningObject =
      new LearningObjectController();

  List<LearningObjectModel> listFavorites = [];

  ListLearningObjectStore listLearningObjectStore =
      new ListLearningObjectStore();
  ListLearningObjectStore filteredLearningObjectStore =
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
    return await _controllerLearningObject.getAllEducationalObject();
  }

  getAllFavorites() async {
    try {
      return await _controllerLearningObject.getAllFavorites();
    } on DioError catch (e) {
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

    var verifyToken = await _userController.verifyToken();

    return token != null && verifyToken;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      filterBy = widget.format ?? "Todos";
    });
    checkLoginStatus().then((isLogged) {
      if (isLogged) {
        getAllFavorites().then((data) async {
          listFavorites = data;
          getLearningObject().then((data) async {
            listLearningObjectStore.setList(data, listFavorites, "");
            filteredLearningObjectStore.setList(data, listFavorites, "");
            filteredLearningObjectStore.listLearningObject =
                filteredLearningObjectStore.search("", filterBy, orderBy);
          });
        });
      } else {
        getLearningObject().then((data) async {
          listLearningObjectStore.setList(data, listFavorites, "");
          filteredLearningObjectStore.setList(data, listFavorites, "");
          filteredLearningObjectStore.listLearningObject =
              filteredLearningObjectStore.search("", filterBy, orderBy);
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    orderBy = "Avaliação";
    filterBy = "Todos";
  }

  Future _refresh() async {
    listLearningObjectStore.clear();
    filteredLearningObjectStore.clear();
    getAllFavorites().then((data) async {
      listFavorites = data;
    });
    return getLearningObject().then((data) async {
      listLearningObjectStore.setList(data, listFavorites, "");
      filteredLearningObjectStore.setList(data, listFavorites, "");
      filteredLearningObjectStore.listLearningObject =
          filteredLearningObjectStore.search("", filterBy, orderBy);
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
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                                initialValue: widget.format ?? filterBy,
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
                            filteredLearningObjectStore.listLearningObject =
                                listLearningObjectStore.search(
                                    searchController.text.trim(),
                                    filterBy,
                                    orderBy);
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),
                  listLearningObjectStore.listLearningObject.isEmpty
                      ? const Padding(
                          padding: EdgeInsets.only(top: 200),
                          child: ProgressBarIndicator(),
                        )
                      : Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Flexible(
                                child: Text(
                                  "Mostrando ${filteredLearningObjectStore.listLearningObject.length} de ${listLearningObjectStore.listLearningObject.length} recursos disponíveis",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.greyDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  listLearningObjectStore.listLearningObject.isEmpty
                      ? Center()
                      : filteredLearningObjectStore
                              .listLearningObject.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: StaggeredGrid.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: getResponsiveWidth(widthScreen) < 400 ? 4 : 3,
                                children: filteredLearningObjectStore
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
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(60),
                                    child: Text(
                                      "Não há resultados para os filtros aplicados.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.greyDark,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
