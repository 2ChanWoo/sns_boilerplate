import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page Not Found"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("페이지를 찾을 수 없습니다."),
            const SizedBox(height: 30),
            TextButton(onPressed: () => context.pop(), child: const Text("돌아가기 (Back)")),
          ],
        ),
      ),
    );
  }
}