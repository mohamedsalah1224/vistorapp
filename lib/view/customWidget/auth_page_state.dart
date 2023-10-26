import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vistorapp/view/sign_up_view.dart';
import 'package:vistorapp/view_model/auth_page_state_view_model.dart';

import '../login_view.dart';

class AuthPageState extends StatelessWidget {
  const AuthPageState({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthPageStateViewModel>(
      init: AuthPageStateViewModel(),
      builder: (controller) {
        return controller.isLogin ? LoginView() : SignUpView();
      },
    );
  }
}
