import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen Test'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.offAllNamed('/'); // Navigate back to the main screen
          },
          child: const Text('Go Back to Main Screen'),
        ),
      ),
    );
  }
}