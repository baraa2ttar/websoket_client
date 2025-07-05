import 'package:flutter/material.dart';
import 'package:websoket/core/constant/app_color.dart';
import 'package:websoket/view/home_screen/Home_controller/price_track_controller.dart';
import 'package:websoket/widgets/stat_card_widget.dart';

class StatisticsRowWidget extends StatelessWidget {
  final PriceTrackerController controller;

  const StatisticsRowWidget({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCardWidget(
            title: 'Highest',
            value: controller.highestPrice,
            icon: Icons.trending_up,
            color: AppColor.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCardWidget(
            title: 'Lowest',
            value: controller.lowestPrice,
            icon: Icons.trending_down,
            color: AppColor.error,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCardWidget(
            title: 'Average',
            value: controller.averagePrice,
            icon: Icons.analytics,
            color: AppColor.info,
          ),
        ),
      ],
    );
  }
}
