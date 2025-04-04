import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Main Screen'),
            ElevatedButton(
              onPressed: () => Get.toNamed('/second'),
              child: Text('Go to Second Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
