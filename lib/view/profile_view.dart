import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vistorapp/view_model/profile_view_model.dart';
import '../utils/app_images.dart';
import '../utils/constant.dart';
import 'customWidget/custom_button.dart';
import 'customWidget/custom_text.dart';
import 'customWidget/custom_text_form_field.dart';

class ProfileView extends GetView<ProfileViewModel> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: "Profile",
          fontSize: 17.sp,
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
            key: controller.formKey,
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 15,
                      bottom: MediaQuery.of(context).size.height / 15,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      await controller.loadImage(
                                          source: Source.gallary);
                                    },
                                    child: Text("Gallary"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await controller.loadImage(
                                          source: Source.camera);
                                    },
                                    child: Text("Camera"),
                                  )
                                ],
                              );
                            });
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        clipBehavior: Clip.none,
                        children: [
                          GetBuilder<ProfileViewModel>(
                            init: ProfileViewModel(),
                            builder: (controller) {
                              return Container(
                                  width: 71,
                                  height: 71,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image:
                                              controller.userModel.image == ""
                                                  ? const AssetImage(
                                                      Assets.user,
                                                    )
                                                  : controller.imageFile != null
                                                      ? FileImage(
                                                          controller.imageFile!)
                                                      : NetworkImage(controller
                                                              .userModel.image!)
                                                          as ImageProvider)));
                            },
                          ),
                          Positioned(
                            bottom: -10,
                            right: 15,
                            child: Image.asset(
                              Assets.imagesIconlyLightEdit,
                              cacheHeight: 24.h.toInt(),
                              cacheWidth: 24.w.toInt(),
                            ),
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                CustomTextFormField(
                  icon: "",
                  labelText: "First Name",
                  hintText: "Enter your Name",
                  initialValue: controller.firstNameController,
                  onSaved: (value) {
                    controller.firstNameController = value!;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                CustomTextFormField(
                  icon: "",
                  labelText: "Last Name",
                  initialValue: controller.lastNameController,
                  hintText: "Enter your Last Name",
                  onSaved: (value) {
                    controller.lastNameController = value!;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                CustomButton(
                    text: "Update",
                    onTap: () async {
                      await controller.updateProfile();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
