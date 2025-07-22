import 'package:bd_mtur/controllers/course_controller.dart';
import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/controllers/sponsor_controller.dart';
import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/models/course_model.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/models/sponsor_model.dart';
import 'package:bd_mtur/models/topic_interest_model.dart';
import 'package:bd_mtur/stores/favoriteStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatefulWidget {
  final FavoriteStore learningObject;
  final Function addFavorite;
  final Function removeFavorite;

  Details(this.learningObject, this.addFavorite, this.removeFavorite);

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final UserController _userController = new UserController();
  final LearningObjectController controllerLearningObject =
      new LearningObjectController();
  final CourseController controllerCourse = new CourseController();
  final SponsorController controllerSponsor = new SponsorController();

  late List<TopicInterestModel> topics = [];
  CourseModel? course;

  bool isLoggedHere = false;
  bool _status_download = false;
  String content_type = '';
  String name_sponsors = '';

  void _onDownloadTapped() {
    setState(() {
      _status_download = !_status_download;
    });
  }

  void _shareContent() {
    Share.share(
        "Este é o link para o recurso: ${widget.learningObject.learningObject.urlObject}");
  }

  String _iconFormat = '';
  String _iconObject() {
    int _objectFormat = widget.learningObject.learningObject.objectTypeId;

    if (_objectFormat == 1) {
      _iconFormat = AppImages.pdf;
    } else if (_objectFormat == 6) {
      _iconFormat = AppImages.ebook;
    } else if (_objectFormat == 5) {
      _iconFormat = AppImages.game_case;
    } else if (_objectFormat == 4) {
      _iconFormat = AppImages.infografico;
    } else if (_objectFormat == 3) {
      _iconFormat = AppImages.podcast;
    } else if (_objectFormat == 2) {
      _iconFormat = AppImages.media;
    } else if (_objectFormat == 7) {
      _iconFormat = AppImages.recurso_multimidia;
    }

    return _iconFormat;
  }

  getCourse() {
    controllerCourse
        .getCourse(widget.learningObject.learningObject.courseId)
        .then((value) {
      setState(() {
        course = value;
      });
    });
  }

  getSponsor() {
    controllerSponsor.getSponsors().then((value) {
      for (SponsorModel sponsor in value) {
        if (sponsor.id == value.elementAt(0).id) {
          setState(() {
            name_sponsors = sponsor.name;
          });
        } else {
          setState(() {
            name_sponsors = name_sponsors + ' / ' + sponsor.name;
          });
        }
      }
    });
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
        setState(() {
          isLoggedHere = true;
        });
      }
    });
    getCourse();
    getSponsor();
    topics = widget.learningObject.learningObject.topics;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _refresh() async {
    checkLoginStatus().then((isLogged) {
      if (isLogged) {
        setState(() {
          isLoggedHere = true;
        });
      }
    });
    getSponsor();
    getCourse();
    topics = widget.learningObject.learningObject.topics;
  }

  @override
  Widget build(BuildContext context) {
    var format =
        formatObject(widget.learningObject.learningObject.objectTypeId);

    int numberReviews = widget.learningObject.learningObject.numberReviews;

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: course != null
                  ? [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 10, 0),
                                          child: Image(
                                            image: NetworkImage(widget
                                                .learningObject
                                                .learningObject
                                                .urlImage),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                    widget
                                        .learningObject.learningObject.fullName,
                                    style: AppTextStyles.contentTitle,
                                  ),
                                ),
                                Spacing(),
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Image(
                                          image: AssetImage(
                                            AppImages.staravaliationfill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.learningObject
                                                  .learningObject.averageGrade
                                                  .toStringAsFixed(2),
                                              style: AppTextStyles.contentTitle,
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              numberReviews.toString() +
                                                  (numberReviews > 1
                                                      ? " avaliações"
                                                      : " avaliação"),
                                              style: AppTextStyles.bodyGrey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Image(
                                          image: AssetImage(_iconObject()),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              format,
                                              style: AppTextStyles.contentTitle,
                                            ),
                                            const SizedBox(
                                              height: 2,
                                            ),
                                            Text(
                                              "Formato",
                                              style: AppTextStyles.bodyGrey,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Image(
                                          image: AssetImage(
                                            AppImages.calendar,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        flex: 7,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dateFormat(widget.learningObject
                                                  .learningObject.releaseDate),
                                              style: AppTextStyles.contentTitle,
                                            ),
                                            Text(
                                              "Lançamento",
                                              style: AppTextStyles.bodyGrey,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacing(),
                      Row(
                        children: [
                          Button(
                            title: "Acessar Recurso",
                            backgroundColor: AppColors.colorDark,
                            textColor: AppColors.white,
                            onPressed: () => popUpAcessoExterno(format),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Text(
                              "Resumo:",
                              style: TextStyle(
                                color: AppColors.colorDark,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.learningObject.learningObject.abstract,
                              style: AppTextStyles.labelContentText,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      format.contains("Podcast") ? Spacing() : const Center(),
                      format.contains("Podcast")
                          ? Row(
                              children: [
                                Button(
                                  title: "Acessar Transcrição do Recurso",
                                  backgroundColor: AppColors.colorDark,
                                  textColor: AppColors.white,
                                  onPressed: () => popUpAcessoExterno(
                                    "PDF",
                                  ),
                                ),
                              ],
                            )
                          : const Center(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Observer(builder: (_) {
                                return Column(
                                  children: [
                                    IconButton(
                                      iconSize: 40,
                                      icon: Icon(
                                        widget.learningObject.isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: AppColors.colorDark,
                                      ),
                                      onPressed: () async {
                                        if (isLoggedHere) {
                                          if (await controllerLearningObject
                                              .setFavorite(widget.learningObject
                                                  .learningObject.id)) {
                                            if (widget
                                                .learningObject.isFavorite) {
                                              widget.removeFavorite();
                                            } else {
                                              widget.addFavorite();
                                            }
                                            widget.learningObject
                                                .toogleFavorite();
                                          }
                                        } else {
                                          errorLogin(context);
                                        }
                                      },
                                    ),
                                    Text(
                                      widget.learningObject.isFavorite
                                          ? "Favoritado"
                                          : "Favoritar",
                                      style: TextStyle(
                                        color: AppColors.greyDark,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              Column(
                                children: [
                                  IconButton(
                                    iconSize: 40,
                                    icon: Icon(
                                      _status_download
                                          ? Icons.download_done_outlined
                                          : Icons.download,
                                      color: format == "PDF"
                                          ? AppColors.colorDark
                                          : AppColors.greyLight,
                                    ),
                                    onPressed: format == "PDF"
                                        ? () => popUpAcessoExterno("")
                                        : null,
                                  ),
                                  Text(
                                    _status_download ? "Salvo" : "Download",
                                    style: TextStyle(
                                      color: format == "PDF"
                                          ? AppColors.greyDark
                                          : AppColors.greyLight,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    iconSize: 40,
                                    icon: Icon(
                                      Icons.share,
                                      color: AppColors.colorDark,
                                    ),
                                    onPressed: () async {
                                      await Share.share(
                                          'Acesse o recurso ${widget.learningObject.learningObject.fullName} em ${widget.learningObject.learningObject.urlObject}');
                                    },
                                  ),
                                  Text(
                                    "Compartilhar",
                                    style: TextStyle(
                                      color: AppColors.greyDark,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                            child: Text(
                              "Tópicos Relacionados",
                              style: TextStyle(
                                color: AppColors.colorDark,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: topics.isNotEmpty
                                  ? topics.map((topic) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 4),
                                        child: TopicTag(
                                          id: topic.id,
                                          textTag: topic.name,
                                        ),
                                      );
                                    }).toList()
                                  : [
                                      const Text("Nenhum tópico relacionado"),
                                    ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Apoio Institucional",
                                  style: TextStyle(
                                    color: AppColors.colorDark,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  name_sponsors,
                                  style: AppTextStyles.labelContentText,
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Curso Relacionado",
                                    style: TextStyle(
                                      color: AppColors.colorDark,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    course!.name,
                                    style: AppTextStyles.labelContentText,
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  : [
                      const Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: ProgressBarIndicator(),
                      ),
                    ],
            ),
          ),
        ],
      ),
    );
  }

  Widget snackItemFavoritado(BuildContext context) {
    return SnackBar(
      content: const Text("Recurso Favoritado"),
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: () => widget.learningObject.toogleFavorite(),
      ),
    );
  }

  Widget snackItemBaixado(BuildContext context) {
    return const SnackBar(
      content: Text("Recurso Favoritado"),
      action: null,
    );
  }

  errorLogin(BuildContext context) {
    PopUpAction(context, "Fazer login",
        "É necessário estar logado para realizar essa ação", "login");
  }

  popUpAcessoExterno(String format) {
    return PopUpAccessResource(
      context,
      format,
      learningObject: widget.learningObject.learningObject,
    );
  }

  popUpCurso(String url) {
    if (isLoggedHere) {
      return PopUpAccess(
        context: context,
        title: "Abrir link externo",
        message:
            "Você está prestes a sair do aplicativo e visitar um link externo. Tem certeza que deseja sair desta tela para acessar o link?",
        action: "Sim, e quero favoritar este recurso",
        url: url,
      ).then((value) async {
        if (value && !widget.learningObject.isFavorite) {
          await controllerLearningObject
              .setFavorite(widget.learningObject.learningObject.id);
          widget.learningObject.isFavorite = !widget.learningObject.isFavorite;
          widget.addFavorite();
        }
      });
    } else {
      return PopUpAccess(
        context: context,
        title: "Abrir link externo",
        message:
            "Você está prestes a sair do aplicativo e visitar um link externo. Tem certeza que deseja sair desta tela para acessar o link?",
        url: url,
      );
    }
  }

  formatObject(int id) {
    controllerLearningObject.getAllObjectType().then((value) {
      setState(() {
        content_type = value.firstWhere((element) => element.id == id).nameType;
      });
    });
    return content_type;
  }

  String dateFormat(DateTime datetime) {
    var formatter = new DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(datetime);
    return formattedDate;
  }
}
