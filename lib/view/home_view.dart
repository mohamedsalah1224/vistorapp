import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vistorapp/utils/app_images.dart';
import 'package:vistorapp/utils/app_names.dart';
import 'package:vistorapp/utils/constant.dart';
import 'package:vistorapp/utils/routes.dart';
import 'package:vistorapp/utils/type_of_user_login.dart';
import 'package:vistorapp/view/customWidget/custom_grid_view.dart';
import 'package:vistorapp/view_model/home_view_model.dart';
import 'package:get/get.dart';

import 'customWidget/custom_list_view.dart';
import 'customWidget/custom_text.dart';

class HomeView extends GetView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: AppNames.homeViewTitle,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        leading: TypeOfUserLogin.instance.isGuset()
            ? null
            : GestureDetector(
                child: Image.asset(Assets.person),
                onTap: () => Get.toNamed(Routes.profileView)),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.logOut();
            },
            icon: Icon(
              Icons.power_settings_new_outlined,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 25),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 40,
                bottom: MediaQuery.of(context).size.height / 25,
              ),
              child: GetBuilder<HomeViewModel>(
                init: Get.find<HomeViewModel>(),
                builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 43.w,
                        height: 43.h,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            if (controller.currentIndex != 0)
                              controller.ChangeCurrentIndex();
                          },
                          child: Image.asset(
                            Assets.list,
                            color:
                                controller.currentIndex == 0 ? kButton : null,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 20,
                      ),
                      Container(
                        width: 43.w,
                        height: 43.h,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          splashFactory: NoSplash.splashFactory,
                          onTap: () {
                            if (controller.currentIndex != 1)
                              controller.ChangeCurrentIndex();
                          },
                          child: Image.asset(
                            Assets.grid,
                            color:
                                controller.currentIndex == 1 ? kButton : null,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const CustomText(
              text: AppNames.homeViewUserPhoto,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              alignment: AlignmentDirectional.topStart,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 70,
            ),
            Expanded(
              child: GetBuilder<HomeViewModel>(
                init: Get.find<HomeViewModel>(),
                builder: (controller) {
                  return controller.currentIndex == 0
                      ? const CustomListView()
                      : const CustomGridView();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
/*
width: 191.w,
      height: 209.h,
*/
}
