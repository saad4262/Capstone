import 'package:capstone/domain/viewmodels/dashboard_controller.dart';
import 'package:capstone/presentation/widgets/statics_card.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

Widget taskData(bool isDark) {
  final DashboardController controller = Get.put(DashboardController());

  return Obx(() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Responsive.width(4)),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 15,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.0,
        children: [
          staticsCard(
            "Pending Tasks",
            controller.pendingCount,
            Colors.orange,
            FontAwesomeIcons.clock,
            isDark,
          ),
          staticsCard(
            "Under Review",
            controller.reviewCount,
            Colors.blue,
            FontAwesomeIcons.searchengin,
            isDark,
          ),
          staticsCard(
            "Completed",
            controller.completedCount,
            Colors.green,
            FontAwesomeIcons.checkCircle,
            isDark,
          ),
          staticsCard(
            "Total Tasks",
            controller.totalCount,
            Colors.purple,
            FontAwesomeIcons.tasks,
            isDark,
          ),
        ],
      ),
    );
  });
}
