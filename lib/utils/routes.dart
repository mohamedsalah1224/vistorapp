import 'package:get/get.dart';
import 'package:vistorapp/view/splash_view.dart';

import '../view/customWidget/control_bottom_NavigationBar.dart';
import '../view/customWidget/main_page.dart';
import '../view/profile_view.dart';
import '../view/forget_password_view.dart';
import '../view/login_view.dart';

import '../view/onboarding_view_two.dart';
import '../view/sign_up_view.dart';
import 'binding.dart';

class Routes {
  // OnboardingViewTwo
  static const String splashRoute = "/";
  static const String initialRoute = "/initialRoute";
  static const String onboardingViewTwo = "/OnboardingViewTwo";

  static const String loginView = "/loginView";
  static const String forgetPasswordView = "/forgetPasswordView";
  static const String signupView = "/signupView";
  static const String homeView = "/homeView";
  static const String categoriesView = "/categoriesView";
  static const String choosePhotoView = "/choosePhotoView";
  static const String profileView = "/profileView";

  static List<GetPage<dynamic>>? getPages() => [
        GetPage(
            name: splashRoute,
            page: () => const SplashView(),
            binding: MyBinding()),
        GetPage(
            name: initialRoute,
            page: () => const MainPage(),
            binding: MyBinding()),
        GetPage(
            name: onboardingViewTwo,
            page: () => const OnboardingViewTwo(),
            binding: MyBinding()),
        GetPage(
            name: loginView,
            page: () => const LoginView(),
            binding: MyBinding()),
        GetPage(
            name: signupView,
            page: () => const SignUpView(),
            binding: MyBinding()),
        GetPage(
            name: homeView,
            page: () => const ControlBottomNavigationBar(),
            binding: MyBinding()),
        GetPage(
            name: profileView,
            page: () => const ProfileView(),
            binding: MyBinding()),
        GetPage(
            name: forgetPasswordView,
            page: () => const ForgetPasswordView(),
            binding: MyBinding()),
      ];
}
