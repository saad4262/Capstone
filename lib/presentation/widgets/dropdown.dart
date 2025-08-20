import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget buildDropdown(
  String label,
  String? currentValue,
  List<String> options,
  void Function(String?) onChanged, {
  bool capitalizeItems = false,
}) {
  return Builder(
    builder: (context) {
      final theme = Theme.of(context);
      final isDark = theme.brightness == Brightness.dark;

      return Container(
        height: Responsive.height(10),
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.padding(5)),
          child: DropdownButtonFormField<String>(
            value: currentValue,
            isExpanded: true,
            isDense: true,

            decoration: InputDecoration(
              labelText: label,

              labelStyle: TextStyle(
                fontSize: Responsive.fontSize(3.8),
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                fontFamily: 'Poppins',
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: Responsive.width(4),
                vertical: Responsive.height(2),
              ),
            ),
            items: options
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      capitalizeItems ? (e.capitalizeFirst ?? e) : e,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Responsive.fontSize(4),
                        fontFamily: 'Poppins',
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      );
    },
  );
}
