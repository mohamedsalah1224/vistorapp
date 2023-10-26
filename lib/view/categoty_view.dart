import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vistorapp/utils/app_names.dart';
import 'package:vistorapp/utils/constant.dart';
import 'package:vistorapp/view/customWidget/custom_grid_category.dart';
import 'package:vistorapp/view/customWidget/custom_text.dart';
import 'package:get/get.dart';
import '../utils/type_of_user_login.dart';
import '../view_model/category_view_model.dart';

class CategoryView extends GetView<CategoryViewModel> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: CustomText(
          text: AppNames.categoryViewTitle,
          fontSize: 20.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        centerTitle: true,
        actions: [
          TypeOfUserLogin.instance.isAdmin()
              ? IconButton(
                  onPressed: () async {
                    await controller.deleteCategory();
                  },
                  icon: Icon(
                    Icons.dangerous_outlined,
                    color: kButton,
                    size: 30,
                  ))
              : const SizedBox()
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 25.w),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 40.h,
                  bottom: MediaQuery.of(context).size.height / 50.h,
                ),
                child: CustomText(
                  text: AppNames.categoryViewChooseCategory,
                  alignment: AlignmentDirectional.topStart,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                )),
            SizedBox(
                height: 20,
                child: GetBuilder<CategoryViewModel>(
                  builder: (controller) {
                    return controller.valueNotifierCategory.value
                        ? ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.changeCurrentIndex(index);
                                },
                                child: compnentNameCategory(
                                    text: controller.categoryList[index].name,
                                    index: index,
                                    currentIndex: controller.currentIndex),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: MediaQuery.of(context).size.width / 20.w,
                              );
                            },
                            itemCount: controller.categoryList.length,
                          )
                        : Center(
                            child: const CircularProgressIndicator(),
                          );
                  },
                )),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GetBuilder<CategoryViewModel>(
                  init: Get.find<CategoryViewModel>(),
                  builder: (controller) {
                    return controller.valueNotifierPosts.value
                        ? controller.postList.isNotEmpty
                            ? CustomGridCategory(
                                myList: controller.postList,
                              )
                            : Center(
                                child: Text(AppNames.categoryViewEmptyPosts),
                              )
                        : Center(
                            child: CircularProgressIndicator(),
                          );
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget compnentNameCategory(
      {required String text, required int index, required int currentIndex}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        child: CustomText(
          text: text,
          fontSize: 15,
        ),
        decoration: BoxDecoration(
            border: index == currentIndex
                ? Border(bottom: BorderSide(color: kButton))
                : null),
      ),
    );
  }
}
