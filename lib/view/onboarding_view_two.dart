import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vistorapp/utils/app_names.dart';
import 'package:vistorapp/utils/routes.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vistorapp/utils/type_of_user_login.dart';
import '../utils/app_images.dart';
import 'customWidget/custom_button.dart';
import 'customWidget/custom_text.dart';
import 'customWidget/onBoarding_component.dart';

class OnboardingViewTwo extends StatelessWidget {
  const OnboardingViewTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 25,
            right: MediaQuery.of(context).size.width / 25,
            top: MediaQuery.of(context).size.height / 50,
            bottom: MediaQuery.of(context).size.height / 50,
          ),
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.offAllNamed(Routes.loginView);
                    },
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                    child: CustomText(
                      text: AppNames.onBoardingTwoSkip,
                      alignment: AlignmentDirectional.topStart,
                      fontSize: 15.sp,
                      color: Color(0xff727272),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  OnboardingComponent(
                    image: Assets.imagesOnBoarding2,
                    text: AppNames.onBoardingTwoChooseCategory,
                    heightSpace: 15,
                    // 236.35 , 249.28 , 15
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  CustomButton(
                    text: AppNames.onBoardingTwoNext,
                    onTap: () async {
                      await TypeOfUserLogin.instance.setOpenTheApp();
                      Get.toNamed(Routes.loginView);
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
