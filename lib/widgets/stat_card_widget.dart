import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websoket/core/constant/app_color.dart';

class StatCardWidget extends StatelessWidget {
  final String title;
  final RxDouble value;
  final IconData icon;
  final Color color;

  const StatCardWidget({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            title,
            style: Get.textTheme.bodySmall?.copyWith(
              color: AppColor.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Obx(
            () => Text(
              '\$${value.value.toStringAsFixed(2)}',
              style: Get.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColor.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
