import 'package:get/get.dart';

class AuthPageStateViewModel extends GetxController {
  bool isLogin = true;

  void toggle() {
    isLogin = !isLogin;
    update();
  }
}
