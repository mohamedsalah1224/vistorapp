import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vistorapp/utils/type_of_user_login.dart';
import 'package:vistorapp/view/customWidget/auth_page_state.dart';
import 'package:vistorapp/view/customWidget/control_bottom_NavigationBar.dart';
import 'package:vistorapp/view/onboarding_view.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShopt) {
        if (snapShopt.hasData) {
          return const ControlBottomNavigationBar();
        } else {
          if (TypeOfUserLogin.instance.isFirstOpenTheApp()) {
            return const OnboardingViewOne();
          } else {
            return const AuthPageState();
          }
        }
      },
    );
  }
}
