 import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

Widget divider(bool isDark) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Responsive.height(1)),
      height: 1,
      color: isDark
          ? Colors.white.withOpacity(0.1)
          : Colors.grey.withOpacity(0.2),
    );
  }
