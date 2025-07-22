import 'dart:ui';

import 'package:bd_mtur/core/app_colors.dart';
import 'package:bd_mtur/core/app_images.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/utils.dart';
import 'package:bd_mtur/models/news_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'pop_up_access.dart';

class BannerSlider extends StatefulWidget {
  final NewsModel news;
  const BannerSlider({Key? key, required this.news}) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  _fontSize() {
    final widthScreen = MediaQuery.of(context).size.width;

    if (getResponsiveWidth(widthScreen) < 350) {
      return 16.0;
    } else {
      return 18.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.news.refImgs),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          widget.news.titulo.toUpperCase(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: _fontSize(),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          stringNula(widget.news.subtitulo!)
                              ? "Fique por dentro de tudo que acontece na UNASUS"
                              : widget.news.subtitulo!,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: _fontSize() - 2,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white30,
                          backgroundColor: AppColors.white,
                          fixedSize: Size(double.infinity, double.infinity),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () => popUpAcessoExterno(),
                        child: Text(
                          "Acessar Notícia",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: _fontSize(),
                            color: AppColors.colorDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> popUpAcessoExterno() async {
    return PopUpAccess(
      context: context,
      title: "Acesso Externo",
      message:
          "Você está prestes a acessar uma página externa ao aplicativo. Deseja continuar?",
      url: "https://www.unasus.ufma.br/noticias/${widget.news.numero}",
    );
  }

  stringNula(String string) {
    if (string == null) {
      return true;
    } else if (string == "" || string == " ") {
      return true;
    }
    return false;
  }
}
