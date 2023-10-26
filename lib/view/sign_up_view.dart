import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vistorapp/utils/app_names.dart';
import 'package:vistorapp/utils/constant.dart';
import 'package:get/get.dart';
import 'package:vistorapp/view_model/auth_page_state_view_model.dart';
import 'package:vistorapp/view_model/auth_view_model.dart';

import '../utils/app_images.dart';

import 'customWidget/custom_button.dart';
import 'customWidget/custom_text.dart';
import 'customWidget/custom_text_form_field.dart';

class SignUpView extends GetView<AuthViewModel> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: AppNames.signUpTitle,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        leading: GetBuilder<AuthPageStateViewModel>(
          init: AuthPageStateViewModel(),
          builder: (controller) {
            return IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => controller.toggle());
          },
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 25),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: controller.formKeySignUp,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                CustomTextFormField(
                  icon: "",
                  labelText: AppNames.signUpFirstName,
                  hintText: AppNames.signUpEnterYourFirstName,
                  onSaved: (value) => controller.firstNameController = value!,
                  validator: (value) => controller.validateName(name: value),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                CustomTextFormField(
                  icon: "",
                  labelText: AppNames.signUpLastName,
                  hintText: AppNames.signUpEnterYourLastName,
                  onSaved: (value) => controller.lastNameController = value!,
                  validator: (value) => controller.validateName(name: value),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                CustomTextFormField(
                  icon: Assets.imagesIconlyLightMessage,
                  labelText: AppNames.signUpEmail,
                  hintText: AppNames.signUpEnterYourEmail,
                  onSaved: (value) => controller.emailControlelr = value!,
                  validator: (value) => controller.validateEmail(email: value),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                CustomTextFormField(
                  icon: "",
                  eyes: true,
                  obscureText: true,
                  labelText: AppNames.signUpPassword,
                  hintText: AppNames.signUpEnterYourPassword,
                  onSaved: (value) => controller.passwordController = value!,
                  validator: (value) =>
                      controller.validatePassword(password: value),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                CustomTextFormField(
                  icon: "",
                  eyes: true,
                  obscureText: true,
                  labelText: AppNames.signUpConfirmPassword,
                  hintText: AppNames.signUpEnterYourConfirmPassword,
                  onSaved: (value) =>
                      controller.confirmPasswordController = value!,
                  validator: (value) => controller.validateConfirmPassword(
                      inputPw: controller.passwordController, confirmPw: value),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                CustomButton(
                    text: AppNames.signUpButton,
                    onTap: () {
                      controller.signUp();
                    }),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: AppNames.signUpHaveAccount,
                      fontSize: 13,
                    ),
                    GetBuilder<AuthPageStateViewModel>(
                      init: AuthPageStateViewModel(),
                      builder: (controller) {
                        return InkWell(
                          onTap: () => controller.toggle(),
                          child: CustomText(
                            text: AppNames.signUpLogInButton,
                            color: kButton,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
