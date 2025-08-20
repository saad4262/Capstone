  import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget favourCard(Color color, String label, IconData icon, bool isDark) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.width(3),
        vertical: Responsive.height(0.8),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withOpacity(0.8)]),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(icon, color: Colors.white, size: Responsive.fontSize(3)),
          SizedBox(width: Responsive.width(1.5)),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: Responsive.fontSize(3),
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
