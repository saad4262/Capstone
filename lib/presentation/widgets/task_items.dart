 import 'dart:ui';

import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

Widget taskItems(Color color, String text) {
    return Row(
      children: [
        Container(
          width: Responsive.width(4),
          height: Responsive.width(4),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: Responsive.width(2)),
        Text(
          text,
          style: TextStyle(
            fontSize: Responsive.fontSize(3),
            fontFamily: "poppins",
          ),
        ),
      ],
    );
  }