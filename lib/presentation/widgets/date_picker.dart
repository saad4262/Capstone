import 'package:capstone/shared/constants/app_colors.dart';
import 'package:capstone/shared/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget buildDatePicker(
  BuildContext context,
  String label,
  DateTime date,
  void Function(DateTime?) onDatePicked, {
  DateTime? firstDate,
}) {
  final formattedDate = DateFormat('EEE, yyyy-MM-dd').format(date);
  final theme = Theme.of(context);
  final isDark = theme.brightness == Brightness.dark;

  return Container(
    padding: EdgeInsets.all(Responsive.width(4)),
    margin: EdgeInsets.symmetric(vertical: Responsive.height(1)),
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
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: Responsive.fontSize(3.5),
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(height: Responsive.height(0.5)),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: Responsive.fontSize(3.5),
                  fontWeight: FontWeight.w500,
                  color: theme.textTheme.bodyLarge?.color,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.gradientStart, AppColors.gradientEnd],
            ),
            borderRadius: BorderRadius.circular(Responsive.radius(3)),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: firstDate ?? DateTime.now(), // aj se pehle disable
                lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
              );
              if (picked != null) {
                onDatePicked(picked);
              }
            },
            child: Text(
              "Pick",
              style: TextStyle(
                fontSize: Responsive.fontSize(3.5),
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
