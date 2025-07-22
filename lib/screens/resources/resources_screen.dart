import 'package:bd_mtur/screens/resources/all_resources_screen.dart';
import 'package:bd_mtur/screens/resources/categories_resources.dart';
import 'package:flutter/material.dart';
import 'package:bd_mtur/core/core.dart';
import 'package:bd_mtur/core/app_screens.dart';

class Resources extends StatelessWidget {
  static const routeName = "/resources";
  final String? format;

  Resources({Key? key, this.format}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              TabBar(
                indicatorColor: AppColors.colorDark,
                labelColor: AppColors.colorDark,
                unselectedLabelColor: AppColors.greyDark,
                labelStyle: AppTextStyles.labelTabControllerActive,
                unselectedLabelStyle: AppTextStyles.labelTabController,
                tabs: const [
                  Tab(
                    text: "Ver tudo",
                  ),
                  Tab(
                    text: "Ver temáticas",
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    AllResources(format: format),
                    CategoriesResources(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
