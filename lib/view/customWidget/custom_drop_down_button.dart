import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vistorapp/view_model/dialog_view_model.dart';

import '../../utils/app_names.dart';
import '../../utils/constant.dart';

class CustomDropDownButton extends StatelessWidget {
  const CustomDropDownButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DialogViewModel>(
        init: DialogViewModel(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: kButton.withOpacity(0.8)),
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.always,
              child: DropdownButtonFormField(
                  validator: (value) {
                    if (controller.valueDropDown == null)
                      return "Please Choose Category";
                    else
                      return null;
                  },
                  hint: Text(AppNames.bottomSheetViewChooseCategory),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  onTap: () {},
                  dropdownColor: kButton,
                  value: controller.valueDropDown,
                  items: controller.categoryList
                      .map((e) => DropdownMenuItem<String>(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    controller.changeValueOfDropDown(newValue);
                  }),
            ),
          );
        });
  }
}
