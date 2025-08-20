import 'package:capstone/domain/viewmodels/darkmode_controller.dart';
import 'package:capstone/domain/viewmodels/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';

class CustomAppBar extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());
  final ThemeController themeController = Get.put(ThemeController());

  final String title;
  final VoidCallback? onMenuPressed;

  CustomAppBar({super.key, required this.title, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Responsive.width(7)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // InkWell(
            //   onTap: () {
            //      Obx(
            //             () => _buildDropdown(
            //               'Theme Mode',
            //               themeController.isDarkMode.value ? 'dark' : 'light',
            //               ['light', 'dark'],
            //               (val) {
            //                 if (val == 'light') {
            //                   themeController.toggleTheme();
            //                 } else {
            //                   themeController.toggleTheme();
            //                 }
            //                 Get.back();
            //               },
            //             ),

            //         );

            //   },
            //   child: Icon(Icons.menu, size: Responsive.fontSize(6)),
            // ),
            // InkWell(
            //   onTap: () {
            //     Get.back();
            //   },
            //   child: PopupMenuButton<String>(
            //     padding: EdgeInsetsGeometry.all(10),
            //     borderRadius: BorderRadius.circular(30),
            //     position: PopupMenuPosition.under,
            //     offset: const Offset(0, 30),

            //     icon: Icon(Icons.menu, size: Responsive.fontSize(6)),
            //     onSelected: (val) {
            //       if (val == 'light' && themeController.isDarkMode.value) {
            //         themeController.toggleTheme();
            //       } else if (val == 'dark' &&
            //           !themeController.isDarkMode.value) {
            //         themeController.toggleTheme();
            //       }
            //     },
            //     itemBuilder: (context) => [
            //       PopupMenuItem(value: 'light', child: Text('Light Mode')),
            //       PopupMenuItem(value: 'dark', child: Text('Dark Mode')),
            //     ],
            //   ),
            // ),
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: FaIcon(FontAwesomeIcons.barsStaggered),
            ),
            // Menu icon
            // InkWell(
            //   onTap: () {
            //     Obx(
            //       () => GestureDetector(
            //         child: _buildDropdown(
            //           'Dark Mode',
            //           taskController.category.value,
            //           ['light', 'dark'],
            //           (val) => taskController.setCategory(val ?? 'light'),
            //         ),
            //       ),
            //     );

            //     //     showDialog(
            //     //       context: context,
            //     //       builder: (BuildContext dialogContext) => AlertDialog(
            //     //         backgroundColor: Theme.of(context).cardColor,
            //     //         shape: RoundedRectangleBorder(
            //     //           borderRadius: BorderRadius.circular(16),
            //     //         ),
            //     //         title: Text(
            //     //           'Dark Mode',
            //     //           style: TextStyle(
            //     //             fontSize: Responsive.fontSize(5),
            //     //             fontWeight: FontWeight.w600,
            //     //             fontFamily: "Poppins",
            //     //             color: Theme.of(context).textTheme.headlineSmall?.color,
            //     //           ),
            //     //         ),

            //     //         actions: [

            //     //           Obx(() {
            //     //   return IconButton(
            //     //     icon: Icon(
            //     //       themeController.isDarkMode.value
            //     //           ? Icons.dark_mode
            //     //           : Icons.light_mode,
            //     //       size: Responsive.fontSize(6),
            //     //     ),
            //     //     onPressed: () {
            //     //       themeController.toggleTheme();
            //     //     },
            //     //   );
            //     // }),
            //     //         ],
            //     //       ),
            //     //     );
            //   },
            //   child: Icon(Icons.menu, size: Responsive.fontSize(6)),
            // ),

            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: Responsive.fontSize(6),
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),

            Obx(() {
              return IconButton(
                icon: Icon(
                  themeController.isDarkMode.value
                      ? Icons.dark_mode
                      : Icons.light_mode,
                  size: Responsive.fontSize(6),
                ),
                onPressed: () {
                  themeController.toggleTheme();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

// Widget _buildDropdown(
//   String label,
//   String? currentValue,
//   List<String> options,
//   void Function(String?) onChanged, {
//   bool capitalizeItems = false,
// }) {
//   return Builder(
//     builder: (context) {
//       final theme = Theme.of(context);
//       final isDark = theme.brightness == Brightness.dark;

//       return Container(
//         decoration: BoxDecoration(
//           color: theme.cardColor,
//           borderRadius: BorderRadius.circular(Responsive.width(4)),
//           border: Border.all(
//             color: isDark
//                 ? Colors.white.withOpacity(0.1)
//                 : Colors.grey.withOpacity(0.3),
//           ),
//         ),
//         child: DropdownButtonFormField<String>(
//           value: currentValue,
//           isExpanded: true,
//           decoration: InputDecoration(
//             labelText: label,
//             labelStyle: TextStyle(
//               fontSize: Responsive.fontSize(3.8),
//               color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
//               fontFamily: 'Poppins',
//             ),
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.symmetric(
//               horizontal: Responsive.width(4),
//               vertical: Responsive.height(2),
//             ),
//           ),
//           items: options
//               .map(
//                 (e) => DropdownMenuItem(
//                   value: e,
//                   child: Text(
//                     capitalizeItems ? (e.capitalizeFirst ?? e) : e,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: Responsive.fontSize(4),
//                       fontFamily: 'Poppins',
//                       color: theme.textTheme.bodyLarge?.color,
//                     ),
//                   ),
//                 ),
//               )
//               .toList(),
//           onChanged: onChanged,
//         ),
//       );
//     },
//   );
// }
