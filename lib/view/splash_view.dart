import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vistorapp/utils/app_images.dart';
import 'package:vistorapp/utils/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offAllNamed(Routes.initialRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
            child: Image.asset(
          Assets.splashScreen,
          cacheHeight: 200.h.toInt(),
          cacheWidth: 200.w.toInt(),
        )),
      ),
    );
  }
}
