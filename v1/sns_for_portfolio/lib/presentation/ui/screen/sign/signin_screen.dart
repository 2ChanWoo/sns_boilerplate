import 'package:flutter/material.dart';
import 'package:sns_for_portfolio/app/router/router.dart';
import 'package:sns_for_portfolio/presentation/ui/component/app_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Signin screen"),
          AppButton(onPressed: () {
            FeedRouteData().go(context);
          }, child: Text("Go to main")),
        ],
      )),
    );
  }
}
