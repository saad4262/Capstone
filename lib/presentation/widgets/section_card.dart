import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget sectionCard({
  required bool isDark,
  required String title,
  required IconData icon,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(Responsive.width(5)),
    decoration: BoxDecoration(
      color: isDark ? Colors.grey[850] : Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: isDark
              ? Colors.black.withOpacity(0.3)
              : Colors.grey.withOpacity(0.1),
          blurRadius: 15,
          offset: const Offset(0, 5),
          spreadRadius: 2,
        ),
      ],
      border: Border.all(
        color: isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.grey.withOpacity(0.2),
        width: 1,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(Responsive.width(2.5)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gradientStart.withOpacity(0.8),
                    AppColors.gradientEnd.withOpacity(0.8),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: FaIcon(
                icon,
                color: Colors.white,
                size: Responsive.fontSize(4.5),
              ),
            ),
            SizedBox(width: Responsive.width(3)),
            Text(
              title,
              style: TextStyle(
                fontSize: Responsive.fontSize(5),
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : Colors.black87,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.height(3)),
        ...children,
      ],
    ),
  );
}
