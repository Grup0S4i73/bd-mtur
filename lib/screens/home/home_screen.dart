// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_screens.dart';
import 'package:bd_mtur/core/app_widgets.dart';

import 'package:bd_mtur/controllers/user_controller.dart';
import 'package:bd_mtur/models/user_model.dart';

class Home extends StatefulWidget {
  static const routeName = "/home";
  int selectedIndex;

  Home({
    Key? key,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    HomeArgumentsScreen? arguments =
        ModalRoute.of(context)!.settings.arguments as HomeArgumentsScreen?;

    setState(() {
      if (arguments != null && arguments.selectedIndex != null) {
        widget.selectedIndex = arguments.selectedIndex!;
      }
      _pageController = PageController(initialPage: widget.selectedIndex);
    });

    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomeContent(),
          Resources(format: arguments?.title),
          Favorites(),
          News(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.greyLightMedium,
        backgroundColor: AppColors.colorDark,
        type: BottomNavigationBarType.fixed,
        onTap: (p) {
          if (arguments != null) {
            arguments.selectedIndex = null;
          }
          _onItemTapped(p);
          _pageController.jumpToPage(
            p,
          );
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Recursos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Novidades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
