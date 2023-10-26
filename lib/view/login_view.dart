import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vistorapp/utils/app_images.dart';
import 'package:vistorapp/utils/constant.dart';
import 'package:vistorapp/utils/routes.dart';
import 'package:vistorapp/view/customWidget/custom_button.dart';
import 'package:vistorapp/view/customWidget/custom_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vistorapp/view_model/auth_page_state_view_model.dart';
import 'package:vistorapp/view_model/auth_view_model.dart';

import '../utils/app_names.dart';
import 'customWidget/custom_text_form_field.dart';

class LoginView extends GetView<AuthViewModel> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: AppNames.loginViewTitle,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 25),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKeyLogIn,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 40,
                    bottom: MediaQuery.of(context).size.height / 10,
                  ),
                  child: Image.asset(
                    Assets.logo,
                    cacheWidth: 100.w.toInt(),
                    cacheHeight: 200.h.toInt(),
                  ),
                ),
                CustomTextFormField(
                    icon: Assets.imagesIconlyLightMessage,
                    labelText: AppNames.loginViewEmail,
                    hintText: AppNames.loginViewEnterYourEmail,
                    onSaved: (value) => controller.emailControlelr = value!,
                    validator: (value) =>
                        controller.validateEmail(email: value)),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                CustomTextFormField(
                  icon: "",
                  eyes: true,
                  obscureText: true,
                  labelText: AppNames.loginViewPassword,
                  hintText: AppNames.loginViewEnterYourPassword,
                  onSaved: (value) => controller.passwordController = value!,
                  validator: (value) =>
                      controller.validatePassword(password: value),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 150,
                ),
                Container(
                  alignment: AlignmentDirectional.topEnd,
                  child: TextButton(
                      child: CustomText(
                        text: AppNames.loginViewForgetPassword,
                        color: kButton,
                      ),
                      onPressed: () => Get.toNamed(Routes.forgetPasswordView)),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                CustomButton(
                    text: AppNames.loginViewLogInButton,
                    onTap: () async {
                      await controller.logIn(context);
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppNames.loginViewDontHaveAccount,
                      fontSize: 13,
                    ),
                    GetBuilder<AuthPageStateViewModel>(
                      init: AuthPageStateViewModel(),
                      builder: (controller) {
                        return InkWell(
                          onTap: () => controller.toggle(),
                          child: CustomText(
                            text: AppNames.loginViewSignUpButton,
                            color: kButton,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Container(
                  alignment: AlignmentDirectional.topStart,
                  child: TextButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.loginView);
                      },
                      child: GestureDetector(
                        onTap: () async {
                          await controller.skipLoginProcess();
                          Get.offAllNamed(Routes.homeView);
                        },
                        child: CustomText(
                          text: AppNames.loginViewSkipLogin,
                          color: kButton,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
