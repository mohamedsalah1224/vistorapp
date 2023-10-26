import 'package:get/get.dart';
import 'package:vistorapp/view_model/auth_view_model.dart';
import 'package:vistorapp/view_model/dialog_view_model.dart';
import 'package:vistorapp/view_model/profile_view_model.dart';
import 'package:vistorapp/view_model/splash_view_model.dart';
import '../view_model/category_view_model.dart';
import '../view_model/home_view_model.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthViewModel(),
    );
    Get.lazyPut(() => HomeViewModel(), fenix: true);
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => CategoryViewModel(), fenix: true);
    Get.lazyPut(() => ProfileViewModel());
    Get.put(() => SplashViewModel());
    Get.lazyPut(
      () => DialogViewModel(),
    );
    Get.put(
      () => AuthPageStateBinding(),
    );
  }
}
// AuthPageStateViewModel

class AuthPageStateBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => AuthPageStateBinding(),
    );
  }
}
