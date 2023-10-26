import 'package:flutter/material.dart';
import 'package:vistorapp/utils/app_names.dart';
import 'package:vistorapp/view_model/home_view_model.dart';
import 'package:get/get.dart';

import '../utils/app_images.dart';
import '../utils/constant.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) {
        return BottomNavigationBar(
          selectedItemColor: kButton.withOpacity(0.6),
          selectedFontSize: 11,
          items: [
            // Categories
            BottomNavigationBarItem(
              icon: Image.asset(
                Assets.home,
                cacheHeight: 24,
                cacheWidth: 24,
              ),
              label: AppNames.bottomNavigationBarHome,
              activeIcon: Image.asset(
                Assets.home,
                cacheHeight: 24,
                cacheWidth: 24,
                color: kButton,
              ),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                Assets.category,
                cacheHeight: 24,
                cacheWidth: 24,
                color: Color(0xff727272),
              ),
              label: AppNames.bottomNavigationBarCategory,
              activeIcon: Image.asset(
                Assets.category,
                cacheHeight: 24,
                cacheWidth: 24,
                color: kButton,
              ),
            ),
          ],
          currentIndex: controller.currentBottomNavigationBarIndex,
          onTap: (index) {
            controller.ChangeCurrentBottomNavigationBarIndex(index);
          },
        );
      },
    );
  }
}
