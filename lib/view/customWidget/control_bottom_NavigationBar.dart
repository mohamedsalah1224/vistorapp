import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vistorapp/utils/app_images.dart';
import 'package:vistorapp/utils/app_names.dart';
import 'package:vistorapp/utils/constant.dart';
import 'package:vistorapp/utils/type_of_user_login.dart';
import 'package:vistorapp/view/customWidget/custom_button.dart';
import 'package:vistorapp/view/customWidget/custom_drop_down_button.dart';
import 'package:vistorapp/view/customWidget/custom_text_form_field.dart';
import 'package:vistorapp/view/custom_bottom_Navigation_Bar.dart';
import 'package:vistorapp/view_model/category_view_model.dart';
import 'package:vistorapp/view_model/dialog_view_model.dart';
import 'package:vistorapp/view_model/home_view_model.dart';
import 'package:get/get.dart';
import 'custom_text.dart';

class ControlBottomNavigationBar extends StatelessWidget {
  const ControlBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: TypeOfUserLogin.instance.isGuset()
          ? null
          : TypeOfUserLogin.instance.isAdmin()
              ? Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    customAddCategory(context),
                    SizedBox(
                      height: 10,
                    ),
                    customAddPost(context)
                  ]))
              : customAddPost(context),
      body: GetBuilder<HomeViewModel>(
        init: Get.find<HomeViewModel>(),
        builder: (controller) {
          return controller
              .myScreen[controller.currentBottomNavigationBarIndex];
        },
      ),
    );
  }
}

Widget customAddPost(BuildContext context) {
  return GetBuilder<DialogViewModel>(
    init: DialogViewModel(),
    builder: (controller) {
      return FloatingActionButton(
        backgroundColor: Colors.white,
        heroTag: null,
        child: Image.asset(
          Assets.camera,
          cacheHeight: 24,
          cacheWidth: 24,
        ),
        onPressed: () {
          controller.refreshController();
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              showDragHandle: false,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))),
              builder: (context) {
                return Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -30.h,
                      child: GestureDetector(
                        onTap: () async {
                          await controller.closeBottomSheet();
                        },
                        child: CircleAvatar(
                          radius: 30.r,
                          backgroundColor: kButton,
                          child: Image.asset(
                            Assets.remove,
                            color: Colors.white,
                            cacheHeight: 50,
                            cacheWidth: 50,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 60.h,
                          horizontal:
                              MediaQuery.of(context).size.height / 70.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height / 60.h,
                            ),
                            child: const CustomText(
                              text: AppNames.bottomSheetViewTitle,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GetBuilder<DialogViewModel>(
                            init: DialogViewModel(),
                            builder: (controller) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 10.h,
                                    ),
                                    width: double.infinity,
                                    height: 250.h,
                                    decoration: BoxDecoration(
                                        color: kButton,
                                        image: controller.imageFile == null
                                            ? null
                                            : DecorationImage(
                                                fit: BoxFit.fill,
                                                image: FileImage(
                                                    controller.imageFile!)),
                                        borderRadius:
                                            BorderRadius.circular(12.r)),
                                  ),
                                  controller.isSelectedImage
                                      ? Container(
                                          margin: EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            bottom: 20,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Divider(
                                                color: Colors.red,
                                                thickness: 1,
                                              ),
                                              CustomText(
                                                text: "Please Choose Picture",
                                                color:
                                                    Colors.red.withOpacity(1),
                                                fontSize: 14,
                                              ),
                                            ],
                                          ),
                                        )
                                      : SizedBox()
                                ],
                              );
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kButton),
                                  onPressed: () async {
                                    await controller.loadImage(
                                        source: Source.camera);
                                  },
                                  child: Text(AppNames.bottomSheetViewCamera)),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kButton),
                                  onPressed: () async {
                                    await controller.loadImage(
                                        source: Source.gallary);
                                  },
                                  child: Text(AppNames.bottomSheetViewGallary))
                            ],
                          ),
                          GetBuilder<DialogViewModel>(
                            init: DialogViewModel(),
                            builder: (controller) {
                              return controller.valueNotifier.value
                                  ? CustomDropDownButton()
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            },
                          ),
                          CustomButton(
                              text: AppNames.bottomSheetViewUploadPostButton,
                              onTap: () async {
                                await controller.uploadPost();
                              })
                        ],
                      ),
                    ),
                  ],
                );
              });
        },
      );
    },
  );
}

Widget customAddCategory(BuildContext context) {
  return GetBuilder<CategoryViewModel>(
    init: CategoryViewModel(),
    builder: (controller) {
      return FloatingActionButton(
        heroTag: null,
        onPressed: () {
          showModalBottomSheet(
              builder: (context) {
                return Container(
                  height: MediaQuery.of(context).size.height / 3,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const CustomText(
                            text: AppNames.bottomSheetViewTwoTitle,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(
                              height:
                                  (MediaQuery.of(context).size.height / 3) / 4),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Center(
                                child: Form(
                                  key: controller.formKeycategory,
                                  child: CustomTextFormField(
                                    icon: "",
                                    hintText: "Enter your Category",
                                    onSaved: (value) {
                                      controller.categoryControlelr = value!;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty)
                                        return "Please Enter Category";
                                      else
                                        return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
                                  text: "Add",
                                  onTap: () async {
                                    await controller.addNewCategory();
                                  })
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              context: context,
              isScrollControlled: true,
              isDismissible: true,
              showDragHandle: false,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12))));
        },
        child: Icon(
          Icons.add,
          color: Colors.grey.shade700,
        ),
        backgroundColor: Colors.white,
      );
    },
  );
}
