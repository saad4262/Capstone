import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget staticsHeader(bool isDark) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: Responsive.width(4)),
    padding: EdgeInsets.all(Responsive.padding(4)),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [AppColors.gradientStart, AppColors.gradientEnd],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: AppColors.gradientStart.withOpacity(0.3),
          blurRadius: 15,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.padding(3)),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: FaIcon(
            FontAwesomeIcons.chartLine,
            color: Colors.white,
            size: Responsive.fontSize(6),
          ),
        ),
        SizedBox(width: Responsive.width(4)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detailed Statistics",
                style: TextStyle(
                  fontSize: Responsive.fontSize(5.5),
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: Responsive.height(0.5)),
              Text(
                "Task Analysis",
                style: TextStyle(
                  fontSize: Responsive.fontSize(3.8),
                  color: Colors.white.withOpacity(0.9),
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
