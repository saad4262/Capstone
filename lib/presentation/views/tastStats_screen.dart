import 'package:capstone/domain/viewmodels/taskStats_controller.dart';
import 'package:capstone/presentation/widgets/task_items.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

class TaskStatsScreen extends StatelessWidget {
  final TaskStatsController controller = Get.put(TaskStatsController());

  TaskStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final total =
          controller.inProgressCount.value +
          controller.pendingCount.value +
          controller.acceptedCount.value;

      double percent(int value) => total == 0 ? 0 : (value / total) * 100;

      return Padding(
        padding: EdgeInsets.only(top: Responsive.padding(07)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                taskItems(Colors.green, "Complete"),
                SizedBox(width: Responsive.width(5)),
                taskItems(Colors.blue, "Review"),
                SizedBox(width: Responsive.width(5)),
                taskItems(Colors.orange, "Pending"),
              ],
            ),
            SizedBox(height: Responsive.height(2)),

            SizedBox(
              height: Responsive.height(25),
              child: PieChart(
                PieChartData(
                  sectionsSpace: 3,
                  centerSpaceRadius: Responsive.width(12),
                  sections: [
                    PieChartSectionData(
                      color: Colors.green,
                      value: controller.acceptedCount.value.toDouble(),
                      title:
                          "${percent(controller.acceptedCount.value).toStringAsFixed(1)}%",
                      radius: Responsive.width(15),
                      titleStyle: TextStyle(
                        fontSize: Responsive.fontSize(4),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.blue,
                      value: controller.inProgressCount.value.toDouble(),
                      title:
                          "${percent(controller.inProgressCount.value).toStringAsFixed(1)}%",
                      radius: Responsive.width(15),
                      titleStyle: TextStyle(
                        fontSize: Responsive.fontSize(4),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      color: Colors.orange,
                      value: controller.pendingCount.value.toDouble(),
                      title:
                          "${percent(controller.pendingCount.value).toStringAsFixed(1)}%",
                      radius: Responsive.width(15),
                      titleStyle: TextStyle(
                        fontSize: Responsive.fontSize(4),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

 

}
