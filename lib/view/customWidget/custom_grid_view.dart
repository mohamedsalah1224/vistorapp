import 'package:flutter/material.dart';
import 'package:vistorapp/view/customWidget/custom_card_photo.dart';
import 'package:vistorapp/view_model/home_view_model.dart';
import 'package:get/get.dart';
import 'custom_dialog.dart';

class CustomGridView extends GetView<HomeViewModel> {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) {
        return controller.valueNotifier.value
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: MediaQuery.of(context).size.width / 20,
                  mainAxisSpacing: MediaQuery.of(context).size.width / 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      CustomDialogUtils.instance.showCustomDialog(context,
                          isRemovedFromCategory: false,
                          index: index,
                          postModel: controller.listAllPosts[index]);
                    },
                    child: CustomCardPhoto(
                      postModel: controller.listAllPosts[index],
                      isCategoryView: true,
                    ),
                  );
                },
                itemCount: controller.listAllPosts.length,
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
