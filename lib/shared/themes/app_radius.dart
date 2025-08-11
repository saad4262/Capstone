import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';

class AppRadius {
  static double small(BuildContext context) => Responsive.radius(6.0);
  static double normal(BuildContext context) => Responsive.radius(12.0);
  static double large(BuildContext context) => Responsive.radius(20.0);
}
