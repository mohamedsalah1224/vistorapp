import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vistorapp/utils/app_images.dart';
import 'package:vistorapp/utils/routes.dart';
import 'package:vistorapp/view/customWidget/custom_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../utils/app_names.dart';
import 'customWidget/custom_button.dart';
import 'customWidget/onBoarding_component.dart';

class OnboardingViewOne extends StatelessWidget {
  const OnboardingViewOne({super.key});

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
                      text: AppNames.onBoardingOneSkip,
                      alignment: AlignmentDirectional.topStart,
                      fontSize: 15.sp,
                      color: Color(0xff727272),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Center(
                    child: OnboardingComponent(
                      image: Assets.imagesOnBoarding1,
                      text: AppNames.onBoardingOneTakePhoto,
                      heightSpace: 15,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 5,
                  ),
                  CustomButton(
                    text: AppNames.onBoardingOneNext,
                    onTap: () {
                      Get.toNamed(Routes.onboardingViewTwo);
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

Widget onboardingComponent(BuildContext context,
    {required String text, required String image}) {
  return Column(
    children: [
      SvgPicture.asset(
        image,
      ),
      CustomText(
        text: text,
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
      ),
    ],
  );
}
