import 'package:flutter/material.dart';
import 'package:sns_for_portfolio/app/router/router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Signin screen"),
          ElevatedButton(onPressed: () {
            FeedRouteData().go(context);
          }, child: Text("Go to main")),
        ],
      )),
    );
  }
}
