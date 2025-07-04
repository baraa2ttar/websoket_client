import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:websoket/view/home_screen/price_track_controller.dart';

class PriceViewPage extends StatelessWidget {
  final PriceTrackerController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              'Current Price: ${controller.currentPrice.value}',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () => Text(
              'Last Updated: ${controller.lastUpdate.value}',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
