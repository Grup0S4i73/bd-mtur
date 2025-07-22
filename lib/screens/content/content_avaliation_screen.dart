// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:convert';
import 'dart:io';

import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/models/comment_model.dart';
import 'package:bd_mtur/models/user_review_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:bd_mtur/controllers/learning_object_controller.dart';
import 'package:bd_mtur/core/app_widgets.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/models/learning_object_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Avaliation extends StatefulWidget {
  final LearningObjectModel learningObject;

  Avaliation(this.learningObject);

  @override
  State<Avaliation> createState() => _AvaliationState();
}

class _AvaliationState extends State<Avaliation> {
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final UserController _userController = new UserController();
  final learningObjectController = new LearningObjectController();
  final _commentsController = TextEditingController();

  double? _review;
  int number_comments = 0;
  bool isLoggedHere = false;

  Future<UserReviewModel> getReviewObject() async {
    try {
      return await learningObjectController
          .getReviewObject(widget.learningObject.id);
    } catch (e) {
      if (e.toString().contains("Erro de conexão")) {
        errorConection(context, () {
          _refreshIndicatorKey.currentState!.show();
        });
      }
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
    checkLoginStatus().then((isLogged) {
      if (isLogged) {
        getReviewObject().then((value) {
          setState(() {
            isLoggedHere = true;
            _review = value.score;
          });
        });
      } else {
        setState(() {
          _review = 0.0;
        });
      }
    });
    super.initState();
  }

  Future _refresh() {
    return checkLoginStatus().then((isLogged) {
      if (isLogged) {
        getReviewObject().then((value) {
          setState(() {
            _review = value.score;
          });
        });
      } else {
        setState(() {
          _review = 0.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Sua Avaliação",
                        style: TextStyle(
                          color: AppColors.greyDark,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: RatingBar.builder(
                          initialRating: _review ?? 0,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 6.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: AppColors.yellowStar,
                          ),
                          onRatingUpdate: (rating) async {
                            setState(() {
                              _review = rating;
                            });
                            if (isLoggedHere) {
                              popUpReview();
                            } else {
                              errorLogin(context);
                            }
                          },
                          glow: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: 2,
                color: AppColors.greyLight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Row(
                children: [
                  Text(
                    "Comentários",
                    style: TextStyle(
                      color: AppColors.greyDark,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: 2,
                color: AppColors.greyLight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "Lembre-se de manter o respeito nos comentários e seguir nossas",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.greyDark,
                      ),
                    ),
                    TextSpan(
                      text: " diretrizes da comunidade",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorDark,
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => {diretrizesComunidades()},
                    ),
                    TextSpan(
                      text: " e ",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.greyDark,
                      ),
                    ),
                    TextSpan(
                      text: "termos e condições de uso",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.colorDark,
                        fontWeight: FontWeight.w400,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => {termosCondicoes()},
                    ),
                    TextSpan(
                      text: ".",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.greyDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: 2,
                color: AppColors.greyLight,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Image(
                          image: AssetImage(AppImages.profile),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      InputFieldComment(
                        controller: _commentsController,
                        sendComment: () async {
                          try {
                            if (isLoggedHere) {
                              if (await learningObjectController.setComment(
                                  widget.learningObject.id,
                                  _commentsController.text)) {
                                popUpCommentSucess(context);
                                setState(() {});
                              }
                            } else {
                              errorLogin(context);
                            }
                          } catch (e) {
                            if (e.toString().contains("Erro de conexão")) {
                              errorConection(context, () {
                                _refreshIndicatorKey.currentState!.show();
                              });
                            }
                            rethrow;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: 2,
                color: AppColors.greyLight,
              ),
            ),
            FutureBuilder<List<CommentModel>>(
                future: learningObjectController
                    .getAllComments(widget.learningObject.id),
                builder: (context, comments) {
                  if (comments.hasData) {
                    if (comments.data!.isNotEmpty) {
                      return StaggeredGrid.count(
                        crossAxisCount: 1,
                        children: comments.data!.map((comment) {
                          return Comment(
                            comment: comment,
                            avatar: AppImages.profile,
                          );
                        }).toList(),
                      );
                    } else {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text(
                            "Sem comentários",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.greyDark,
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: ProgressBarIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  errorConection(BuildContext context, Function onPressed) {
    PopUpErrorConnection(context, onPressed: onPressed);
  }

  errorLogin(BuildContext context) {
    PopUpAction(context, "Fazer login",
        "É necessário estar logado para realizar essa ação", "login");
  }

  Future<bool> diretrizesComunidades() async {
    return CloseDialogWidget(
        context,
        "Política de Privacidade da Biblioteca Digital",
        "Este site é mantido e operado pela Universidade Federal do Maranhão - UFMA. \n A política de privacidade e termos de uso se aplicam a todos os usuários que acessam este website. \n A privacidade dos visitantes do nosso site é muito importante para nós, e estamos comprometidos em protegê-la. Coletamos e utilizamos alguns dados pessoais pertencentes àqueles usuários que utilizam este website. Agimos na qualidade de controlador desses dados de acordo com a legislação federal e com as normas internacionais de segurança da informação. \n Introdução \n Disponibilizamos esta política de privacidade que contém informações importantes sobre: \n - Quem deve utilizar este website \n - Quais dados coletamos e o que fazemos com eles \n - Seus direitos em relação aos seus dados pessoais \n - Como entrar em contato conosco \n Esta política de privacidade explica o que faremos com suas informações pessoais e visa esclarecer a todos os(as) interessados(as) sobre os tipos de dados que coletamos, os motivos da coleta e a forma como os usuários deste site podem gerenciar ou excluir suas informações pessoais. \n Os presentes termos foram elaborados em conformidade com a Lei Geral de Proteção de Dados pessoais (Lei 13.709/18), o Marco Civil da Internet (Lei 12.965/14) e o Regulamento da UE (n.2016/6790). \n 1 - Quem deve utilizar este website \n Nosso website só deve ser utilizado por pessoas com mais de 18 anos de idade. Menores de 18 anos e aqueles que não possuírem plena capacidade civil deverão obter previamente o consentimento expresso de seus responsáveis legais para utilização da plataforma e dos serviços ou produtos, sendo de responsabilidade exclusiva dos mesmos o eventual acesso por menores de idade e por aqueles que não possuem plena capacidade civil sem a prévia autorização \n 2 – Dados que coletamos e motivos da coleta \n Nosso site coleta e utiliza alguns dados pessoais dos visitantes e usuários da seguinte forma: \n     2.1) Dados pessoais fornecidos expressamente pelo usuário \n 2.1.1) Coletamos os seguintes dados pessoais que os usuários nos fornecem ao utilizar nosso site: \n Nome completo, e-mail, escolaridade, profissão, especialidade, instituição a qual se vincula, caso haja, cidade/Estado Federado em que exerce a sua profissão, dados demográficos (data de nascimento, sexo, origem étnico-racial, etc.), plataforma utilizada (web ou mobile), endereço IP da máquina, idioma escolhido para a navegação, e outros dados afins a estes. \n 2.1.2) A coleta destes dados ocorre nos seguintes momentos: \n Quando o usuário preenche formulários relacionados ao seu perfil, dados demográficos, etc.; Sempre que o usuário realiza o log in na plataforma; A cada recurso visitado são coletados dados estatísticos da navegação e evolução do usuário. \n 2.1.3) Os dados fornecidos por nossos usuários são coletados com as seguintes finalidades:   \n Finalidade de utilização para a execução de políticas públicas, realização Pesquisas acadêmico-educacionais e profissionais; visualização da abrangência territorial da utilização da plataforma, melhorias das políticas de qualificação da cadeia econômica etc. \n    2.2) Dados pessoais comportamentais: \n Quando o usuário visita o nosso website, é inserido um ‘cookie’ em seu navegador por meio do software Google Analytics, para identificar quantas vezes visitou o nosso endereço eletrônico, quanto tempo permaneceu em nosso website, de qual locallidade realizou o acesso e quais páginas leu e recomendou, entre outros. \n 2.2.1) Coletamos os seguintes dados pessoais através de cookies e outras formas que os usuários geram e/ou nos fornecem ao utilizar nosso site: \n  Endereço IP; localização geográfica; idioma utilizado na navegação, tempo de duração de cada visita e histórico de visitas, dados contextuais baseados na experiência de navegação, como datas e horários de acesso mais frequentes. Esses dados ficam armazenados em Cessão, não, portanto, hospedados na máquina do usuário. \n 2.2.2) A coleta destes dados ocorre nos seguintes momentos: \n Quando o usuário faz login e logout na plataforma. Esses dados ficam armazenados em Cessão, não, portanto, hospedados na máquina do usuário. \n 2.2.3) Os dados gerados e/ou fornecidos por nossos usuários são coletados com as seguintes finalidades:   \n Para garantir a segurança do software e do próprio usuário a partir de criptografia de ponta a ponta; Para detectar comportamento fora do habitual e brechas de segurança; Para rastrear de onde partem possíveis tentativas de invasão; - Para cumprir determinação legal de armazenamento de registros de acesso, conforme o disposto na Lei Geral de Proteção de Dados - LGPD (Lei n.⁰13.709, de 14 de agosto de 2018); Para gerar estatísticas de visitação e de interação com a plataforma; Para desenvolver novas funcionalidades em nosso software; Para cumprir com nossas obrigações legais e regulatórias a partir da Lei Geral de Proteção de Dados - LGPD (Lei n.⁰13.709, de 14 de agosto de 2018). \n 2.3) Dados pessoais sensíveis:  \n 2.3.1) O site poderá coletar os seguintes dados sensíveis dos usuários: \n Dados estatísticos demográficos (sexo, origem étnico-racial, etc.) do usuário na forma do art. 11, II, alínea 'c', e art. 13, caput, ambos da Lei Geral de Proteção de Dados - LGPD (Lei n.⁰13.709, de 14 de agosto de 2018). \n 2.3.2) Os dados sensíveis fornecidos por nossos usuários podem ser coletados com as seguintes finalidades: \n Para enquadramento demográfico e estatístico dos usuários/jogadores; Para cumprimento de protocolos de Pesquisas Científicas e Educacionais e para a efetiva realização das Pesquisas propriamente ditas. \n A coleta e a utilização dos dados pessoais sensíveis serão feitas com o consentimento específico de seus titulares, exceto nos casos em que a Lei Geral de Proteção de Dados permitir o tratamento com fundamento em outras bases legais distintas do consentimento. \n Em qualquer caso, o tratamento dos dados sensíveis ocorrerá para atender às finalidades específicas expressas nesta política ou devidamente informada ao usuário por outros meios convenientes para a realização de tal informação. \n  2.4) Dados de crianças e adolescentes:  \n Este site não coleta dados de crianças e adolescentes. \n 2.5) Cookies: \n Cookies são pequenos arquivos de texto baixados automaticamente em seu dispositivo quando você acessa e navega por um site. Eles servem, para que seja possível identificar dispositivos, atividades e preferências de usuários. \n Os cookies não permitem que qualquer arquivo ou informação sejam extraídos do disco rígido do usuário. Não sendo possível que, por meio dos cookies, se tenha acesso a informações pessoais que não tenham partido do usuário ou da forma como utiliza os recursos e funcionalidades do site. \n A desativação dos cookies que podem ser desabilitados poderá prejudicar a experiência do usuário, uma vez que informações utilizadas para personalizá-la deixarão de ser utilizadas. \n a) Cookies do Site: \n Os cookies do site são aqueles enviados ao computador ou dispositivo do usuário, exclusivamente pelo website. As informações coletadas por meio destes cookies são utilizadas para melhorar e personalizar a experiência do usuário, sendo que alguns cookies podem, por exemplo, ser utilizados para lembrar as preferências e escolhas do usuário, bem como para o oferecimento de conteúdo personalizado. \n b) Cookies de Terceiros: \n Alguns de nossos parceiros podem configurar cookies nos dispositivos dos usuários que acessam nosso site. Estes cookies, em geral, visam possibilitar que nossos parceiros possam oferecer seu conteúdo e seus serviços ao usuário que acessa nosso site de forma personalizada, por meio da obtenção de dados de navegação extraídos a partir de sua interação com o site. \n c) Gestão de Cookies: \n O usuário poderá se opor ao registro de cookies pelo site, bastando que desative esta opção no seu próprio navegador. Mais informação sobre como fazer isso em alguns dos principais navegadores utilizados hoje podem ser acessados a partir dos seguintes links: \n Internet Explorer: \n https://support.microsoft.com/pt-br/topic/excluir-e-gerenciar-cookies-168dab11-0753-043d-7c16-ede5947fc64d \n Safari: \n https://support.apple.com/pt-br/guide/safari/sfri11471/mac \n Google Chrome: \n https://support.google.com/chrome/answer/95647 \n Mozila Firefox: \n https://support.mozilla.org/pt-BR/kb/cookies-informacoes-sites-armazenam-no-computador#w_configuracoes-de-cookies \n Opera: \n https://www.opera.com/pt/secure-private-browser \n O usuário também poderá se opor à utilização de cookies pelo próprio site, bastando que os desative no momento em que começar a utilizar o site pela primeira vez, clicando no aviso de cookies e depois desativando esta opção no seu navegador, para se assegurar de que o registro de cookies foi desativado. \n Assim que entrar no site pela primeira vez, o usuário terá a opção de bloquear ou de permitir a utilização de cookies, bastando que selecione a opção correspondente na caixa de diálogo (aviso de cookies) carregada automaticamente assim que nossa página é acessada. \n A desativação dos cookies, no entanto, poderá afetar a disponibilidade de algumas ferramentas e funcionalidades deste website, comprometendo seu funcionamento esperado. Outra consequência possível é a remoção das preferências do usuário que eventualmente tiverem sido salvas, prejudicando, assim, sua experiência de navegação. \n A desativação de todos os cookies, no entanto, não será possível, uma vez que alguns deles são essenciais para que o site funcione corretamente. \n 3 – Compartilhamento de Dados com Terceiros \n 3.1) Os dados coletados através deste site podem ser compartilhados com as seguintes empresas, aplicações e/ou ferramentas: \n UNIVERSIDADE FEDERAL DO MARANHÃO-UFMA; Entre os usuários da plataforma para fins de pesquisa.  \n 3.2) Estes dados são compartilhados pelas seguintes razões e para as seguintes finalidades: \n Estabelecimento de ranking entre os usuários do serviço; Estabelecimento de ranking por Instituição de vinculação do usuário, por região do Brasil, por continente e por País e por cidade em que ele esteja radicado. \n Além das situações aqui informadas, é possível que compartilhemos dados com terceiros para cumprir alguma determinação legal, técnica ou regulatória. No caso de Informações a serem compartilhadas em cumprimento de solicitação de autoridade pública, ela sempre será efetuada mediante ordem judicial, conforme definido em Lei. \n Em qualquer caso, o compartilhamento de dados pessoais observará todas as leis e regras aplicáveis caso a caso, buscando-se, sempre, garantir a segurança dos dados de nossos usuários, observados os padrões técnicos e boas práticas de segurança da informação. \n Ao concordar com esta política de privaciadade e continuar utilizando este website você nos autoriza a compartilhar seus dados. \n 4 – Por quanto tempo seus dados pessoais são armazenados \n Os dados pessoais coletados através do site são armazenados e utilizados pelo período de tempo que for necessário para atingir as finalidades elencadas neste documento e que considere os direitos de seus titulares, os direitos do controlador do website e as disposições legais ou regulatórias aplicáveis. \n O tempo mínimo de armazenamento é de 6 meses para dados comportamentais, segundo o Art. 15 do Marco Civil da Internet e de 5 anos após o término da relação com o usuário para dados cadastrais, segundo o Art. 27 do Código de Defesa do Consumidor. \n Uma vez expirados os períodos de armazenamento dos dados pessoais, eles podem vir a ser removidos de nossas bases de dados ou anonimizados, salvo nos casos em que houver a possibilidade e/ou a necessidade de armazenamento em virtude de disposição legal ou regulatória. \n Caso haja solicitação do Usuário, os dados poderão ser apagados antes desse prazo. No entanto, pode ocorrer de os dados precisarem ser mantidos por período superior, por motivo de lei, ordem judicial, prevenção à fraude (art. 11, II, “a” da Lei Geral de Proteção de Dados “LGPD”, Lei nº 13.709/2018), proteção ao crédito (art. 7º, X, LGPD) e outros interesses legítimos, em conformidade com o artigo 10 da LGPD. Findo o prazo e a necessidade legal, serão excluídos com uso de métodos de descarte seguro, ou utilizados de forma anonimizada para fins estatísticos ou acadêmicos. \n Ressaltamos que os dados poderão continuar armazenados se houver alguma justificativa legal ou regulatória, ainda que tenha se exaurido a finalidade para a qual os dados tenham sido coletados e/ou tratados originariamente. \n Os dados são armazenados de forma contínua, anonimizada, para efeito de realização de pesquisas científicas e educacionais, na forma do art. 15, I, da Lei Geral de Proteção de Dados (Lei n.⁰13.709, de 14 de agosto de 2018). \n 5 – Bases legais para o tratamento de dados pessoais \n Nós tratamos os dados pessoais de nossos usuários mediante os seguintes fundamentos legais, que justificam o tratamento de dados: \n 5.1) Dados pessoais não sensíveis \n Mediante o consentimento do titular dos dados pessoais; para o exercício regular de direitos em processo educacional (ensino-aprendizagem) e científico (pesquisa), atendendo a interesses legítimos da Universidade Federal do Maranhão - UFMA, enquanto Instituição Federal de Ensino Superior - IFES. \n  5.2) Consentimento do Titular \n Ao utilizar este site, solicitar serviços e/ou fornecer informações pessoais o usuário está consentindo com a presente política de privacidade. \n Determinadas operações de tratamento de dados pessoais realizadas em nosso site dependerão da prévia concordância do usuário, que deverá manifestá-la de forma livre, informada e inequívoca. \n O usuário, ao visitar este site, entrar em contato, ao cadastrar-se e/ou ao realizar qualquer tipo de interação conosco, manifesta conhecer a presente política e pode exercer seus direitos de cancelar seu cadastro, atualizar seus dados pessoais e garante a veracidade das informações por ele disponibilizadas. \n O usuário poderá revogar seu consentimento a qualquer momento e solicitar a exclusão de seus dados, sendo que, não havendo hipótese legal que permita ou que demande o armazenamento de dados, os dados fornecidos mediante consentimento serão excluídos. \n 5.3) Cumprimento de obrigação legal ou regulatória pelo controlador \n Algumas operações de tratamento de dados pessoais, sobretudo o armazenamento de dados, serão realizadas para que possamos cumprir obrigações previstas em lei ou em outras disposições normativas aplicáveis às nossas atividades. \n 5.4) Execução de contrato \n Para a execução de contrato compra e venda ou de prestação de serviços, eventualmente firmado entre o site o usuário, poderão ser coletados e armazenados outros dados relacionados e/ou necessários a sua execução, incluindo o teor de eventuais comunicações tidas com o usuário. \n 6 - Direitos do Usuário \n O usuário do site possui os seguintes direitos, conferidos pela Lei Geral de Proteção de Dados – LGPD: \n Confirmação da existência de tratamento; Acesso aos dados; Correção de dados incompletos, inexatos ou desatualizados; Anonimização, bloqueio ou eliminação de dados desnecessários, excessivos ou tratados em desconformidade com o disposto na lei; Portabilidade dos dados a outro fornecedor de serviço ou produto, mediante requisição expressa, de acordo com a regulamentação da autoridade nacional, observados os segredos comercial e industrial; Eliminação dos dados pessoais tratados com o consentimento do titular, exceto nos casos previstos em lei; Informação das entidades públicas e privadas com as quais o controlador realizou uso compartilhado de dados; Informação sobre a possibilidade de não fornecer consentimento e sobre as consequencias dessa negativa; revogação do consentimento. \n É importante destacar que, nos termos da LGPD, não existe um direito de eliminação de dados tratados com fundamento em bases legais distintas do consentimento, a menos que os dados sejam desnecessários, excessivos ou tratados em desconformidade com o previsto na Lei. \n 6.1 - Como o titular pode exercer seus direitos      \n Os titulares de dados pessoais tratados por nós poderão exercer seus direitos por meio do formulário disponibilizado no seguinte caminho: \n https://www.siteexemplo.com.br/contato. \n Alternativamente, se desejar, o titular poderá enviar um e-mail para o seguinte endereço: \n tecnologia.unasus@ufma.br \n Os titulares de dados pessoais tratados por nós poderão exercer seus direitos a partir do envio de mensagem para nosso Encarregado de Proteção de Dados Pessoais seja por e-mail, formulário ou correspondência. As informações necessárias estão na seção 'Como entrar em contato conosco' desta Política de Privacidade. \n Para garantir que o usuário que pretende exercer seus direitos é, de fato, o titular dos dados pessoais objeto da requisição, poderemos solicitar documentos ou outras informações que possam auxiliar em sua correta identificação, a fim de resguardar nossos direitos e os direitos de terceiros. Isto somente será feito, porém, se for absolutamente necessário, e o requerente receberá todas as informações relacionadas. \n 7 - Medidas de segurança no tratamento de dados pessoais \n Empregamos medidas técnicas e administrativas aptas a proteger os dados pessoais de acessos não autorizados e de situações de destruição, perda, extravio ou alteração desses dados. \n As medidas que utilizamos levam em consideração a natureza dos dados, o contexto e a finalidade do tratamento, os riscos que uma eventual violação geraria para os direitos e liberdades do usuário, as normas de segurança internacionais como a ISO 27001 e os padrões empregados atualmente por empresas/instituições semelhantes à nossa. \n Entre as medidas de segurança adotadas por nós, destacamos as seguintes: \n Ainda que façamos tudo que estiver ao nosso alcance para evitar incidentes de segurança, é possível que ocorra algum problema motivado exclusivamente por um terceiro, como em caso de ataques de hackers ou crackers ou, ainda, em casos de responsabilidade exclusiva do usuário, que ocorre, por exemplo, quando ele mesmo transfere seus dados a um terceiro. Assim, embora sejamos, em geral, responsáveis pelos dados pessoais que tratamos, nos eximimos de responsabilidade caso ocorra uma situação excepcional como as exemplificadas acima, sobre as quais não temos nenhum tipo de controle. \n De qualquer forma, caso ocorra qualquer tipo de incidente de segurança que possa gerar risco ou dano relevante para qualquer de nossos usuários, comunicaremos os afetados e a Autoridade Nacional de Proteção de Dados acerca do ocorrido, em conformidade com o disposto na Legislação aplicável à matéria. \n 8 – Acesso ao Site \n O usuário se declara ciente de que seu login e senha são de uso pessoal e intransferível e que deverá mantê-lo sob sigilo e em ambiente seguro. Ao acessar em nosso site/aplicativo o usuário não deve utilizar como próprio o login e senha alheia ou ceder a outrem, para que dele se utilize. \n 9 - Alterações nesta política \n A presente versão desta Política de Privacidade foi atualizada pela última vez em: 2022-05-23 \n Nos reservamos ao direito de modificar a política de privacidade a qualquer momento, especialmente para adaptá-las às alterações feitas em nosso website, seja pela disponibilização de novas funcionalidades, seja pelo cancelamento ou modificação daquelas já existentes. \n Sempre que houver uma modificação, nossos usuários serão notificados sobre a mudança, podendo a mesma demandar nova aceitação desta Política de Privacidade por parte do usuário como requisito para seguir utilizando os serviços oferecidos nesta plataforma. \n 10 - Como entrar em contato conosco \n Para esclarecer quaisquer dúvidas sobre esta política de privacidade ou sobre os dados pessoais que tratamos, entre em contato com nosso Encarregado de Proteção de Dados, por algum dos canais abaixo: \n E-mail:  tecnologia.unasus@ufma.br \n Telefone: (98) 3272-9638 \n Endereço: \n Avenida dos Portugueses, 1966, Bacanga, Campus Universitário Dom Delgado (Campus Sede da UFMA), Prédio da Diretoria de Tecnologias na Educação – DTED/UFMA. São Luís, MA – CEP: 65080-805 \n 11 – Jurisdição para Resolução de Conflitos \n Este documento é regido e deve ser interpretado de acordo com as leis da República Federativa do Brasil. Os eventuais litígios deverão ser apresentados no foro da Justiça Federal, Seção Judiciária do Estado do Maranhão, in ratione personae, conforme o art. 109, I, da CF/1988, como o competente para dirimir quaisquer questões porventura oriundas do presente documento, com expressa renúncia a qualquer outro, por mais privilegiado que seja.");
  }

  Future<bool> termosCondicoes() async {
    return CloseDialogWidget(context, "Termos e Condições",
            "Os serviços da BIBLIOTECA DIGITAL são fornecidos pela pessoa jurídica Universidade Federal do Maranhão – UFMA, inscrita no CNPJ sob o nº 06.279.103/0001-19, titular da propriedade intelectual sobre software, website, aplicativos, conteúdos e demais ativos relacionados à plataforma. \n Estes termos de uso têm por objetivo definir as regras a serem seguidas para a utilização da BIBLIOTECA DIGITAL, sem prejuízo da aplicação concomitante e supletiva da legislação vigente. \n 1. Do objeto \n A plataforma visa licenciar o uso de seu software, website, aplicativos e demais ativos de propriedade intelectual, fornecendo ferramentas para auxiliar e dinamizar o dia a dia dos seus usuários. \n A plataforma caracteriza-se pela prestação dos seguintes serviços: Serviços da BIBLIOTECA DIGITAL (software, website, aplicativos, conteúdos e demais ativos relacionados à plataforma). \n 2. Da aceitação \n O presente termo e condições gerais de uso estabelece obrigações contratadas de livre e espontânea vontade, por tempo indeterminado, entre a plataforma e as pessoas físicas ou jurídicas, usuárias do aplicativo. \n Ao utilizar a plataforma o usuário aceita integralmente as presentes normas e compromete-se a observá-las, sob o risco de aplicação das penalidades cabíveis. \n A aceitação do presente instrumento é imprescindível para o acesso e para a utilização de quaisquer serviços fornecidos pela empresa. Caso não concorde com as disposições deste instrumento, o usuário não deve utilizá-los. \n 3. Do acesso dos usuários \n Serão utilizadas todas as soluções técnicas à disposição do responsável pela plataforma para permitir o acesso ao serviço 24 (vinte e quatro) horas por dia, 7 (sete) dias por semana. No entanto, a navegação na plataforma ou em alguma de suas páginas poderá ser interrompida, limitada ou suspensa para atualizações, modificações ou qualquer ação necessária ao seu correto e normal funcionamento. \n 4. Do cadastro \n O acesso às funcionalidades da plataforma exigirá a realização de um cadastro prévio. \n Ao se cadastrar o usuário deverá informar dados completos, atuais e válidos, sendo de sua exclusiva responsabilidade manter referidos dados sempre atualizados, bem como o usuário se compromete em prestar informações verdadeiras e responde administrativa, civil e criminalmente pelos dados fornecidos e informações eventualmente prestadas. \n O usuário se compromete a não informar seus dados cadastrais e/ou de acesso à plataforma para terceiros, responsabilizando-se integralmente pelo uso que deles seja feito quando por sua culpa exclusiva. \n Menores de 18 anos e aqueles que não possuírem plena capacidade civil deverão obter previamente o consentimento expresso de seus responsáveis legais para utilização da plataforma e dos serviços ou produtos, sendo de responsabilidade exclusiva dos respectivos responsáveis legais o eventual acesso, sem a sua prévia autorização, por menores de idade e por aqueles que não possuem plena capacidade civil. \n Mediante a realização do cadastro o usuário declara e garante expressamente ser plenamente capaz, podendo exercer e usufruir livremente dos serviços e produtos disponibilizados. \n O usuário deverá fornecer um endereço de e-mail válido, através do qual o site realizará todas as comunicações necessárias. \n Após a confirmação do cadastro, o usuário possuirá um login e uma senha pessoal e intransferível, a qual assegura ao usuário o acesso individual à mesma. Desta forma, compete ao usuário exclusivamente a manutenção da referida senha de maneira confidencial e segura, evitando o acesso indevido às próprias informações pessoais. \n Toda e qualquer atividade realizada com o uso da senha será de responsabilidade do usuário, que deverá informar prontamente à plataforma em caso de uso indevido da respectiva assinatura eletrônica ou qualquer suspeita de quebra de segurança. \n Não será permitido ceder, vender, alugar ou transferir, de qualquer forma, a conta, que é pessoal e intransferível. \n Caberá ao usuário assegurar que o seu equipamento seja compatível com as características técnicas que viabilize a utilização da plataforma e dos serviços ou produtos. \n O usuário poderá, a qualquer tempo, requerer o cancelamento de seu cadastro junto à BIBLIOTECA DIGITAL. O seu descadastramento será realizado o mais rapidamente possível. \n O usuário, ao aceitar os termos e condições gerais de uso e a política de privacidade, autoriza expressamente a plataforma a coletar, usar, armazenar, tratar, ceder ou utilizar as informações derivadas do uso dos serviços, do site e quaisquer plataformas, incluindo todas as informações preenchidas pelo usuário quando realizar ou atualizar seu cadastro, além de outras expressamente descritas na política de privacidade que deverá ser autorizada pelo usuário. \n 5. Do cancelamento \n O usuário poderá cancelar a contratação dos serviços de acordo com os termos que forem definidos no momento de sua contratação. Ainda, o usuário também poderá cancelar os serviços em até 7 (sete) dias após a contratação, mediante contato com o Encarregado de Proteção de Dados, na forma do item 10 da política de privacidade, de acordo com o que preconiza o Código de Defesa do Consumidor (Lei no. 8.078/90). \n O serviço poderá ser cancelado por: \n a) parte do usuário: nessas condições os serviços somente cessarão quando concluído o ciclo vigente ao tempo do cancelamento; \n b) violação dos Termos de Uso: o oferecimento dos serviços será cessado imediatamente. \n 6. Do suporte \n Em caso de qualquer dúvida, sugestão ou problema com a utilização da plataforma, o usuário poderá entrar em contato com o suporte, através do endereço eletrônico <tecnologia.unasus@ufma.br>. \n Estes serviços de atendimento ao usuário estarão disponíveis apenas e tão somente em horário comercial. \n 7. Das responsabilidades \n É de responsabilidade do usuário: \n a) defeitos ou vícios técnicos originados no próprio sistema do usuário; \n b) a correta utilização da plataforma, dos serviços ou produtos oferecidos, prezando pela boa convivência, pelo respeito e cordialidade entre os usuários; \n c) pelo cumprimento e respeito ao conjunto de regras disposto nesse Termo de Condições Geral de Uso, na respectiva Política de Privacidade e na legislação nacional e internacional; \n d) pela proteção aos dados de acesso à sua conta/perfil (login e senha). \n É de responsabilidade da plataforma BIBLIOTECA DIGITAL: \n a) indicar as características do serviço; \n b) os defeitos e vícios encontrados no serviço oferecido desde que lhe tenha dado causa; \n c) as informações que foram por ele divulgadas, sendo que os comentários ou informações divulgadas por usuários são de inteira responsabilidade dos próprios usuários; \n d) os conteúdos ou atividades ilícitas praticadas através da sua plataforma. \n A plataforma não se responsabiliza por links externos contidos em seu sistema que possam redirecionar o usuário à ambiente externo a sua rede. \n Não poderão ser incluídos links externos ou páginas que sirvam para fins comerciais ou publicitários ou quaisquer informações ilícitas, violentas, polêmicas, pornográficas, xenofóbicas, discriminatórias ou ofensivas. \n 8. Dos direitos autorais \n O presente Termo de Uso concede aos usuários uma licença não exclusiva, não transferível e não sublicenciável, para acessar e fazer uso da plataforma e dos serviços e produtos por ela disponibilizados.\n A estrutura do site ou aplicativo, as marcas, logotipos, nomes comerciais, layouts, gráficos e design de interface, imagens, ilustrações, fotografias, apresentações, vídeos, conteúdos escritos e de som e áudio, programas de computador, banco de dados, arquivos de transmissão e quaisquer outras informações e direitos de propriedade intelectual da Universidade Federal do Maranhão – UFMA, observados os termos da Lei da Propriedade Industrial (Lei nº 9.279/96), Lei de Direitos Autorais (Lei nº 9.610/98) e Lei do Software (Lei nº 9.609/98), estão devidamente reservados. \n Este Termo de Uso não cede ou transfere ao usuário qualquer direito, de modo que o acesso não gera qualquer direito de propriedade intelectual ao usuário, exceto pela licença limitada ora concedida. \n O uso da plataforma pelo usuário é pessoal, individual e intransferível, sendo vedado qualquer uso não autorizado, comercial ou não-comercial. Tais usos consistirão em violação dos direitos de propriedade intelectual da razão social Universidade Federal do Maranhão, puníveis nos termos da legislação aplicável. \n 9. Das sanções \n Sem prejuízo das demais medidas legais cabíveis, a Universidade Federal do Maranhão poderá, a qualquer momento, advertir, suspender ou cancelar a conta do usuário: \n a) que violar qualquer dispositivo do presente termo; \n b) que descumprir os seus deveres de usuário; \n c) que tiver qualquer comportamento fraudulento, doloso ou que ofenda a terceiros. \n 10. Da rescisão \n A não observância das obrigações pactuadas neste termo e condições gerais de uso ou da legislação aplicável poderá, sem prévio aviso, ensejar a imediata rescisão unilateral por parte da razão social Universidade Federal do Maranhão e o bloqueio de todos os serviços prestados ao usuário. \n 11. Das alterações \n Os itens descritos no presente instrumento poderão sofrer alterações, unilateralmente e a qualquer tempo, por parte da Universidade Federal do Maranhão, para adequar ou modificar os serviços, bem como para atender novas exigências legais. As alterações serão veiculadas pela BIBLIOTECA DIGITAL e o usuário poderá optar por aceitar o novo conteúdo ou por cancelar o uso dos serviços, caso seja assinante de algum serviço. \n 12. Da política de privacidade \n Além do presente termo, o usuário deverá consentir com as disposições contidas na respectiva política de privacidade a ser apresentada a todos os interessados dentro da interface da plataforma. \n 13. Do foro \n Para a solução de controvérsias decorrentes do presente instrumento será aplicado integralmente o Direito brasileiro. Os eventuais litígios deverão ser apresentados no foro da Justiça Federal, Seção Judiciária do Estado do Maranhão, in ratione personae, conforme o art. 109, I, da CF/1988, como o competente para dirimir quaisquer questões porventura oriundas do presente documento, com expressa renúncia a qualquer outro, por mais privilegiado que seja.") ??
        false;
  }

  popUpCommentSucess(BuildContext context) {
    PopUpMessage(
      context,
      "Comentário adicionado",
      "Seu comentário foi adicionado com sucesso!",
    );
  }

  popUpEvaluationSucess(BuildContext context) {
    PopUpMessage(
      context,
      "Recurso avaliado",
      "Avaliação atualizada com sucesso!",
    );
  }

  popUpReview() async {
    return PopUpReviewResource(
      context,
      "Avaliar Recurso",
      "Você está prestes a avaliar este recurso. Tem certeza que deseja avaliar este recurso?",
      "Avaliar",
    ).then((popup_value) async {
      if (popup_value) {
        try {
          await learningObjectController
              .setReview(widget.learningObject.id, _review!)
              .then((value) {
            if (value != null) {
              setState(() {
                widget.learningObject.averageGrade = value.averageGrade;
                widget.learningObject.numberReviews = value.numberReviews;
              });
              popUpEvaluationSucess(context);
            }
            return value;
          });
        } catch (e) {
          if (e == "Erro de conexão") {
            errorConection(context, () {
              _refreshIndicatorKey.currentState!.show();
            });
          }
        }
      }
    });
  }
}
