import 'package:capstone/domain/viewmodels/bottomnav_controller.dart';
import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/domain/viewmodels/task_controller.dart';
import 'package:capstone/presentation/views/add_task_screen.dart';
import 'package:capstone/presentation/views/dashboard_screen.dart';
import 'package:capstone/presentation/views/editprofile_screen.dart';
import 'package:capstone/presentation/views/favourite_screen.dart';
import 'package:capstone/presentation/views/task_screen.dart';
import 'package:capstone/presentation/widgets/bottom_navbar.dart';
import 'package:capstone/presentation/widgets/custom_drawer.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final BottomNavController navController = Get.put(BottomNavController());

  final TaskController taskController = Get.find<TaskController>();
  final ThemeController themeController = Get.find();
  final userID = FirebaseAuth.instance.currentUser!.uid;

  final TaskScreen t = TaskScreen();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userID = FirebaseAuth.instance.currentUser!.uid;
    final List<Widget> pages = [
      Center(child: DashboardScreen()),

      Center(child: TaskScreen()),
      const Center(child: Text("Add Task")),
      Center(child: FavouriteScreen(userId: userID)),
      Center(child: ProfileScreen()),
    ];
    return Obx(() {

      return Scaffold(
        drawer: CustomDrawer(),
        resizeToAvoidBottomInset: false,

        body: pages[navController.currentIndex.value],
        bottomNavigationBar: CustomBottomNav(
          onTabSelected: (index) => navController.changeIndex(index),
        ),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TaskFormPage(task: null)),
              );
            },
            backgroundColor: Colors.transparent,
            child: const Icon(Icons.add),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
    });
  }
}
