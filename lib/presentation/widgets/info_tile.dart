import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget infoTile({
  required bool isDark,
  required String title,
  required String value,
  required IconData icon,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: Responsive.height(1.5),
      horizontal: Responsive.width(2),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(Responsive.width(2)),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FaIcon(
            icon,
            color: isDark ? Colors.white70 : Colors.grey[600],
            size: Responsive.fontSize(4),
          ),
        ),
        SizedBox(width: Responsive.width(3)),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: Responsive.fontSize(4.2),
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black87,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: Responsive.fontSize(4),
            color: isDark ? Colors.white70 : Colors.grey[600],
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
