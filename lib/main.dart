import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:vistorapp/service/local/hive/cahce_user_hive.dart';
import 'package:vistorapp/service/local/shared_preferences_service.dart';
import 'package:vistorapp/service/local/hive/hive_posts_like.dart';
import 'package:vistorapp/utils/routes.dart';

import 'package:get/get.dart';

import 'model/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await CacheUserHive.instance.init();
  await HivePostsLike.instance.init();

  await SharedPreferencesService.instance.initSharedPreferences();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: Routes.getPages(),
          initialRoute: Routes.splashRoute,

          title: 'Dein Park',

          // You can use the library anywhere in the app even in theme
        );
      },
    );
  }
}
