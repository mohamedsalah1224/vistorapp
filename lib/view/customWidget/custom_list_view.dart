import 'package:flutter/material.dart';
import 'package:vistorapp/view_model/home_view_model.dart';
import 'package:get/get.dart';

import 'custom_card_photo.dart';
import 'custom_dialog.dart';

class CustomListView extends GetView<HomeViewModel> {
  const CustomListView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      builder: (controller) {
        return controller.valueNotifier.value
            ? ListView.separated(
                scrollDirection: Axis.vertical,
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
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 20,
                  );
                },
                itemCount: controller.listAllPosts.length)
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
