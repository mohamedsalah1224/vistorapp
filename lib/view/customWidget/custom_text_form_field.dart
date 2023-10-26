import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_images.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final String icon;
  final String? hintText;
  final String? labelText;
  bool obscureText;
  final bool? eyes;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  String? initialValue;
  CustomTextFormField(
      {super.key,
      required this.icon,
      this.eyes,
      this.initialValue,
      this.validator,
      this.obscureText = false,
      this.onSaved,
      this.hintText,
      this.controller,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return TextFormField(
            controller: controller,
            obscureText: obscureText,
            onSaved: onSaved,
            initialValue: initialValue,
            validator: validator,
            decoration: InputDecoration(
                hintText: hintText,
                floatingLabelBehavior: FloatingLabelBehavior
                    .always, // to show the label in above always
                hintStyle: TextStyle(fontSize: 12, color: Color(0xff727272)),
                suffixIcon: eyes == null
                    ? icon.isEmpty
                        ? null
                        : Image.asset(
                            icon,
                            cacheHeight: 24.h.toInt(),
                            cacheWidth: 24.w.toInt(),
                          )
                    : getImage(
                        show: obscureText,
                        onTap: () {
                          setState(() => obscureText = !obscureText);
                        }),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xff373737),
                      width: 2,
                    )),
                errorBorder: OutlineInputBorder(
                    // wehen erro occure
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1,
                    )),
                border: OutlineInputBorder(
                    // when focus in erro
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Colors.redAccent,
                      width: 1,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    )),
                labelText: labelText,
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
          );
        },
      ),
    );
  }

  Widget getImage({required bool show, required void Function()? onTap}) =>
      InkWell(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        child: Image.asset(
          !show
              ? Assets.imagesIconlyLightOutlineShow
              : Assets.imagesIconlyLightOutlineHide,
          cacheHeight: 24.h.toInt(),
          cacheWidth: 24.w.toInt(),
        ),
        onTap: onTap,
      );
}
