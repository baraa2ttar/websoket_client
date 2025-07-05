import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websoket/core/constant/app_color.dart';
import 'package:websoket/view/home_screen/Home_controller/price_track_controller.dart';

class CurrentPriceCardWidget extends StatelessWidget {
  final PriceTrackerController controller;

  const CurrentPriceCardWidget({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: AppColor.primaryGradient,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Current Price',
            style: Get.textTheme.titleMedium?.copyWith(
              color: AppColor.white.withOpacity(0.8),
            ),
          ),
          const SizedBox(height: 8),
          Obx(
            () => Text(
              '\$${controller.currentPrice.value}',
              style: Get.textTheme.displayMedium?.copyWith(
                color: AppColor.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => _buildPriceChangeIndicator()),
        ],
      ),
    );
  }

  Widget _buildPriceChangeIndicator() {
    if (controller.priceChange.value == 0) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.remove, color: AppColor.white.withOpacity(0.7), size: 20),
          const SizedBox(width: 4),
          Text(
            'No change',
            style: TextStyle(
              color: AppColor.white.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
    }

    bool isPositive = controller.priceChange.value > 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isPositive ? Icons.trending_up : Icons.trending_down,
          color: AppColor.white,
          size: 20,
        ),
        const SizedBox(width: 4),
        Text(
          '${isPositive ? '+' : ''}\$${controller.priceChange.value.toStringAsFixed(2)} (${controller.priceChangePercent.value.toStringAsFixed(2)}%)',
          style: TextStyle(
            color: AppColor.white,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
