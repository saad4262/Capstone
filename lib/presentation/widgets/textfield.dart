import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

Widget buildTextField(
  String label,
  TextEditingController controller, {
  int maxLines = 1,
  ValueChanged<String>? onChanged,
}) {
  return Builder(
    builder: (context) {
      final theme = Theme.of(context);
      final isDark = theme.brightness == Brightness.dark;

      return Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(Responsive.radius(5)),

          border: Border.all(
            width: 2,
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.withOpacity(0.3),
          ),
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          style: TextStyle(
            fontSize: Responsive.fontSize(4),
            fontFamily: 'Poppins',
            color: theme.textTheme.bodyLarge?.color,
          ),
          decoration: InputDecoration(
            hintText: label,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              fontSize: Responsive.fontSize(3.8),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: Responsive.width(4),
              vertical: Responsive.height(2),
            ),
          ),
        ),
      );
    },
  );
}
