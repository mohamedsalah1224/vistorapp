import 'package:flutter/material.dart';

import 'package:vistorapp/model/post_model.dart';
import 'package:vistorapp/view/customWidget/custom_card_photo.dart';

import 'custom_dialog.dart';

class CustomGridCategory extends StatelessWidget {
  final List<PostModel> myList;
  const CustomGridCategory({super.key, required this.myList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: MediaQuery.of(context).size.width / 20,
            mainAxisSpacing: MediaQuery.of(context).size.width / 10,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                CustomDialogUtils.instance.showCustomDialog(context,
                    isRemovedFromCategory: true,
                    postModel: myList[index],
                    index: index);
              },
              child: CustomCardPhoto(
                postModel: myList[index],
              ),
            );
          },
          itemCount: myList.length,
        ));
  }
}
