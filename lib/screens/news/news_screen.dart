import 'dart:io';

import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';

import 'package:bd_mtur/controllers/course_controller.dart';
import 'package:bd_mtur/models/course_model.dart';
import 'package:bd_mtur/controllers/news_controller.dart';
import 'package:bd_mtur/models/news_model.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final CourseController _controller = new CourseController();
  final NewsController _controllerNews = new NewsController();

  List<CourseModel>? listCourses;
  List<NewsModel>? news;

  getNews() async {
    try {
      return await _controllerNews.getAllRecentNews();
    } on DioError catch (e) {
      errorConection(context, () {
        _refreshIndicatorKey.currentState!.show();
      });
      rethrow;
    } on IOException catch (e) {
      errorConection(context, () {
        _refreshIndicatorKey.currentState!.show();
      });
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  getCourses() async {
    try {
      return await _controller.getAllCourses();
    } catch (e) {
      rethrow;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews().then((data) {
      setState(() {
        news = data;
      });
    });
    getCourses().then((data) {
      setState(() {
        listCourses = data;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future _refresh() async {
    getNews().then((data) {
      setState(() {
        news = data;
      });
    });
    return getCourses().then((data) {
      setState(() {
        listCourses = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: news !=
                    null // se notícias for nulo mostra tela de carregamento
                ? [
                    news!.isNotEmpty // se noticias não estiver vazio carrega as noticias
                        ? StaggeredGrid.count(
                            crossAxisCount: 1,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 1,
                            children: [
                              StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 0.5,
                                child: BannerSlider(
                                  news: news!.elementAt(0),
                                ),
                              ),
                              StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 0.5,
                                child: BannerSlider(
                                  news: news!.elementAt(1),
                                ),
                              ),
                              StaggeredGridTile.count(
                                crossAxisCellCount: 1,
                                mainAxisCellCount: 0.5,
                                child: BannerSlider(
                                  news: news!.elementAt(2),
                                ),
                              )
                            ],
                          )
                        : Center(),
                    listCourses != null
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(
                                20, news!.isEmpty ? 40 : 10, 20, 0),
                            child: Row(
                              children: [
                                Text(
                                  "Conheça os últimos lançamentos",
                                  style: TextStyle(
                                    color: AppColors.colorDark,
                                    fontSize: 18,
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(),
                    listCourses != null
                        ? listCourses!.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: StaggeredGrid.count(
                                  crossAxisCount: 1,
                                  children: listCourses!.map(
                                    (course) {
                                      if (course.recentRelease) {
                                        return CardCourse(
                                          course: course,
                                          page: () =>
                                              popUpAcessoExterno(course.url),
                                        );
                                      } else {
                                        return Center();
                                      }
                                    },
                                  ).toList(),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.all(60),
                                      child: Text(
                                        "Não há nada para ser listado.",
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
                        : ProgressBarIndicator(),
                  ]
                : [
                    Padding(
                      padding: EdgeInsets.only(top: 200),
                      child: ProgressBarIndicator(),
                    ),
                  ],
          ),
        ),
      ),
    );
  }

  errorConection(BuildContext context, Function onPressed) {
    PopUpErrorConnection(context, onPressed: onPressed);
  }

  Future<bool> popUpAcessoExterno(String url) async {
    return PopUpAccess(
      context: context,
      title: "Abrir link externo",
      message:
          "Você está prestes a sair do aplicativo e visitar um link externo. Tem certeza que deseja sair desta tela para acessar o link?",
      url: url,
    );
  }
}
