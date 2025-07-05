import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websoket/core/constant/app_color.dart';
import 'package:websoket/view/home_screen/Home_controller/price_track_controller.dart';

class PriceHeaderWidget extends StatelessWidget {
  final PriceTrackerController controller;

  const PriceHeaderWidget({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price Tracker',
              style: Get.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Obx(
              () => Text(
                'Last updated: ${controller.lastUpdate.value}',
                style: Get.textTheme.bodySmall?.copyWith(
                  color: AppColor.textSecondary,
                ),
              ),
            ),
          ],
        ),
        Obx(() => _buildConnectionStatus()),
      ],
    );
  }

  Widget _buildConnectionStatus() {
    Color statusColor;
    IconData statusIcon;

    if (controller.isConnected.value) {
      statusColor = AppColor.success;
      statusIcon = Icons.wifi;
    } else if (controller.isLoading.value) {
      statusColor = AppColor.warning;
      statusIcon = Icons.wifi_find;
    } else {
      statusColor = AppColor.error;
      statusIcon = Icons.wifi_off;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 16, color: statusColor),
          const SizedBox(width: 6),
          Text(
            controller.connectionStatus.value,
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
