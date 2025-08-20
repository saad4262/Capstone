import 'package:capstone/presentation/widgets/user_avtar.dart';
import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

Widget profileHeader(bool isDark, dynamic user) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.width(6)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [
                  AppColors.gradientStart.withOpacity(0.8),
                  AppColors.gradientEnd.withOpacity(0.8),
                ]
              : [AppColors.gradientStart, AppColors.gradientEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.gradientStart.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          AvatarSection(),
          SizedBox(height: Responsive.height(2)),
          Text(
            user.displayName.isNotEmpty ? user.displayName : "User",
            style: TextStyle(
              fontSize: Responsive.fontSize(6),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: Responsive.height(0.5)),
          Text(
            user.email,
            style: TextStyle(
              fontSize: Responsive.fontSize(4),
              color: Colors.white.withOpacity(0.9),
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: Responsive.height(2)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.width(4),
              vertical: Responsive.height(1),
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Capstone Member",
              style: TextStyle(
                fontSize: Responsive.fontSize(3.5),
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
