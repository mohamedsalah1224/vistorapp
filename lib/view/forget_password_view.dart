import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vistorapp/utils/app_names.dart';
import 'package:vistorapp/view_model/auth_view_model.dart';

import '../utils/app_images.dart';
import 'customWidget/custom_button.dart';
import 'customWidget/custom_text.dart';
import 'customWidget/custom_text_form_field.dart';

class ForgetPasswordView extends GetView<AuthViewModel> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: AppNames.forgetPasswordTitle,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Get.back()),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 25),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKeyforgetPassword,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 40,
                    bottom: MediaQuery.of(context).size.height / 10,
                  ),
                  child: SvgPicture.asset(
                    Assets.imagesForgetPassword,
                    width: 258.84.w,
                    height: 192.87.h,
                  ),
                ),
                CustomText(
                  text: AppNames.forgetPasswordMessage,
                  fontSize: 12.sp,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                CustomTextFormField(
                  icon: Assets.imagesIconlyLightMessage,
                  labelText: AppNames.forgetPasswordEmail,
                  hintText: AppNames.forgetPasswordEnterYourEmail,
                  onSaved: (value) => controller.emailControlelr = value!,
                  validator: (value) => controller.validateEmail(email: value),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                CustomButton(
                    text: AppNames.forgetPasswordSend,
                    onTap: () async {
                      await controller.resetPassword();
                      Navigator.of(context).pop();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
