import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:bd_mtur/screens/content/content_video_player_screen.dart';
import 'package:bd_mtur/core/app_screens.dart';

import 'package:bd_mtur/screens/home/topics_screen.dart';
import 'package:bd_mtur/screens/resources/categories_resources.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Detecta se está no Web com largura de tela maior que 600
        final mediaQuery = MediaQuery.of(context);
        final isWebLarge = kIsWeb && mediaQuery.size.width > 600;

        if (isWebLarge) {
          return Scaffold(
            backgroundColor: Colors.black12,
            body: Center(
              child: Container(
                width: 390,
                height: 844,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                    ),
                  ],
                ),
                clipBehavior: Clip.hardEdge,
                child: child,
              ),
            ),
          );
        } else {
          return child!;
        }
      },
      initialRoute: "splash",
      routes: <String, WidgetBuilder>{
        "splash": (context) => Splash(),
        "login": (context) => Login(),
        "recoverPassword": (context) => RecoverPassword(),
        "codeValidation": (context) => CodeValidation(),
        "resetPassword": (context) => ResetPassword(),
        "register": (context) => Register(),
        Home.routeName: (context) => Home(),
        ContinueContent.routeName: (context) => ContinueContent(),
        Topics.routeName: (context) => Topics(),
        Resources.routeName: (context) => Resources(),
        Content.routeName: (context) => Content(),
        CategoriesResources.routeName: (context) => CategoriesResources(),
        "favorites": (context) => Favorites(),
        "news": (context) => News(),
        "profile": (context) => Profile(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == PDFScreen.routeName) {
          final args = settings.arguments as PDFArgumentsScreen;
          return MaterialPageRoute(
            builder: (context) => PDFScreen(pdfPath: args.url),
          );
        }

        if (settings.name == VideoPlayerContent.routeName) {
          final args = settings.arguments as VideoPlayerContentArgumentsScreen;
          return MaterialPageRoute(
            builder: (context) => VideoPlayerContent(
              learningObject: args.learningObject,
            ),
          );
        }

        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
