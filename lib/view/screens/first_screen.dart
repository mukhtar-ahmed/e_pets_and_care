import 'package:e_pets_and_care/Controller/first_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FirstScreen extends StatelessWidget {
  static const String id = '/first_screen';
  FirstScreenController firstScreenController =
      Get.put(FirstScreenController());
  FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
          child: Image(
        image: AssetImage('images/logo.png'),
      )),
    );
  }
}
