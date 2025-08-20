import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isDark;
  final bool? isobsecure;
  final IconData? prefixIcon;

  const InputField({
    required this.label,
    required this.controller,
    required this.isDark,
    this.isobsecure,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        obscureText: isobsecure ?? false,
        controller: controller,
        style: TextStyle(
          fontSize: Responsive.fontSize(4.2),
          fontFamily: 'Poppins',
          color: isDark ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontSize: Responsive.fontSize(4),
            fontFamily: 'Poppins',
            color: isDark ? Colors.grey[400] : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: prefixIcon != null
              ? Container(
                  margin: EdgeInsets.all(Responsive.width(2)),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.gradientStart.withOpacity(0.8),
                        AppColors.gradientEnd.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    prefixIcon,
                    color: Colors.white,
                    size: Responsive.fontSize(4.5),
                  ),
                )
              : null,
          filled: true,
          fillColor: isDark ? Colors.grey[800] : Colors.grey[50],
          contentPadding: EdgeInsets.symmetric(
            horizontal: Responsive.width(5),
            vertical: Responsive.height(2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.grey.withOpacity(0.3),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: AppColors.gradientStart, width: 2),
          ),
        ),
      ),
    );
  }
}
