import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websoket/view/home_screen/Home_controller/price_track_controller.dart';
import 'package:websoket/widgets/price_header_widget.dart';
import 'package:websoket/widgets/current_price_card_widget.dart';
import 'package:websoket/widgets/statistics_row_widget.dart';
import 'package:websoket/widgets/price_chart_widget.dart';

class PriceViewPage extends StatelessWidget {
  final PriceTrackerController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with connection status
              PriceHeaderWidget(controller: controller),
              const SizedBox(height: 24),

              // Current price card
              CurrentPriceCardWidget(controller: controller),
              const SizedBox(height: 20),

              // Statistics cards row
              StatisticsRowWidget(controller: controller),
              const SizedBox(height: 20),

              // Price chart
              Expanded(child: PriceChartWidget(controller: controller)),
            ],
          ),
        ),
      ),
    );
  }
}
