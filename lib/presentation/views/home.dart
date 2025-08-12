import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
     HomePage({super.key});

  final ThemeController themeController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Capstone'),
        actions: [
          Obx(() {
            return IconButton(
              icon: Icon(
                themeController.isDarkMode.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: () {
                themeController.toggleTheme();
              },
            );
          }),
        ],
      ),
      body: Center(
        child: Text(
          'Hello Capstone!',
          style: TextStyle(fontSize: Responsive.fontSize(5)),
        ),
      ),
    );
  }
}
