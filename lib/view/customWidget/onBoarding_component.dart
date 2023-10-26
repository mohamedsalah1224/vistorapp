import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_text.dart';

class OnboardingComponent extends StatelessWidget {
  final String text;
  final String image;
  final double heightSpace;

  OnboardingComponent(
      {required this.heightSpace, required this.image, required this.text});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          image,
          // width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.width,
        ),
        SizedBox(
          height: heightSpace != 0
              ? MediaQuery.of(context).size.height / heightSpace
              : 0,
        ),
        CustomText(
          text: text,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
