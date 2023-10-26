import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vistorapp/utils/constant.dart';
import 'package:vistorapp/view/customWidget/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const CustomButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        width: 343.w,
        decoration: BoxDecoration(
            color: kButton, borderRadius: BorderRadius.circular(10.w)),
        alignment: AlignmentDirectional.center,
        child: CustomText(
          text: text,
          color: Colors.white,
          fontSize: 17.sp,
        ),
      ),
    );
  }
}
